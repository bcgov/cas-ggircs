import { withRelay, RelayProps } from "relay-nextjs";
import { graphql, usePreloadedQuery } from "react-relay/hooks";
import withRelayOptions from "lib/relay/withRelayOptions";
import type { NextPageContext } from "next";
import { NextRouter } from "next/router";
import { fuelTypeManagementQuery } from "__generated__/fuelTypeManagementQuery.graphql";
import DefaultLayout from "components/Layout/DefaultLayout";
import NormalizedFuelType from "components/FuelManagement/NormalizedFuelType";
import UnmappedFuelTypes from "components/FuelManagement/UnmappedFuelTypes";

export const FuelTypeManagementQuery = graphql`
  query fuelTypeManagementQuery($fuelCarbonTaxDetailId: ID!) {
    query {
      ...NormalizedFuelType_query
        @arguments(fuelCarbonTaxDetailId: $fuelCarbonTaxDetailId)
      ...UnmappedFuelTypes_query
      session {
        ...DefaultLayout_session
      }
    }
  }
`;

export function FuelTypeManagement({
  preloadedQuery,
}: RelayProps<{}, fuelTypeManagementQuery>) {
  const { query } = usePreloadedQuery(FuelTypeManagementQuery, preloadedQuery);
  return (
    <>
      <DefaultLayout
        session={query.session}
        title="Fuel Type Management"
        width="wide"
      >
        <div id="unmapped">
          <UnmappedFuelTypes query={query} />
        </div>
        <div>
          <NormalizedFuelType query={query} />
        </div>
      </DefaultLayout>
      <style jsx>
        {`
          #unmapped {
            margin-bottom: 2em;
          }
        `}
      </style>
    </>
  );
}

const withRelayOptionsOverride = {
  ...withRelayOptions,
  variablesFromContext: (ctx: NextPageContext | NextRouter) => ({
    fuelCarbonTaxDetailId: "",
    ...ctx.query,
  }),
};

export default withRelay(
  FuelTypeManagement,
  FuelTypeManagementQuery,
  withRelayOptionsOverride
);
