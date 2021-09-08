import React from "react";
import { Row, Col } from "react-bootstrap";

interface Props {
  zipFileName: string;
  xmlFileName: string;
  submissionDate: string;
}

export const DiffDetails: React.FunctionComponent<Props> = ({
  zipFileName,
  xmlFileName,
  submissionDate,
}) => (
  <Row>
    <Col md={5}>
      <strong>From Archive: </strong>
    </Col>
    <Col md={7}>{zipFileName}</Col>
    <Col md={5}>
      <strong>Name: </strong>
    </Col>
    <Col md={7}>{xmlFileName}</Col>
    <Col md={5}>
      <strong>Date Submitted: </strong>
    </Col>
    <Col md={7}>{submissionDate.split("T")[0]}</Col>
  </Row>
);
export default DiffDetails;
