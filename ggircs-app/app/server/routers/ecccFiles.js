require("isomorphic-fetch");
const express = require("express");

const ecccFilesRouter = express.Router();
const { ECCC_FILE_BROWSER_HOST } = process.env;
const { ECCC_FILE_BROWSER_PORT } = process.env;

ecccFilesRouter.get("*", async (req, res) => {
  const ecccApiRes = await fetch(
    `${ECCC_FILE_BROWSER_HOST}:${ECCC_FILE_BROWSER_PORT}${req.path}`
  );
  res.headers = ecccApiRes.headers;
  ecccApiRes.body.pipe(res);
});

module.exports = ecccFilesRouter;
