import React, { Component } from "react";
import { graphql } from "react-relay";
import { Row, Col } from "react-bootstrap";
import Button from "@button-inc/bcgov-theme/Button";
import { xmlDiffQueryResponse } from "xmlDiffQuery.graphql";
import { PageComponentProps } from "next-env";
import DefaultLayout from "components/Layout/DefaultLayout";
import { USER_GROUP } from "data/group-constants";
import ReportSelector from "components/XmlDiff/ReportSelector";
import DiffDetailsContainer from "components/XmlDiff/DiffDetailsContainer";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faExchangeAlt } from "@fortawesome/free-solid-svg-icons";
import RenderDiff from "components/XmlDiff/RenderDiff";
// Use dynamic import for BootstrapSwitchButton (workaround for SSR bug where window is not defined)
import dynamic from "next/dynamic";
const BootstrapSwitchButton = dynamic(
  () => import("bootstrap-switch-button-react"),
  {
    loading: () => <p>loading</p>,
    ssr: false, // This line is important. It's what prevents server-side render
  }
);

const ALLOWED_GROUPS = [...USER_GROUP];

interface Props extends PageComponentProps {
  query: xmlDiffQueryResponse["query"];
}
interface State {
  isReversed: Boolean;
  isCollapsed: Boolean;
}
export default class Index extends Component<Props, State> {
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

  state = {
    isReversed: false,
    isCollapsed: false,
  };

  reverse = async () => {
    await this.setState((prevState) => ({ isReversed: !prevState.isReversed }));
  };

  summarize = async () => {
    await this.setState((prevState) => ({
      isCollapsed: !prevState.isCollapsed,
    }));
  };

  render() {
    const { query } = this.props;
    const { session } = query || {};

    return (
      <DefaultLayout session={session} title="ECCC SWRS XML Diff" width="wide">
        <Row>
          <Col md={{ span: 6, order: this.state.isReversed ? 2 : 1 }}>
            <ReportSelector
              diffSide={this.state.isReversed ? "Second" : "First"}
              allReports={query.allReports.edges}
              router={this.props.router}
            />
          </Col>
          <Col md={{ span: 6, order: this.state.isReversed ? 1 : 2 }}>
            <ReportSelector
              diffSide={this.state.isReversed ? "First" : "Second"}
              allReports={query.allReports.edges}
              router={this.props.router}
            />
          </Col>
        </Row>

        <DiffDetailsContainer
          query={this.props.query}
          isReversed={false}
          router={this.props.router}
        />
        <Row style={{ marginTop: "2em", marginBottom: "2em" }}>
          <Col md={{ span: 3, offset: 6 }}>
            <Row style={{ float: "right" }}>
              <p style={{ marginTop: "auto", marginBottom: "auto" }}>
                <strong>Summarize Changes:&nbsp;</strong>
              </p>
              <BootstrapSwitchButton
                checked={this.state.isCollapsed}
                onlabel="On"
                offlabel="Off"
                onChange={this.summarize}
              />
            </Row>
          </Col>
          <Col md={{ span: 3 }}>
            <Button size="small" onClick={this.reverse}>
              <FontAwesomeIcon icon={faExchangeAlt} />
              &nbsp;Swap left/right
            </Button>
          </Col>
        </Row>
        <RenderDiff query={this.props.query} router={this.props.router} />
      </DefaultLayout>
    );
  }
}
