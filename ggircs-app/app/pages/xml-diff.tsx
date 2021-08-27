import React, { Component } from "react";
import { graphql } from "react-relay";
import { Row, Col } from "react-bootstrap";
import Button from "@button-inc/bcgov-theme/Button";
import { xmlDiffQueryResponse } from "xmlDiffQuery.graphql";
import { PageComponentProps } from "next-env";
import DefaultLayout from "components/Layout/DefaultLayout";
import { USER_GROUP } from "data/group-constants";
import ReportSelector from "components/XmlDiff/ReportSelector"
import {FontAwesomeIcon} from '@fortawesome/react-fontawesome';
import {
  faExchangeAlt
} from '@fortawesome/free-solid-svg-icons';

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
        allReports{
          edges {
            node {
              swrsReportId
            }
          }
        }
      }
    }
  `;

  state = {
    leftSideId: null,
    rightSideId: null,
    isSwapped: false
  };

  handleLeftSideChange = (id: Number) => {
    this.setState({leftSideId: id});
  };

  handleRightSideChange = (id: Number) => {
    this.setState({rightSideId: id});
  };

  swap = () => {
    this.setState({isSwapped: !this.state.isSwapped});
  }

  render() {
    const { query } = this.props;
    const { session } = query || {};
    const validSwrsReportIds = [];
    query.allReports.edges.forEach(({node}) => {
      validSwrsReportIds.push(node.swrsReportId)
    })

    return (
      <DefaultLayout
        session={session}
        title="ECCC SWRS XML Diff"
        width="wide"
      >
        <Row>
          <Col md={{ span: 6, order: this.state.isSwapped ? 2 : 1 }}>
            <ReportSelector
              validSwrsReportIds={validSwrsReportIds}
              diffSide={this.state.isSwapped ? 'Second' : 'First'}
              setSwrsReportId={this.handleLeftSideChange}
              swrsReportId={this.state.leftSideId}/>
          </Col>
          <Col md={{ span: 6, order: this.state.isSwapped ? 1 : 2 }}>
            <ReportSelector
              validSwrsReportIds={validSwrsReportIds}
              diffSide={this.state.isSwapped ? 'First' : 'Second'}
              setSwrsReportId={this.handleRightSideChange}
              swrsReportId={this.state.rightSideId}
            />
          </Col>
        </Row>
        <Col style={{marginTop: '2em'}}md={{ span: 4, offset: 9 }}>
          <Button onClick={this.swap}><FontAwesomeIcon icon={faExchangeAlt}></FontAwesomeIcon>&nbsp; Swap left/right</Button>
        </Col>

      </DefaultLayout>
    );
  }
}
