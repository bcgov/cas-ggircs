import React, { Component } from "react";
import { Row, Col } from "react-bootstrap";
import { graphql } from "react-relay";
import { loginRedirectQueryResponse } from "loginRedirectQuery.graphql";
import { PageComponentProps } from "next-env";
import DefaultLayout from "components/Layout/DefaultLayout";

interface Props extends PageComponentProps {
  query: loginRedirectQueryResponse["query"];
}

export default class LoginRedirect extends Component<Props> {
  static query = graphql`
    query loginRedirectQuery {
      query {
        session {
          ...DefaultLayout_session
        }
      }
    }
  `;

  render() {
    const { query, router } = this.props;
    const { session } = query || {};

    const headerText = router.query.sessionIdled
      ? "You were logged out due to inactivity."
      : "You need to be logged in to access this page.";
    return (
      <DefaultLayout session={session}>
        <Row>
          <Col md={6}>
            <h3 className="blue">{headerText}</h3>
            <p>
              Please log in or register in order to access this page.
              <br />
              You will be redirected to the requested page after doing so.
            </p>
          </Col>
        </Row>
      </DefaultLayout>
    );
  }
}
