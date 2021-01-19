import React, { Component } from "react";
import { Row, Col, Card } from "react-bootstrap";
import { graphql } from "react-relay";
import { pagesQueryResponse } from "pagesQuery.graphql";
import { CiipPageComponentProps } from "next-env";
import DefaultLayout from "components/Layout/DefaultLayout";
import { GUEST } from "data/group-constants";

const ALLOWED_GROUPS = [GUEST];

interface Props extends CiipPageComponentProps {
  query: pagesQueryResponse["query"];
}
export default class Index extends Component<Props> {
  static allowedGroups = ALLOWED_GROUPS;
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
      <DefaultLayout showSubheader={false} session={session}>
        Welcome to the Greenhouse Gas Industrial Reporting and Control System
      </DefaultLayout>
    );
  }
}
