import {
  Card,
  Col,
  Row,
  Table,
  OverlayTrigger,
  Tooltip,
} from "react-bootstrap";
import React from "react";
import { GraphQLTaggedNode, useFragment, graphql } from "react-relay";
import { CarbonTaxActFuelType_query$key } from "__generated__/CarbonTaxActFuelType_query.graphql";
import { FuelSelectionComponent } from "components/FuelManagement/FuelSelectionComponent";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faEdit } from "@fortawesome/free-solid-svg-icons";

interface Props {
  query: CarbonTaxActFuelType_query$key;
  pageQuery: GraphQLTaggedNode;
}

export const CarbonTaxActFuelType: React.FC<Props> = ({ query, pageQuery }) => {
  const { carbonTaxActFuelType, allCarbonTaxActFuelTypes } = useFragment(
    graphql`
      fragment CarbonTaxActFuelType_query on Query
      @argumentDefinitions(carbonTaxActFuelTypeId: { type: "ID!" }) {
        carbonTaxActFuelType(id: $carbonTaxActFuelTypeId) {
          id
          carbonTaxFuelType
          ctaRateUnits
          fuelChargesByCarbonTaxActFuelTypeId {
            edges {
              node {
                id
                startDate
                endDate
                fuelCharge
                metadata
              }
            }
          }
        }
        allCarbonTaxActFuelTypes: query {
          allCarbonTaxActFuelTypes {
            edges {
              node {
                id
                carbonTaxFuelType
              }
            }
          }
        }
      }
    `,
    query
  );

  console.log(carbonTaxActFuelType);

  return (
    <>
      <Row>
        <Col md="4">
          <Card>
            <Card.Header className="bc-card-header">
              Select a carbon taxed fuel type:
            </Card.Header>
            <FuelSelectionComponent
              queryParameter="carbonTaxActFuelTypeId"
              displayParameter="carbonTaxFuelType"
              data={allCarbonTaxActFuelTypes.allCarbonTaxActFuelTypes}
              pageQuery={pageQuery}
            />
          </Card>
        </Col>
        <Col md="8">
          {carbonTaxActFuelType && (
            <>
              <Row>
                <Col md="12">
                  <Card>
                    <Card.Header className="bc-card-header">
                      <Card.Title>
                        {carbonTaxActFuelType.carbonTaxFuelType} (
                        {carbonTaxActFuelType.ctaRateUnits})
                      </Card.Title>
                    </Card.Header>
                    <Card.Body>
                      <Table striped bordered hover>
                        <thead>
                          <th>Rate Period Start</th>
                          <th>Rate Period End</th>
                          <th>Fuel Charge</th>
                          <th>Comments</th>
                        </thead>
                        <tbody>
                          {carbonTaxActFuelType.fuelChargesByCarbonTaxActFuelTypeId.edges.map(
                            ({ node }) => (
                              <tr key={node.id}>
                                <td>{node.startDate}</td>
                                <td>{node.endDate}</td>
                                <td>{node.fuelCharge}</td>
                                <td>{node.metadata}</td>
                                <td>
                                  <OverlayTrigger
                                    placement="top"
                                    delay={{ show: 250, hide: 400 }}
                                    overlay={
                                      <Tooltip id="fuel-type-variations-tooltip">
                                        Edit
                                      </Tooltip>
                                    }
                                  >
                                    <th scope="col">
                                      <FontAwesomeIcon
                                        id="edit-button"
                                        icon={faEdit}
                                        onClick={() => console.log("I AM EDIT")}
                                      />
                                    </th>
                                  </OverlayTrigger>
                                </td>
                              </tr>
                            )
                          )}
                        </tbody>
                      </Table>
                    </Card.Body>
                  </Card>
                </Col>
              </Row>
            </>
          )}
          {!carbonTaxActFuelType && (
            <Row>
              <Col>
                Please select a Carbon Tax Act Fuel on the left to view details
                and related fuel charges
              </Col>
            </Row>
          )}
        </Col>
      </Row>
      <style jsx>{`
        :global(.bc-card-header) {
          color: white;
          background: #003366;
        }
        :global(#edit-button) {
          color: #003366;
        }
        :global(#edit-button):hover {
          color: #000000;
          cursor: pointer;
        }
      `}</style>
    </>
  );
};

export default CarbonTaxActFuelType;
