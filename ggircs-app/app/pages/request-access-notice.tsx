import React, { Component } from "react";
import { graphql } from "react-relay";
import { requestAccessNoticeQueryResponse } from "requestAccessNoticeQuery.graphql";
import { PageComponentProps } from "next-env";
import DefaultLayout from "components/Layout/DefaultLayout";
import { GUEST } from "data/group-constants";

const ALLOWED_GROUPS = [GUEST];

interface Props extends PageComponentProps {
  query: requestAccessNoticeQueryResponse["query"];
}
export default class Index extends Component<Props> {
  static allowedGroups = ALLOWED_GROUPS;
  static isAccessProtected = false;

  static query = graphql`
    query requestAccessNoticeQuery {
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
        <p>
          Welcome to the Greenhouse Gas Industrial Reporting and Control System
        </p>
        <p>
          This application has restricted access. Please contact an
          administrator to gain access
        </p>
      </DefaultLayout>
    );
  }
}
