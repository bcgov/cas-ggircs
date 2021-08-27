const express = require("express");
const http = require("http");
const https = require("https");
const path = require("path");
const fs = require("fs");
const Bowser = require("bowser");
const morgan = require("morgan");
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const cors = require("cors");
const nextjs = require("next");
const { postgraphile } = require("postgraphile");
const postgraphileOptions = require("./postgraphile/postgraphileOptions");
const authenticationPgSettings = require("./postgraphile/authenticationPgSettings");
const { ssoRouter } = require("./routers/sso");
const { ecccApiRouter } = require("./routers/api/eccc");

const port = Number.parseInt(process.env.PORT, 10) || 3004;
const dev = process.env.NODE_ENV !== "production";
const app = nextjs({ dev });
const handle = app.getRequestHandler();
const UNSUPPORTED_BROWSERS = require("../data/unsupported-browsers");
const { dbPool } = require("./storage/db");

const secure = /^https/.test(process.env.HOST);

app.prepare().then(async () => {
  const server = express();

  server.use(
    morgan("combined", {
      skip: (_, res) => res.statusCode < 400,
    })
  );

  // Enable serving ACME HTTP-01 challenge response written to disk by acme.sh
  // https://letsencrypt.org/docs/challenge-types/#http-01-challenge
  // https://github.com/acmesh-official/acme.sh
  server.use(
    "/.well-known",
    express.static(path.resolve(__dirname, "../.well-known"))
  );

  server.use(ssoRouter);
  server.use("/api/eccc", ecccApiRouter);

  server.use(bodyParser.json({ limit: "50mb" }));
  server.use(cors());

  // Tell search + crawlers not to index this application (internal tool)
  server.use(({ res, next }) => {
    res.append("X-Robots-Tag", "noindex, noimageindex, nofollow, noarchive");
    next();
  });

  // Renders a static info page on unsupported browsers.
  // Files in /static/ are excluded.
  // TODO: files are not in /static anymore but in /
  server.use("/", (req, res, next) => {
    if (req.path.startsWith("/static/")) {
      next();
      return;
    }

    const browser = Bowser.getParser(req.get("User-Agent"));
    const isUnsupported = browser.satisfies(UNSUPPORTED_BROWSERS);
    if (isUnsupported) res.redirect("/update-browser.html");
    else next();
  });

  server.use(cookieParser());

  const ggircsAppSchema = process.env.DATABASE_SCHEMA || "ggircs_app";
  const swrsHistorySchema = process.env.SWRS_HISTORY_SCHEMA || "swrs_history";
  const swrsExtractSchema = process.env.SWRS_EXTRACT_SCHEMA || "swrs_extract";

  server.use(
    postgraphile(
      dbPool,
      [ggircsAppSchema, swrsHistorySchema, swrsExtractSchema],
      {
        ...postgraphileOptions(),
        pgSettings: (req) => {
          const opts = {
            ...authenticationPgSettings(req),
          };
          return opts;
        },
      }
    )
  );

  server.get("*", async (req, res) => handle(req, res));

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
      dbPool.end(() => {
        console.log("Database connection closed.");
        process.exit(0);
      });
    });
  });
});
