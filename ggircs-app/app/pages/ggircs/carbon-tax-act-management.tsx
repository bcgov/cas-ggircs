import { withRelay, RelayProps } from "relay-nextjs";
import { graphql, usePreloadedQuery } from "react-relay/hooks";
import withRelayOptions from "lib/relay/withRelayOptions";
import type { NextPageContext } from "next";
import { NextRouter } from "next/router";
import { carbonTaxActManagementQuery } from "__generated__/carbonTaxActManagementQuery.graphql";
import DefaultLayout from "components/Layout/DefaultLayout";
import CarbonTaxActFuelType from "components/FuelManagement/CarbonTaxActFuelType";

export const CarbonTaxActManagementQuery = graphql`
  query carbonTaxActManagementQuery($carbonTaxActFuelTypeId: ID!) {
    query {
      ...CarbonTaxActFuelType_query
        @arguments(carbonTaxActFuelTypeId: $carbonTaxActFuelTypeId)
      session {
        ...DefaultLayout_session
      }
    }
  }
`;

export function CarbonTaxActManagement({
  preloadedQuery,
}: RelayProps<{}, carbonTaxActManagementQuery>) {
  const { query } = usePreloadedQuery(
    CarbonTaxActManagementQuery,
    preloadedQuery
  );

  return (
    <>
      <DefaultLayout
        session={query.session}
        title="Fuel Type Management"
        width="wide"
      >
        <div>
          <CarbonTaxActFuelType
            query={query}
            pageQuery={CarbonTaxActManagementQuery}
          />
        </div>
      </DefaultLayout>
    </>
  );
}

const withRelayOptionsOverride = {
  ...withRelayOptions,
  variablesFromContext: (ctx: NextPageContext | NextRouter) => ({
    carbonTaxActFuelTypeId: "",
    showAll: "false",
    ...ctx.query,
  }),
};

export default withRelay(
  CarbonTaxActManagement,
  CarbonTaxActManagementQuery,
  withRelayOptionsOverride
);
