const express = require("express");
const Keycloak = require("keycloak-connect");
const crypto = require("crypto");
const session = require("express-session");
const PgSession = require("connect-pg-simple")(session);
const dotenv = require("dotenv");
const { getUserGroupLandingRoute } = require("../../lib/user-groups");
const { getUserGroups } = require("../helpers/userGroupAuthentication");
const { dbPool } = require("../storage/db");

dotenv.config();

const ssoRouter = express.Router();

const AS_CYPRESS = process.argv.includes("AS_CYPRESS");
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

const store = new PgSession({
  pool: dbPool,
  schemaName: "ggircs_app_private",
  tableName: "connect_session",
});
ssoRouter.use(
  session({
    secret,
    resave: false,
    saveUninitialized: true,
    cookie: { secure },
    store,
  })
);

let kcNamespace = "";
if (!process.env.NAMESPACE) {
  kcNamespace = "dev.";
}
if (process.env.NAMESPACE && !process.env.NAMESPACE.endsWith("-prod")) {
  kcNamespace = `${process.env.NAMESPACE.split("-")[1]}.`;
}

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
ssoRouter.post("/logout", (_req, res, next) => {
  res.clearCookie("SMSESSION", { domain: ".gov.bc.ca", secure: true });
  next();
});

// Retrieves keycloak grant for the session
ssoRouter.use(
  keycloak.middleware({
    logout: "/logout",
    admin: "/",
  })
);

// Returns the time, in seconds, before the refresh_token expires.
// This corresponds to the SSO idle timeout configured in keycloak.
ssoRouter.get("/session-idle-remaining-time", async (req, res) => {
  if (AS_CYPRESS) {
    return res.json(3600);
  }
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
ssoRouter.use(async (req, res, next) => {
  if (req.path === "/session-idle-remaining-time") return next();
  if (req.kauth && req.kauth.grant) {
    try {
      const grant = await keycloak.getGrant(req, res);
      await keycloak.grantManager.ensureFreshness(grant);
    } catch (error) {
      return next(error);
    }
  }

  return next();
});

const getRedirectURL = (req) => {
  if (req.query.redirectTo) return req.query.redirectTo;

  const groups = getUserGroups(req);

  return getUserGroupLandingRoute(groups);
};

ssoRouter.post("/login", keycloak.protect(), (req, res) =>
  // This request handler gets called on a POST to /login if the user is already authenticated
  res.redirect(302, getRedirectURL(req))
);

// Keycloak callbak; do not keycloak.protect() to avoid users being authenticated against their will via XSS attack
ssoRouter.get("/login", (req, res) => res.redirect(302, getRedirectURL(req)));

module.exports = { ssoRouter, keycloak };
