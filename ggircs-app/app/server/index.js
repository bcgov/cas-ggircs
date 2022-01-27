const express = require("express");
const http = require("http");
const Bowser = require("bowser");
const morgan = require("morgan");
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const cors = require("cors");
const nextjs = require("next");
const { createLightship } = require("lightship");
const delay = require("delay");
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

app.prepare().then(async () => {
  const server = express();

  // nginx proxy is running in the same pod
  server.set("trust proxy", "loopback");

  const lightship = createLightship();

  lightship.registerShutdownHandler(async () => {
    await delay(10000);
    await new Promise((resolve) => {
      server.close(() => dbPool.end(resolve));
    });
  });

  server.use(
    morgan("combined", {
      skip: (_, res) => res.statusCode < 400,
    })
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
  const swrsSchema = process.env.SWRS_SCHEMA || "swrs";
  const swrsUtilitySchema = process.env.SWRS_UTILITY_SCHEMA || "swrs_utility";

  server.use(
    postgraphile(
      dbPool,
      [ggircsAppSchema, swrsHistorySchema, swrsExtractSchema, swrsSchema, swrsUtilitySchema],
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

  const handleError = (err) => {
    console.error(err);
    lightship.shutdown();
  };

  http
    .createServer(server)
    .listen(port, (err) => {
      if (err) {
        handleError(err);
        return;
      }

      lightship.signalReady();
      console.log(`> Ready on http://localhost:${port}`);
    })
    .on("error", handleError);
});
