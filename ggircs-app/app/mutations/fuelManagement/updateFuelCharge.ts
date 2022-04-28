import { useMutation, graphql, Disposable, Environment } from "react-relay";
import { MutationConfig } from "relay-runtime";
import { updateFuelChargeMutation } from "updateFuelChargeMutation.graphql";

export const mutation = graphql`
  mutation updateFuelChargeMutation($input: UpdateFuelChargeInput!) {
    updateFuelCharge(input: $input) {
      fuelCharge {
        id
        startDate
        endDate
        fuelCharge
        metadata
      }
    }
  }
`;

export const useUpdateFuelChargeMutation = (
  commitMutationFn?: (
    environment: Environment,
    config: MutationConfig<updateFuelChargeMutation>
  ) => Disposable
) => {
  return useMutation<updateFuelChargeMutation>(mutation, commitMutationFn);
};
