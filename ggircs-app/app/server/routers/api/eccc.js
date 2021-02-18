require("isomorphic-fetch");
const express = require("express");
const { keycloak } = require("../sso");

const ecccApiRouter = express.Router();
const { ECCC_FILE_BROWSER_HOST } = process.env;
const { ECCC_FILE_BROWSER_PORT } = process.env;

/**
 * This router forwards all requests to the ECCC file browser service
 * after ensuring that the client is authenticated
 */
ecccApiRouter.get(
  "*",
  keycloak.protect(
    (token) =>
      token.content.groups.includes("/GGIRCS User") ||
      token.content.groups.includes("/Realm Administrator")
  ),
  async (req, res) => {
    const ecccApiRes = await fetch(
      `${ECCC_FILE_BROWSER_HOST}:${ECCC_FILE_BROWSER_PORT}${req.url}`
    );

    res.setHeader("Content-Type", ecccApiRes.headers.get("content-type"));
    res.setHeader("Content-Length", ecccApiRes.headers.get("content-length"));

    const contentDispositionHeader = ecccApiRes.headers.get(
      "content-disposition"
    );
    if (contentDispositionHeader)
      res.setHeader("Content-Disposition", contentDispositionHeader);

    ecccApiRes.body.pipe(res);
  }
);

module.exports = { ecccApiRouter };
