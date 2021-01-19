const express = require("express");
const http = require("http");
const https = require("https");
const Bowser = require("bowser");
const morgan = require("morgan");
const fs = require("fs");
const { postgraphile } = require("postgraphile");
const postgraphileOptions = require("./postgraphile/postgraphileOptions");
const authenticationPgSettings = require("./postgraphile/authenticationPgSettings");
const nextjs = require("next");
const crypto = require("crypto");
const port = Number.parseInt(process.env.PORT, 10) || 3004;
const dev = process.env.NODE_ENV !== "production";
const app = nextjs({ dev });
const handle = app.getRequestHandler();
const session = require("express-session");
const PgSession = require("connect-pg-simple")(session);
const bodyParser = require("body-parser");
const Keycloak = require("keycloak-connect");
const cors = require("cors");
const { getUserGroupLandingRoute } = require("../lib/user-groups");
const { getUserGroups } = require("./helpers/userGroupAuthentication");
const UNSUPPORTED_BROWSERS = require("../data/unsupported-browsers");
const path = require("path");
const namespaceMap = require("../data/kc-namespace-map");
const cookieParser = require("cookie-parser");
const databaseConnectionService = require("./db/databaseConnectionService");

/**
 * Override keycloak accessDenied handler to redirect to our 403 page
 */
Keycloak.prototype.accessDenied = ({ res }) => res.redirect("/403");

// True if the host has been configured to use https
const secure = /^https/.test(process.env.HOST);

// Ensure we properly crypt our cookie session store with a pre-shared key in a secure environment
if (secure && typeof process.env.SESSION_SECRET !== typeof String())
  throw new Error("export SESSION_SECRET to encrypt session cookies");
if (secure && process.env.SESSION_SECRET.length < 24)
  throw new Error("exported SESSION_SECRET must be at least 24 characters");
if (!process.env.SESSION_SECRET)
  console.warn("SESSION_SECRET missing from environment");
const secret = process.env.SESSION_SECRET || crypto.randomBytes(32).toString();

const pgPool = databaseConnectionService.createConnectionPool();

const getRedirectURL = (req) => {
  if (req.query.redirectTo) return req.query.redirectTo;

  const groups = getUserGroups(req);

  return getUserGroupLandingRoute(groups);
};

