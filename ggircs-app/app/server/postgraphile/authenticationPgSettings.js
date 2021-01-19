const { getAllGroups, getPriorityGroup } = require("../../lib/user-groups");
const { getUserGroups } = require("../helpers/userGroupAuthentication");
const groupData = require("../../data/groups");
const databaseConnectionService = require("../db/databaseConnectionService");

const AUTH_BYPASS_COOKIE = "mocks.auth";
const NO_AUTH = process.argv.includes("NO_AUTH");
const AS_PENDING = process.argv.includes("AS_PENDING");
const AS_CYPRESS = process.argv.includes("AS_CYPRESS");
const AS_USER = process.argv.includes("AS_USER");

const allowCypressForRole = (roleName, req) => {
  return AS_CYPRESS && req.cookies[AUTH_BYPASS_COOKIE] === roleName;
};

const authenticationPgSettings = (req) => {
  if (NO_AUTH) {
    const groups = getAllGroups();
    const priorityGroup = getPriorityGroup(groups);
    return {
      "jwt.claims.sub": "00000000-0000-0000-0000-000000000000",
      "jwt.claims.user_groups": groups.join(","),
      "jwt.claims.priority_group": priorityGroup,
      role: databaseConnectionService.NO_AUTH_POSTGRES_ROLE,
    };
  }

  if (AS_USER || allowCypressForRole("user", req)) {
    return {
      "jwt.claims.sub": "15a21af2-ce88-42e6-ac90-0a5e24260ec6",
      "jwt.claims.user_groups": "User",
      "jwt.claims.priority_group": "User",
      role: "ggircs_user",
    };
  }

  if (AS_PENDING || allowCypressForRole("pending", req)) {
    return {
      "jwt.claims.sub": "00000000-0000-0000-0000-000000000000",
      "jwt.claims.user_groups": "Pending GGIRCS User",
      "jwt.claims.priority_group": "Pending GGIRCS User",
      role: "ggircs_guest",
    };
  }

  const groups = getUserGroups(req);
  const priorityGroup = getPriorityGroup(groups);

  const claims = {
    role: groupData[priorityGroup].pgRole,
  };
  if (
    !req.kauth ||
    !req.kauth.grant ||
    !req.kauth.grant.id_token ||
    !req.kauth.grant.id_token.content
  )
    return {
      ...claims,
    };

  const token = req.kauth.grant.id_token.content;

  token.user_groups = groups.join(",");
  token.priority_group = priorityGroup;

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
    claims[`jwt.claims.${property}`] = token[property];
  });

  return {
    ...claims,
  };
};

module.exports = authenticationPgSettings;
