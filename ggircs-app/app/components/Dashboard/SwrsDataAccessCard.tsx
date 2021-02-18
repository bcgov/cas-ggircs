import React from "react";
import { Card, ListGroup } from "react-bootstrap";
import Link from "next/link";

const SwrsDataAccessCard: React.FunctionComponent = () => (
  <Card>
    <Card.Body>
      <Card.Title>SWRS</Card.Title>
      <Card.Text>
        Access reports and attachments from the Single Window Reporting System
      </Card.Text>
    </Card.Body>
    <ListGroup variant="flush">
      <ListGroup.Item>
        <Link href="/swrs-browser" passHref>
          <Card.Link href="#">Browse SWRS files</Card.Link>
        </Link>
      </ListGroup.Item>
    </ListGroup>
  </Card>
);

export default SwrsDataAccessCard;
