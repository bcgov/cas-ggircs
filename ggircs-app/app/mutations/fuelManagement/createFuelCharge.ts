import { useMutation, graphql, Disposable, Environment } from "react-relay";
import { MutationConfig } from "relay-runtime";
import { createFuelChargeMutation } from "createFuelChargeMutation.graphql";

export const mutation = graphql`
  mutation createFuelChargeMutation(
    $input: CreateFuelChargeInput!
    $connections: [ID!]!
  ) {
    createFuelCharge(input: $input) {
      fuelChargeEdge @appendEdge(connections: $connections) {
        cursor
        node {
          id
          startDate
          endDate
          fuelCharge
          metadata
        }
      }
    }
  }
`;

export const useCreateFuelChargeMutation = (
  commitMutationFn?: (
    environment: Environment,
    config: MutationConfig<createFuelChargeMutation>
  ) => Disposable
) => {
  return useMutation<createFuelChargeMutation>(mutation, commitMutationFn);
};
