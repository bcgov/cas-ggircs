import React, { Component } from "react";
import { graphql } from "react-relay";
import { signInQueryResponse } from "signInQuery.graphql";
import { CiipPageComponentProps } from "next-env";
import DefaultLayout from "components/Layout/DefaultLayout";
import { GUEST } from "data/group-constants";

const ALLOWED_GROUPS = [GUEST];

interface Props extends CiipPageComponentProps {
  query: signInQueryResponse["query"];
}
export default class Index extends Component<Props> {
  static allowedGroups = ALLOWED_GROUPS;
  static isAccessProtected = false;

  static query = graphql`
    query signInQuery {
      query {
        session {
          ...DefaultLayout_session
        }
      }
    }
  `;

  render() {
    const { query } = this.props;
    const { session } = query || {};

    return (
      <DefaultLayout showSubheader={false} session={session}>
        <p>
          Welcome to the Greenhouse Gas Industrial Reporting and Control System
        </p>
        <p>Please sign in</p>
      </DefaultLayout>
    );
  }
}
