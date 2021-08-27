import React, { Component } from "react";
import { graphql } from "react-relay";
import { xmlDiffQueryResponse } from "xmlDiffQuery.graphql";
import { PageComponentProps } from "next-env";
import DefaultLayout from "components/Layout/DefaultLayout";
import { USER_GROUP } from "data/group-constants";

const ALLOWED_GROUPS = [...USER_GROUP];

interface Props extends PageComponentProps {
  query: xmlDiffQueryResponse["query"];
}
export default class Index extends Component<Props> {
  static allowedGroups = ALLOWED_GROUPS;
  static isAccessProtected = true;
  static query = graphql`
    query xmlDiffQuery {
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
        title="ECCC SWRS XML Diff"
        width="wide"
      >
        Stuff goes here
        {/* <Components... /> */}
      </DefaultLayout>
    );
  }
}
