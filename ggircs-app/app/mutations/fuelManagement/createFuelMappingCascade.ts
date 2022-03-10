import { useMutation, graphql, Disposable, Environment } from "react-relay";
import { MutationConfig } from "relay-runtime";
import { createFuelMappingCascadeMutation } from "createFuelMappingCascadeMutation.graphql";

export const mutation = graphql`
  mutation createFuelMappingCascadeMutation(
    $input: CreateFuelMappingCascadeInput!
    $connections: [ID!]!
  ) {
    createFuelMappingCascade(input: $input) {
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

export const useCreateFuelMappingCascade = (
  commitMutationFn?: (
    environment: Environment,
    config: MutationConfig<createFuelMappingCascadeMutation>
  ) => Disposable
) => {
  return useMutation<createFuelMappingCascadeMutation>(
    mutation,
    commitMutationFn
  );
};
