import { graphql } from "react-relay";
import {
  createGgircsUserFromSessionMutation as mutationType,
  createGgircsUserFromSessionMutationVariables as mutationVariables,
} from "createGgircsUserFromSessionMutation.graphql";
import RelayModernEnvironment from "relay-runtime/lib/store/RelayModernEnvironment";
import BaseMutation from "mutations/BaseMutation";

const mutation = graphql`
  mutation createGgircsUserFromSessionMutation(
    $input: CreateGgircsUserFromSessionInput!
  ) {
    createGgircsUserFromSession(input: $input) {
      ggircsUser {
        id
        firstName
        lastName
        emailAddress
      }
    }
  }
`;

const createUserMutation = async (
  environment: RelayModernEnvironment,
  variables: mutationVariables
) =>
  new BaseMutation<mutationType>(
    "create-ggircs-user-from-session-mutation"
  ).performMutation(environment, mutation, variables);

export default createUserMutation;
