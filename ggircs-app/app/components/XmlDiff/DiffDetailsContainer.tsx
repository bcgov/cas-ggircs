import { useFragment, graphql } from "react-relay";
import { Row, Col } from "react-bootstrap";
import { DiffDetailsContainer_query$key } from "DiffDetailsContainer_query.graphql";
import DiffDetails from "components/XmlDiff/DiffDetails";
import { useRouter } from "next/router";

interface Props {
  query: DiffDetailsContainer_query$key;
}

export const DiffDetailsContainer: React.FC<Props> = ({
  query
}) => {

  const router = useRouter();
  const {
    firstSideDetails,
    secondSideDetails
  } = useFragment(
    graphql`
      fragment DiffDetailsContainer_query on Query
        @argumentDefinitions(FirstSideRelayId: {type: "ID!"}, SecondSideRelayId: {type: "ID!"}) {
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
    query
  );


  return (
    <Row style={{ marginTop: "2em" }}>
      <Col md={{ span: 6, order: router.query.reversed ? 2 : 1 }}>
        {firstSideDetails && router.query.FirstSideRelayId && (
          <DiffDetails
            zipFileName={
              firstSideDetails.latestSwrsReport.ecccXmlFileByEcccXmlFileId
                .ecccZipFileByZipFileId.zipFileName
            }
            xmlFileName={
              firstSideDetails.latestSwrsReport.ecccXmlFileByEcccXmlFileId
                .xmlFileName
            }
            submissionDate={
              firstSideDetails.latestSwrsReport.submissionDate
            }
          />
        )}
      </Col>
      <Col md={{ span: 6, order: router.query.reversed ? 1 : 2 }}>
        {secondSideDetails && router.query.SecondSideRelayId && (
          <DiffDetails
            zipFileName={
              secondSideDetails.latestSwrsReport.ecccXmlFileByEcccXmlFileId
                .ecccZipFileByZipFileId.zipFileName
            }
            xmlFileName={
              secondSideDetails.latestSwrsReport.ecccXmlFileByEcccXmlFileId
                .xmlFileName
            }
            submissionDate={
              secondSideDetails.latestSwrsReport.submissionDate
            }
          />
        )}
      </Col>
    </Row>
  );
};

export default DiffDetailsContainer;
