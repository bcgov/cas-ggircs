import React, { Component } from "react";
import { graphql } from "react-relay";
import { swrsBrowserQueryResponse } from "swrsBrowserQuery.graphql";
import { PageComponentProps } from "next-env";
import DefaultLayout from "components/Layout/DefaultLayout";
import FileList from "components/FileList";
import { USER_GROUP } from "data/group-constants";
import { Container } from "react-bootstrap";

const ALLOWED_GROUPS = [...USER_GROUP];

interface Props extends PageComponentProps {
  query: swrsBrowserQueryResponse["query"];
}
export default class Index extends Component<Props> {
  static allowedGroups = ALLOWED_GROUPS;
  static isAccessProtected = true;
  static query = graphql`
    query swrsBrowserQuery {
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
        <Container>
          <h1>GGIRCS File Explorer</h1>
          <FileList />
        </Container>
      </DefaultLayout>
    );
  }
}
