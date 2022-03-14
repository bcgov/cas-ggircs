const groupConstants = require("../../data/group-constants");
const { compactGroups } = require("../../lib/user-groups");

const removeFirstLetter = (str) => str.slice(1);

const getUserGroups = (req) => {
  if (process.argv.includes("AS_CYPRESS") && req.cookies["mocks.auth"]) {
    return [req.cookies["mocks.auth"]];
  }
  if (
    !req.kauth ||
    !req.kauth.grant ||
    !req.kauth.grant.id_token ||
    !req.kauth.grant.id_token.content ||
    !req.kauth.grant.id_token.content.groups
  )
    return [groupConstants.GUEST];

  const identityProvider = req.kauth.grant.id_token.content.identity_provider;
  const { groups } = req.kauth.grant.id_token.content;

  const processedGroups = groups.map((value) => removeFirstLetter(value));
  const validGroups = compactGroups(processedGroups);

  if (validGroups.length === 0) {
    return identityProvider === "idir"
      ? [groupConstants.PENDING_GGIRCS_USER]
      : [groupConstants.GUEST];
  }

  return validGroups;
};

module.exports = {
  getUserGroups,
};
