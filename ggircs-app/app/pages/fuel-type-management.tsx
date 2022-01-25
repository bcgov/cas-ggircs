import React, { Component } from "react";
import { graphql } from "react-relay";
import { fuelTypeManagementQueryResponse } from "fuelTypeManagementQuery.graphql";
import { PageComponentProps } from "next-env";
import DefaultLayout from "components/Layout/DefaultLayout";
import { USER_GROUP } from "data/group-constants";

const ALLOWED_GROUPS = [...USER_GROUP];

interface Props extends PageComponentProps {
  query: fuelTypeManagementQueryResponse["query"];
}
export default class Index extends Component<Props> {
  static allowedGroups = ALLOWED_GROUPS;
  static isAccessProtected = true;
  static query = graphql`
    query fuelTypeManagementQuery {
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
      <DefaultLayout
        session={session}
        title="Fuel Type Management"
        width="wide"
      >
      </DefaultLayout>
    );
  }
}
