const { getUserGroups } = require("../helpers/userGroupAuthentication");
const { performQuery } = require("../postgraphile/graphql");
const { UNAUTHORIZED_IDIR_USER } = require("../../data/group-constants");

// This middleware calls the createUserFromSession mutation.

const createUserMutation = `
mutation {
    createGgircsUserFromSession(input: {}) {
    __typename
  }
}
`;

function createUserMiddleware() {
  const f = async (req) => {
    if (getUserGroups(req).includes(UNAUTHORIZED_IDIR_USER)) {
      return;
    }

    const response = await performQuery(createUserMutation, {}, req);

    if (response.errors) {
      throw new Error(
        `Failed to update or create user from session:\n${response.errors.join(
          "\n"
        )}`
      );
    }
  };

  return f;
}

module.exports = createUserMiddleware;
