const { isAuthenticated } = require("@bcgov-cas/sso-express/dist/helpers");
const { getPriorityGroup } = require("../../lib/user-groups");
const { getUserGroups } = require("../helpers/userGroupAuthentication");
const groupData = require("../../data/groups.json");

const AUTH_BYPASS_COOKIE = "mocks.auth";
const AS_PENDING = process.argv.includes("AS_PENDING");
const AS_CYPRESS = process.argv.includes("AS_CYPRESS");
const AS_USER = process.argv.includes("AS_USER");

const allowCypressForRole = (roleName, req) =>
  AS_CYPRESS && req.cookies[AUTH_BYPASS_COOKIE] === roleName;

const authenticationPgSettings = (req) => {
  if (AS_USER || allowCypressForRole("GGIRCS User", req)) {
    return {
      "jwt.claims.sub": "15a21af2-ce88-42e6-ac90-0a5e24260ec6",
      "jwt.claims.user_groups": "GGIRCS User",
      "jwt.claims.priority_group": "GGIRCS User",
      role: "ggircs_user",
    };
  }

  if (AS_PENDING || allowCypressForRole("Pending GGIRCS User", req)) {
    return {
      "jwt.claims.sub": "00000000-0000-0000-0000-000000000000",
      "jwt.claims.user_groups": "Pending GGIRCS User",
      "jwt.claims.priority_group": "Pending GGIRCS User",
      role: "ggircs_guest",
    };
  }

  const groups = getUserGroups(req);
  const priorityGroup = getPriorityGroup(groups);

  const claimsSettings = {
    role: groupData[priorityGroup].pgRole,
  };
  if (!isAuthenticated(req))
    return {
      ...claimsSettings,
    };

  const { claims } = req;

  claims.user_groups = groups.join(",");
  claims.priority_group = priorityGroup;

  const properties = [
    "jti",
    "exp",
    "nbf",
    "iat",
    "iss",
    "aud",
    "sub",
    "typ",
    "azp",
    "auth_time",
    "session_state",
    "acr",
    "email_verified",
    "name",
    "preferred_username",
    "given_name",
    "family_name",
    "email",
    "broker_session_id",
    "user_groups",
    "priority_group",
  ];
  properties.forEach((property) => {
    claimsSettings[`jwt.claims.${property}`] = claims[property];
  });

  return {
    ...claimsSettings,
  };
};

module.exports = authenticationPgSettings;
