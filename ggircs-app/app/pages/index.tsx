import React, { Component } from "react";
import { graphql } from "react-relay";
import { pagesQueryResponse } from "pagesQuery.graphql";
import { PageComponentProps } from "next-env";
import DefaultLayout from "components/Layout/DefaultLayout";
import { USER_GROUP } from "data/group-constants";

const ALLOWED_GROUPS = [...USER_GROUP];

interface Props extends PageComponentProps {
  query: pagesQueryResponse["query"];
}
export default class Index extends Component<Props> {
  static allowedGroups = ALLOWED_GROUPS;
  static isAccessProtected = true;
  static query = graphql`
    query pagesQuery {
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
      <DefaultLayout session={session}>
        <h1>GGIRCS Dashboard</h1>
      </DefaultLayout>
    );
  }
}
