const { default: ssoExpress } = require("@bcgov-cas/sso-express");
const dotenv = require("dotenv");
const { getUserGroupLandingRoute } = require("../../lib/user-groups");
const { getUserGroups } = require("../helpers/userGroupAuthentication");

dotenv.config();

const mockLogin = process.argv.includes("AS_CYPRESS");

const host = process.env.HOST;
const namespace = process.env.NAMESPACE;
const kcClientSecret = process.env.KC_CLIENT_SECRET;

let ssoServerHost = "test!!";
if (!namespace || namespace.endsWith("-dev"))
  ssoServerHost = "dev.loginproxy.gov.bc.ca";
else if (namespace.endsWith("-test"))
  ssoServerHost = "test.loginproxy.gov.bc.ca";
else ssoServerHost = "loginproxy.gov.bc.ca";

async function middleware() {
  return ssoExpress({
    applicationDomain: ".gov.bc.ca",
    getLandingRoute: (req) => {
      if (req.query.redirectTo) return req.query.redirectTo;

      const groups = getUserGroups(req);

      return getUserGroupLandingRoute(groups);
    },
    getRedirectUri: (defaultRedirectUri, req) => {
      const redirectUri = new URL(defaultRedirectUri);
      if (req.query.redirectTo)
        redirectUri.searchParams.append(
          "redirectTo",
          req.query.redirectTo.toString()
        );

      return redirectUri;
    },
    bypassAuthentication: {
      login: mockLogin,
      sessionIdleRemainingTime: mockLogin,
    },
    oidcConfig: {
      baseUrl: host,
      clientId: "cif-4311",
      oidcIssuer: `https://${ssoServerHost}/auth/realms/standard`,
      clientSecret: kcClientSecret,
    },
    authorizationUrlParams: (req) => {
      if (req.query.kc_idp_hint === "idir") return { kc_idp_hint: "idir" };
      return {};
    },
    onAuthCallback: (...args) => {
      console.error(args);
    },
  });
}

module.exports = middleware;
