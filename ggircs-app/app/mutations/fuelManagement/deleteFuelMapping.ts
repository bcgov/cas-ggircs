import { useMutation, graphql, Disposable, Environment } from "react-relay";
import { MutationConfig } from "relay-runtime";
import { deleteFuelMappingMutation } from "deleteFuelMappingMutation.graphql";

export const mutation = graphql`
  mutation deleteFuelMappingMutation($input: UpdateFuelMappingInput! $connections: [ID!]!) {
    updateFuelMapping(input: $input) {
      fuelMapping {
        id @deleteEdge(connections: $connections)
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

export const useDeleteFuelMappingMutation = (
  commitMutationFn?: (
    environment: Environment,
    config: MutationConfig<deleteFuelMappingMutation>
  ) => Disposable
) => {
  return useMutation<deleteFuelMappingMutation>(
    mutation,
    commitMutationFn
  );
};
