const expressSession = require("express-session");
const connectPgSimple = require("connect-pg-simple");
const crypto = require("crypto");
const dotenv = require("dotenv");
const { dbPool } = require("../storage/db");

dotenv.config();

const PgSession = connectPgSimple(expressSession);
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

const session = () => {
  const store = new PgSession({
    pool: dbPool,
    schemaName: "ggircs_app_private",
    tableName: "connect_session",
  });

  const middleware = expressSession({
    secret,
    resave: false,
    saveUninitialized: true,
    cookie: { secure },
    store,
  });

  return { middleware, store };
};

module.exports = session;
