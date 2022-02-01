import DefaultLayout from "components/Layout/DefaultLayout";
import { withRelay, RelayProps } from "relay-nextjs";
import { graphql, usePreloadedQuery } from "react-relay/hooks";
import { pagesQuery } from "__generated__/pagesQuery.graphql";
import defaultRelayOptions from "lib/relay/withRelayOptions";
import { getUserGroupLandingRoute } from "lib/user-groups";

export const IndexQuery = graphql`
  query pagesQuery {
    query {
      session {
        ...DefaultLayout_session
      }
    }
  }
`;

function Index({ preloadedQuery }: RelayProps<{}, pagesQuery>) {
  const { query } = usePreloadedQuery(IndexQuery, preloadedQuery);
  return (
    <DefaultLayout session={query.session}>
      <h3 className="blue">You need to be logged in to access this page.</h3>
      <p>
        Please log in to access this page.
        <br />
        You will be redirected to the requested page after doing so.
      </p>
    </DefaultLayout>
  );
}

export const withRelayOptions = {
  ...defaultRelayOptions,
  serverSideProps: async (ctx) => {
    const props = await defaultRelayOptions.serverSideProps(ctx);
    if ("redirect" in props) return props;
    const { getUserGroups } = await import(
      "server/helpers/userGroupAuthentication"
    );

    const groups = getUserGroups(ctx.req);
    if (groups.length === 0 || groups[0] === "Guest") return {};
    return {
      redirect: {
        destination: getUserGroupLandingRoute(groups),
      },
    };
  },
};

export default withRelay(Index, IndexQuery, withRelayOptions);
