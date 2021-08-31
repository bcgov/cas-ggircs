import React from "react";
import { Row, Col } from "react-bootstrap";

interface Props {
  report: any;
}

export const DiffDetails: React.FunctionComponent<Props> = ({ report }) => {
  return (
    <>
      <Row>
        <Col md={5}>
          <strong>From Archive: </strong>
        </Col>
        <Col md={7}>
          {report.ecccXmlFileByEcccXmlFileId.ecccZipFileByZipFileId.zipFileName}
        </Col>
      </Row>
      <Row>
        <Col md={5}>
          <strong>Name: </strong>
        </Col>
        <Col md={7}>{report.ecccXmlFileByEcccXmlFileId.xmlFileName}</Col>
      </Row>
      <Row>
        <Col md={5}>
          <strong>Date Submitted: </strong>
        </Col>
        <Col md={7}>{report.submissionDate.split("T")[0]}</Col>
      </Row>
    </>
  );
};

export default DiffDetails;
