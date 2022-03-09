import { graphql } from "react-relay";
import {
  createFuelMappingCascadeMutation as mutationType,
  createFuelMappingCascadeMutationVariables as mutationVariables,
} from "createFuelMappingCascadeMutation.graphql";
import RelayModernEnvironment from "relay-runtime/lib/store/RelayModernEnvironment";
import BaseMutation from "mutations/BaseMutation";

const mutation = graphql`
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

const createFuelMappingCascadeMutation = async (
  environment: RelayModernEnvironment,
  variables: mutationVariables
) => {
  const m = new BaseMutation<mutationType>(
    "create-fuel-mapping-cascade-mutation"
  );
  return m.performMutation(environment, mutation, variables);
};

export default createFuelMappingCascadeMutation;
