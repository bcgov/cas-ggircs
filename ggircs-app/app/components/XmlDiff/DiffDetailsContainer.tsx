import React from "react";
import { graphql, createFragmentContainer } from "react-relay";
import { Row, Col } from "react-bootstrap";
import { DiffDetailsContainer_query } from "DiffDetailsContainer_query.graphql";
import DiffDetails from "components/XmlDiff/DiffDetails";
import { NextRouter } from "next/router";

interface Props {
  query: DiffDetailsContainer_query;
  router: NextRouter;
}

export const DiffDetailsContainer: React.FunctionComponent<Props> = ({
  query,
  router,
}) => (
  <Row style={{ marginTop: "2em" }}>
    <Col md={{ span: 6, order: router.query.reversed ? 2 : 1 }}>
      {query.firstSideDetails && router.query.FirstSideRelayId && (
        <DiffDetails
          zipFileName={
            query.firstSideDetails.latestSwrsReport.ecccXmlFileByEcccXmlFileId
              .ecccZipFileByZipFileId.zipFileName
          }
          xmlFileName={
            query.firstSideDetails.latestSwrsReport.ecccXmlFileByEcccXmlFileId
              .xmlFileName
          }
          submissionDate={
            query.firstSideDetails.latestSwrsReport.submissionDate
          }
        />
      )}
    </Col>
    <Col md={{ span: 6, order: router.query.reversed ? 1 : 2 }}>
      {query.secondSideDetails && router.query.SecondSideRelayId && (
        <DiffDetails
          zipFileName={
            query.secondSideDetails.latestSwrsReport.ecccXmlFileByEcccXmlFileId
              .ecccZipFileByZipFileId.zipFileName
          }
          xmlFileName={
            query.secondSideDetails.latestSwrsReport.ecccXmlFileByEcccXmlFileId
              .xmlFileName
          }
          submissionDate={
            query.secondSideDetails.latestSwrsReport.submissionDate
          }
        />
      )}
    </Col>
  </Row>
);

export default createFragmentContainer(DiffDetailsContainer, {
  query: graphql`
    fragment DiffDetailsContainer_query on Query
    @argumentDefinitions(
      FirstSideRelayId: { type: "ID!" }
      SecondSideRelayId: { type: "ID!" }
    ) {
      firstSideDetails: report(id: $FirstSideRelayId) {
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
      secondSideDetails: report(id: $SecondSideRelayId) {
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
  `,
});
