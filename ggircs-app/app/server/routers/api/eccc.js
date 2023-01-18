require("isomorphic-fetch");
const express = require("express");
const { isAuthenticated } = require("@bcgov-cas/sso-express/dist/helpers");
const { getUserGroups } = require("../../helpers/userGroupAuthentication");
const { getUserGroupLandingRoute } = require("../../../lib/user-groups");

const ecccApiRouter = express.Router();
const { ECCC_FILE_BROWSER_HOST, ECCC_FILE_BROWSER_PORT, HOST, PORT } =
  process.env;

const secure = /^https/.test(HOST);
// When using SSL termination, the graphql enpoint should use the public host,
// otherwise the host will not match the cert.
// When not using SSL termination (e.g. in local development), we can use localhost, with the server's port.
const graphqlEndpoint = secure
  ? `${HOST}/graphql`
  : `http://localhost:${PORT}/graphql`;

/**
 * This router forwards all requests to the ECCC file browser service
 * after ensuring that the client is authenticated
 */
ecccApiRouter.get(
  "*",
  (req, res, next) => {
    if (!isAuthenticated(req)) {
      const groups = getUserGroups(req);
      return res.redirect(getUserGroupLandingRoute(groups));
    }
    return next();
  },
  async (req, res) => {
    const ecccApiRes = await fetch(
      `${ECCC_FILE_BROWSER_HOST}:${ECCC_FILE_BROWSER_PORT}${req.url}`
    );

    if (ecccApiRes.ok && req.path.endsWith("/download")) {
      const splitPath = req.path.split("/");
      const ecccZipFileName = splitPath[splitPath.length - 2];
      const mutationBody = {
        id: "createEcccFileDownloadLogMutation",
        query: `mutation createEcccFileDownloadLogMutation(
            $input: CreateEcccFileDownloadLogInput!
          ) {
            createEcccFileDownloadLog(input: $input) {
              ecccFileDownloadLog {
                id
              }
            }
          }`,
        variables: {
          input: {
            ecccFileDownloadLog: {
              ecccZipFileName,
              ecccIndividualFilePath: req.query.filename,
            },
          },
        },
      };
      // log the download in the database.
      try {
        await fetch(graphqlEndpoint, {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            Cookie: req.get("Cookie"), // forward the cookie so that the graphql request is authenticated
          },
          body: JSON.stringify(mutationBody),
        });
      } catch (e) {
        console.error(e);
        res.sendStatus(500);
        return;
      }
    }

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
