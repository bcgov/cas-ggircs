import { useMutation, graphql, Disposable, Environment } from "react-relay";
import { MutationConfig } from "relay-runtime";
import { updateFuelMappingMutation } from "updateFuelMappingMutation.graphql";

export const mutation = graphql`
  mutation updateFuelMappingMutation($input: UpdateFuelMappingByRowIdInput! $connections: [ID!]!) {
    updateFuelMappingByRowId(input: $input) {
      fuelMappingEdge @appendEdge(connections: $connections) {
        cursor
        node {
          id
          fuelType
          fuelCarbonTaxDetailId
        }
      }
      query {
        unmappedFuel {
          edges {
            node {
              fuelType
              fuelMappingId
            }
          }
        }
      }
    }
  }
`;

export const useUpdateFuelMappingMutation = (
  commitMutationFn?: (
    environment: Environment,
    config: MutationConfig<updateFuelMappingMutation>
  ) => Disposable
) => {
  return useMutation<updateFuelMappingMutation>(
    mutation,
    commitMutationFn
  );
};
