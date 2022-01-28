import { Component } from "react";
import { graphql } from "react-relay";
import { Row, Col } from "react-bootstrap";
import { xmlDiffQueryResponse } from "xmlDiffQuery.graphql";
import { PageComponentProps } from "types";
import DefaultLayout from "components/Layout/DefaultLayout";
import { USER_GROUP } from "data/group-constants";
import ReportSelector from "components/XmlDiff/ReportSelector";
import DiffDetailsContainer from "components/XmlDiff/DiffDetailsContainer";
import RenderDiff from "components/XmlDiff/RenderDiff";
import DiffControls from "components/XmlDiff/DiffControls";

const ALLOWED_GROUPS = [...USER_GROUP];

interface Props extends PageComponentProps {
  query: xmlDiffQueryResponse["query"];
}

export default class Index extends Component<Props> {
  static allowedGroups = ALLOWED_GROUPS;

  static isAccessProtected = true;

  static query = graphql`
    query xmlDiffQuery($FirstSideRelayId: ID!, $SecondSideRelayId: ID!) {
      query {
        session {
          ...DefaultLayout_session
        }
        allReports {
          edges {
            node {
              id
              swrsReportId
            }
          }
        }
        ...DiffDetailsContainer_query
          @arguments(
            FirstSideRelayId: $FirstSideRelayId
            SecondSideRelayId: $SecondSideRelayId
          )
        ...RenderDiff_query
          @arguments(
            FirstSideRelayId: $FirstSideRelayId
            SecondSideRelayId: $SecondSideRelayId
          )
      }
    }
  `;

  static async getInitialProps() {
    return {
      variables: {
        FirstSideRelayId: "",
        SecondSideRelayId: "",
      },
    };
  }

  render() {
    const { query } = this.props;
    const { session } = query || {};

    return (
      <DefaultLayout session={session} title="ECCC SWRS XML Diff" width="wide">
        <Row>
          <Col
            md={{ span: 6, order: this.props.router.query.reversed ? 2 : 1 }}
          >
            <ReportSelector
              diffSide={this.props.router.query.reversed ? "Second" : "First"}
              allReports={query.allReports.edges}
              router={this.props.router}
            />
          </Col>
          <Col
            md={{ span: 6, order: this.props.router.query.reversed ? 1 : 2 }}
          >
            <ReportSelector
              diffSide={this.props.router.query.reversed ? "First" : "Second"}
              allReports={query.allReports.edges}
              router={this.props.router}
            />
          </Col>
        </Row>
        <DiffControls router={this.props.router} />

        <DiffDetailsContainer
          query={this.props.query}
          router={this.props.router}
        />

        <RenderDiff query={this.props.query} router={this.props.router} />
      </DefaultLayout>
    );
  }
}
