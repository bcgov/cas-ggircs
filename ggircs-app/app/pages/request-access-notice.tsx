import DefaultLayout from "components/Layout/DefaultLayout";
import { withRelay, RelayProps } from "relay-nextjs";
import { graphql, usePreloadedQuery } from "react-relay/hooks";
import { requestAccessNoticeQuery } from "__generated__/requestAccessNoticeQuery.graphql";
import withRelayOptions from "lib/relay/withRelayOptions";

const RequestAccessNoticeQuery = graphql`
  query requestAccessNoticeQuery {
    query {
      session {
        ...DefaultLayout_session
      }
    }
  }
`;

function RequestAccessNotice({ preloadedQuery }: RelayProps<{}, requestAccessNoticeQuery>) {
  const { query } = usePreloadedQuery(RequestAccessNoticeQuery, preloadedQuery);
  return (
    <DefaultLayout session={query.session}>
      <p>
          Welcome to the Greenhouse Gas Industrial Reporting and Control System
        </p>
        <p>
          This application has restricted access. Please contact an
          administrator to gain access
        </p>
    </DefaultLayout>
  );
}

export default withRelay(RequestAccessNotice, RequestAccessNoticeQuery, withRelayOptions);
