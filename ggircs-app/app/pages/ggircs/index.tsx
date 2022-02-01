import DefaultLayout from "components/Layout/DefaultLayout";
import { withRelay, RelayProps } from "relay-nextjs";
import { graphql, usePreloadedQuery } from "react-relay/hooks";
import { ggircsLandingQuery } from "__generated__/ggircsLandingQuery.graphql";
import withRelayOptions from "lib/relay/withRelayOptions";
import SwrsDataAccessCard from "components/Dashboard/SwrsDataAccessCard";

export const GgircsLandingQuery = graphql`
  query ggircsLandingQuery {
    query {
      session {
        ...DefaultLayout_session
      }
    }
  }
`;

export function GgircsLanding({ preloadedQuery }: RelayProps<{}, ggircsLandingQuery>) {
  const { query } = usePreloadedQuery(GgircsLandingQuery, preloadedQuery);
  return (
    <DefaultLayout session={query.session}>
      <SwrsDataAccessCard />
    </DefaultLayout>
  );
}

export default withRelay(GgircsLanding, GgircsLandingQuery, withRelayOptions);
