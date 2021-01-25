const express = require("express");
const http = require("http");
const Bowser = require("bowser");
const morgan = require("morgan");
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const cors = require("cors");
const nextjs = require("next");
const { postgraphile } = require("postgraphile");
const postgraphileOptions = require("./postgraphile/postgraphileOptions");
const authenticationPgSettings = require("./postgraphile/authenticationPgSettings");
const ssoRouter = require("./routers/sso");

const port = Number.parseInt(process.env.PORT, 10) || 3004;
const dev = process.env.NODE_ENV !== "production";
const app = nextjs({ dev });
const handle = app.getRequestHandler();
const UNSUPPORTED_BROWSERS = require("../data/unsupported-browsers");
const { dbPool } = require("./storage/db");

app.prepare().then(async () => {
  const server = express();

  server.use(
    morgan("combined", {
      skip: (_, res) => res.statusCode < 400,
    })
  );

  server.use(ssoRouter);

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

  server.use(
    postgraphile(dbPool, process.env.DATABASE_SCHEMA || "ggircs_app", {
      ...postgraphileOptions(),
      pgSettings: (req) => {
        const opts = {
          ...authenticationPgSettings(req),
        };
        return opts;
      },
    })
  );

  server.get("*", async (req, res) => handle(req, res));

  http.createServer(server).listen(port, (err) => {
    if (err) {
      throw err;
    }

    console.log(`> Ready on http://localhost:${port}`);
  });

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
