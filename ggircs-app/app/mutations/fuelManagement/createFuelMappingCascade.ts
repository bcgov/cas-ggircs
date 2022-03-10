import { useMutation, graphql, Disposable, Environment } from "react-relay";
import { MutationConfig } from "relay-runtime";
import { createFuelMappingCascadeMutation } from "createFuelMappingCascadeMutation.graphql";

export const mutation = graphql`
  mutation createFuelMappingCascadeMutation(
    $input: CreateFuelMappingCascadeInput!
  ) {
    createFuelMappingCascade(input: $input) {
      fuelMapping {
        id
        fuelType
        fuelCarbonTaxDetailId
      }
    }
  }
`;

export default createFuelMappingCascadeMutation;

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
