import { graphql } from "react-relay";
import {
  updateFuelMappingMutation as mutationType,
  updateFuelMappingMutationVariables as mutationVariables,
} from "updateFuelMappingMutation.graphql";
import RelayModernEnvironment from "relay-runtime/lib/store/RelayModernEnvironment";
import BaseMutation from "mutations/BaseMutation";

const mutation = graphql`
  mutation updateFuelMappingMutation($input: UpdateFuelMappingByRowIdInput!) {
    updateFuelMappingByRowId(input: $input) {
      fuelMapping {
        id
        fuelType
        fuelCarbonTaxDetailId
      }
    }
  }
`;

const updateFuelMappingMutation = async (
  environment: RelayModernEnvironment,
  variables: mutationVariables
) => {
  const optimisticResponse = {
    updateFuelMappingByRowId: {
      fuelMapping: {
        rowId: variables.input.rowId,
        ...variables.input.fuelMappingPatch,
      },
    },
  };
  const m = new BaseMutation<mutationType>("update-fuel-mapping-mutation");
  return m.performMutation(
    environment,
    mutation,
    variables,
    optimisticResponse
  );
};

export default updateFuelMappingMutation;
