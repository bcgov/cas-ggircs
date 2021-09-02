import React, { Component } from "react";
import { graphql } from "react-relay";
import { Row, Col } from "react-bootstrap";
import Button from "@button-inc/bcgov-theme/Button";
import { xmlDiffQueryResponse } from "xmlDiffQuery.graphql";
import { PageComponentProps } from "next-env";
import DefaultLayout from "components/Layout/DefaultLayout";
import { USER_GROUP } from "data/group-constants";
import ReportSelector from "components/XmlDiff/ReportSelector";
import DiffDetails from "components/XmlDiff/DiffDetails";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faExchangeAlt } from "@fortawesome/free-solid-svg-icons";
import format from "xml-formatter";
import RenderDiff from "components/XmlDiff/RenderDiff";
import BootstrapSwitchButton from 'bootstrap-switch-button-react'

const ALLOWED_GROUPS = [...USER_GROUP];

interface Props extends PageComponentProps {
  query: xmlDiffQueryResponse["query"];
}
interface State {
  leftSideId: Number;
  leftSideReport: any;
  rightSideId: Number;
  rightSideReport: any;
  isReversed: Boolean;
  isCollapsed: Boolean;
}
export default class Index extends Component<Props, State> {
  static allowedGroups = ALLOWED_GROUPS;
  static isAccessProtected = true;
  static query = graphql`
    query xmlDiffQuery {
      query {
        session {
          ...DefaultLayout_session
        }
        allReports {
          edges {
            node {
              swrsReportId
              latestSwrsReport {
                submissionDate
                ecccXmlFileByEcccXmlFileId {
                  xmlFileName
                  xmlFile
                  ecccZipFileByZipFileId {
                    zipFileName
                  }
                }
              }
            }
          }
        }
      }
    }
  `;

  state = {
    leftSideId: null,
    leftSideReport: null,
    rightSideId: null,
    rightSideReport: null,
    isReversed: false,
    isCollapsed: false,
  };

  handleLeftSideChange = (id: Number, report: any) => {
    this.setState({ leftSideId: id, leftSideReport: report });
  };

  handleRightSideChange = (id: Number, report: any) => {
    this.setState({ rightSideId: id, rightSideReport: report });
  };

  reverse = () => {
    this.setState((prevState) => ({ isReversed: !prevState.isReversed }));
  };

  summarize = () => {
    this.setState((prevState) => ({ isCollapsed: !prevState.isCollapsed }));
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
              setSwrsReportId={this.handleLeftSideChange}
              swrsReportId={this.state.leftSideId}
              allReports={query.allReports}
            />
          </Col>
          <Col md={{ span: 6, order: this.state.isReversed ? 1 : 2 }}>
            <ReportSelector
              diffSide={this.state.isReversed ? "First" : "Second"}
              setSwrsReportId={this.handleRightSideChange}
              swrsReportId={this.state.rightSideId}
              allReports={query.allReports}
            />
          </Col>
        </Row>

        <Row style={{ marginTop: "2em" }}>
          <Col md={{ span: 6, order: this.state.isReversed ? 2 : 1 }}>
            {this.state.leftSideReport && (
              <DiffDetails report={this.state.leftSideReport} />
            )}
          </Col>
          <Col md={{ span: 6, order: this.state.isReversed ? 1 : 2 }}>
            {this.state.rightSideReport && (
              <DiffDetails report={this.state.rightSideReport} />
            )}
          </Col>
        </Row>
        <Row style={{ marginTop: "2em", marginBottom: "2em" }}>
          <Col md={{ span: 3, offset: 6 }}>
            <Row>
              <p style={{marginTop: "auto", marginBottom: "auto"}}>
                <strong>Summarize Changes:&nbsp;</strong>
              </p>
              <BootstrapSwitchButton
                checked={this.state.isCollapsed}
                onlabel='On'
                offlabel='Off'
                onChange={this.summarize}
                size='lg'
              />
            </Row>
          </Col>
          <Col md={{ span: 3 }}>
            <Button onClick={this.reverse}>
              <FontAwesomeIcon icon={faExchangeAlt} />
              &nbsp;Swap left/right
            </Button>
          </Col>
        </Row>

        {this.state.leftSideReport && this.state.rightSideReport && (
          <div style={{ height: "40em", overflow: "scroll" }}>
            <RenderDiff
              oldText={
                this.state.isReversed
                  ? format(
                      this.state.rightSideReport.ecccXmlFileByEcccXmlFileId
                        .xmlFile
                    )
                  : format(
                      this.state.leftSideReport.ecccXmlFileByEcccXmlFileId
                        .xmlFile
                    )
              }
              newText={
                this.state.isReversed
                  ? format(
                      this.state.leftSideReport.ecccXmlFileByEcccXmlFileId
                        .xmlFile
                    )
                  : format(
                      this.state.rightSideReport.ecccXmlFileByEcccXmlFileId
                        .xmlFile
                    )
              }
              collapse={this.state.isCollapsed}
            />
          </div>
        )}
      </DefaultLayout>
    );
  }
}