app.prepare().then(async () => {
  const server = express();

  server.use(
    morgan("combined", {
      skip: function (_, res) {
        return res.statusCode < 400;
      },
    })
  );

  // Enable serving ACME HTTP-01 challenge response written to disk by acme.sh
  // https://letsencrypt.org/docs/challenge-types/#http-01-challenge
  // https://github.com/acmesh-official/acme.sh
  server.use(
    "/.well-known",
    express.static(path.resolve(__dirname, "../.well-known"))
  );
  server.use(bodyParser.json({ limit: "50mb" }));
  server.use(cors());

  // Tell search + crawlers not to index non-production environments:
  server.use(({ res, next }) => {
    if (!process.env.NAMESPACE || !process.env.NAMESPACE.endsWith("-prod")) {
      res.append("X-Robots-Tag", "noindex, noimageindex, nofollow, noarchive");
    }

    next();
  });

  // Renders a static info page on unsupported browsers.
  // Files in /static/ are excluded.
  // TODO: files are not in /static anymore but in /
  server.use("/", (req, res, next) => {
    if (req.path.startsWith("/static/")) return next();

    const browser = Bowser.getParser(req.get("User-Agent"));
    const isUnsupported = browser.satisfies(UNSUPPORTED_BROWSERS);
    if (isUnsupported) res.redirect("/update-browser.html");
    else next();
  });

  const store = new PgSession({
    pool: pgPool,
    schemaName: "ggircs_app_private",
    tableName: "connect_session",
  });
  server.use(
    session({
      secret,
      resave: false,
      saveUninitialized: true,
      cookie: { secure },
      store,
    })
  );

  // Keycloak instantiation for dev/test/prod
  const kcNamespace = process.env.NAMESPACE
    ? namespaceMap[process.env.NAMESPACE]
    : "dev.";
  const kcConfig = {
    realm: "pisrwwhx",
    "auth-server-url": `https://${kcNamespace}oidc.gov.bc.ca/auth`,
    "ssl-required": "external",
    resource: "cas-ggircs-app",
    "public-client": true,
    "confidential-port": 0,
  };

  const keycloak = new Keycloak({ store }, kcConfig);

  // Nuke the siteminder session token on logout if we can
  // this will be ignored by the user agent unless we're
  // currently deployed to a subdomain of gov.bc.ca
  server.post("/logout", (_req, res, next) => {
    res.clearCookie("SMSESSION", { domain: ".gov.bc.ca", secure: true });
    next();
  });

  // Retrieves keycloak grant for the session
  server.use(
    keycloak.middleware({
      logout: "/logout",
      admin: "/",
    })
  );

  // Returns the time, in seconds, before the refresh_token expires.
  // This corresponds to the SSO idle timeout configured in keycloak.
  server.get("/session-idle-remaining-time", async (req, res) => {
    // if (
    //   NO_AUTH ||
    //   AS_ADMIN ||
    //   AS_ANALYST ||
    //   AS_PENDING ||
    //   AS_REPORTER ||
    //   AS_CERTIFIER ||
    //   AS_CYPRESS
    // ) {
    //   return res.json(3600);
    // }

    if (!req.kauth || !req.kauth.grant) {
      return res.json(null);
    }

    const grant = await keycloak.getGrant(req, res);
    return res.json(
      Math.round(grant.refresh_token.content.exp - Date.now() / 1000)
    );
  });

  // For any request (other than getting the remaining idle time), refresh the grant
  // if needed. If the access token is expired (defaults to 5min in keycloak),
  // the refresh token will be used to get a new access token, and the refresh token expiry will be updated.
  server.use(async (req, res, next) => {
    if (req.path === "/session-idle-remaining-time") return next();
    if (req.kauth && req.kauth.grant) {
      try {
        const grant = await keycloak.getGrant(req, res);
        await keycloak.grantManager.ensureFreshness(grant);
      } catch (error) {
        return next(error);
      }
    }

    next();
  });

  server.use(cookieParser());

  server.use(
    postgraphile(pgPool, process.env.DATABASE_SCHEMA || "ggircs_app", {
      ...postgraphileOptions(),
      pgSettings: (req) => {
        const opts = {
          ...authenticationPgSettings(req),
        };
        return opts;
      },
    })
  );

  server.post("/login", keycloak.protect(), (req, res) =>
    // This request handler gets called on a POST to /login if the user is already authenticated
    res.redirect(302, getRedirectURL(req))
  );

  // Keycloak callbak; do not keycloak.protect() to avoid users being authenticated against their will via XSS attack
  server.get("/login", (req, res) => res.redirect(302, getRedirectURL(req)));

  server.get("*", async (req, res) => {
    return handle(req, res);
  });

  if (secure) {
    const domain = /^https:\/\/(.+?)\/?$/.exec(process.env.HOST)[1];
    const key = fs.readFileSync(
      `/root/.acme.sh/${domain}/${domain}.key`,
      "utf8"
    );
    const cert = fs.readFileSync(
      `/root/.acme.sh/${domain}/fullchain.cer`,
      "utf8"
    );
    const options = { key, cert };
    https.createServer(options, server).listen(port, (err) => {
      if (err) {
        throw err;
      }

      console.log(`> Ready on https://localhost:${port}`);
    });
  } else {
    http.createServer(server).listen(port, (err) => {
      if (err) {
        throw err;
      }

      console.log(`> Ready on http://localhost:${port}`);
    });
  }

  process.on("SIGTERM", () => {
    console.info("SIGTERM signal received.");
    console.log("Closing http server.");
    server.close(() => {
      console.log("Http server closed.");
      pgPool.end(() => {
        console.log("Database connection closed.");
        process.exit(0);
      });
    });
  });
});
