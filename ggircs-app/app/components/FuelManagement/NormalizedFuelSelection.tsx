import { useFragment, graphql, GraphQLTaggedNode } from "react-relay";
import { NormalizedFuelSelection_query$key } from "__generated__/NormalizedFuelSelection_query.graphql";
import { FuelSelectionComponent } from "./FuelSelectionComponent";

interface Props {
  query: NormalizedFuelSelection_query$key;
  pageQuery: GraphQLTaggedNode;
}

export const NormalizedFuelSelection: React.FC<Props> = ({
  query,
  pageQuery,
}) => {
  const data = useFragment(
    graphql`
      fragment NormalizedFuelSelection_query on Query {
        allFuelCarbonTaxDetails {
          edges {
            node {
              id
              normalizedFuelType
            }
          }
        }
      }
    `,
    query
  );

  return (
    <div className="scrollable" tabIndex={0}>
      <FuelSelectionComponent
        queryParameter="fuelCarbonTaxDetailId"
        displayParameter="normalizedFuelType"
        data={data?.allFuelCarbonTaxDetails}
        pageQuery={pageQuery}
      />
    </div>
  );
};
