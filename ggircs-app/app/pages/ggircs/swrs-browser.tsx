import { withRelay, RelayProps } from "relay-nextjs";
import { graphql, usePreloadedQuery } from "react-relay/hooks";
import withRelayOptions from "lib/relay/withRelayOptions";
import { swrsBrowserQuery } from "__generated__/swrsBrowserQuery.graphql";
import DefaultLayout from "components/Layout/DefaultLayout";
import FileList from "components/SwrsBrowser/FileList";

export const SwrsBrowserQuery = graphql`
  query swrsBrowserQuery {
    query {
      session {
        ...DefaultLayout_session
      }
    }
  }
`;

export function SwrsBrowser({ preloadedQuery }: RelayProps<{}, swrsBrowserQuery>) {
  const { query } = usePreloadedQuery(SwrsBrowserQuery, preloadedQuery);
  return (
    <DefaultLayout
      session={query.session}
      title="ECCC SWRS File Explorer"
      width="wide"
    >
      <FileList />
    </DefaultLayout>
  );
}

export default withRelay(SwrsBrowser, SwrsBrowserQuery, withRelayOptions);
