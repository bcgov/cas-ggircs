import { Card, Col, Row, Table } from "react-bootstrap";
import React from "react";
import { GraphQLTaggedNode, useFragment, graphql } from "react-relay";
import { CarbonTaxActFuelType_query$key } from "__generated__/CarbonTaxActFuelType_query.graphql";
import { FuelSelectionComponent } from "./FuelSelectionComponent";
import { FuelChargeRow } from "./FuelChargeRow";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faCheck, faTimes } from "@fortawesome/free-solid-svg-icons";
import DatePicker from "@button-inc/bcgov-theme/DatePicker";
import Input from "@button-inc/bcgov-theme/Input";
import Textarea from "@button-inc/bcgov-theme/Textarea";

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
                ...FuelChargeRow_fuelCharge
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

  return (
    <>
      <Row>
        <Col md="3">
          <Card>
            <Card.Header className="bc-card-header">
              Select a carbon taxed fuel:
            </Card.Header>
            <FuelSelectionComponent
              queryParameter="carbonTaxActFuelTypeId"
              displayParameter="carbonTaxFuelType"
              data={allCarbonTaxActFuelTypes.allCarbonTaxActFuelTypes}
              pageQuery={pageQuery}
            />
          </Card>
        </Col>
        <Col md="9">
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
                      <Table responsive striped bordered hover size="small">
                        <thead>
                          <th>Period Start</th>
                          <th>Period End</th>
                          <th>Charge</th>
                          <th>Comments</th>
                          <th>Edit</th>
                        </thead>
                        <tbody>
                          {carbonTaxActFuelType.fuelChargesByCarbonTaxActFuelTypeId.edges.map(
                            ({ node }) => (
                              <FuelChargeRow key={node.id} fuelCharge={node} />
                            )
                          )}
                          <th colSpan={4}>Add a New Rate Period</th>
                          <tr>
                            <td>
                              <DatePicker
                                id="date-picker"
                                label="Period Start"
                                name="date"
                                size="small"
                                onBlur={() => console.log("blurrrr-1")}
                              />
                            </td>
                            <td>
                              <DatePicker
                                id="date-picker-2"
                                label="Period End"
                                name="date"
                                size="small"
                                onBlur={() => console.log("blurrrr-2")}
                              />
                            </td>
                            <td>
                              <Input
                                id="input-1"
                                label="Charge"
                                size="small"
                                style={{ width: "50%" }}
                                onBlur={() => console.log("blurrrr-3")}
                              />
                            </td>
                            <td className="icon-cell" colSpan={2}>
                              <Row>
                                <Col>
                                  <FontAwesomeIcon
                                    id="edit-button"
                                    size="lg"
                                    icon={faCheck}
                                    onClick={() => console.log("I AM SAVE")}
                                  />
                                </Col>
                                <Col>
                                  <FontAwesomeIcon
                                    id="edit-button"
                                    size="lg"
                                    icon={faTimes}
                                    onClick={() => console.log("I AM CANCEL")}
                                  />
                                </Col>
                              </Row>
                            </td>
                          </tr>
                          <tr>
                            <td colSpan={5}>
                              <Textarea
                                id="textarea-1"
                                label="Comments"
                                size="large"
                                fullWidth
                              />
                            </td>
                          </tr>
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
        .icon-header {
          border: none;
          margin: auto;
          display: block;
        }
        .icon-cell {
          vertical-align: middle;
          text-align: center;
        }
      `}</style>
    </>
  );
};

export default CarbonTaxActFuelType;
