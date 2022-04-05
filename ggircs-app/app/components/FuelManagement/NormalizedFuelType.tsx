import { Card, Col, Row, Table } from "react-bootstrap";
import { NormalizedFuelSelection } from "./NormalizedFuelSelection";
import React from "react";
import { GraphQLTaggedNode, useFragment, graphql } from "react-relay";
import { NormalizedFuelType_query$key } from "__generated__/NormalizedFuelType_query.graphql";
import MappedFuelTypeTable from "./MappedFuelTypeTable";

interface Props {
  query: NormalizedFuelType_query$key;
  pageQuery: GraphQLTaggedNode;
}

export const NormalizedFuelType: React.FC<Props> = ({ query, pageQuery }) => {
  const { fuelCarbonTaxDetail, normalizedFuels } = useFragment(
    graphql`
      fragment NormalizedFuelType_query on Query
      @argumentDefinitions(fuelCarbonTaxDetailId: { type: "ID!" }) {
        fuelCarbonTaxDetail(id: $fuelCarbonTaxDetailId) {
          id
          normalizedFuelType
          state
          ctaRateUnits
          unitConversionFactor
          carbonTaxActFuelTypeByCarbonTaxActFuelTypeId {
            carbonTaxFuelType
          }
          ...MappedFuelTypeTable_normalizedFuelType
        }
        normalizedFuels: query {
          ...NormalizedFuelSelection_query
        }
      }
    `,
    query
  );

  const currentNormalizedFuel = fuelCarbonTaxDetail;

  return (
    <>
      <Row>
        <Col md="4">
          <Card>
            <Card.Header className="bc-card-header">
              Select a Normalized Fuel Type:
            </Card.Header>
            <NormalizedFuelSelection
              query={normalizedFuels}
              pageQuery={pageQuery}
            />
          </Card>
        </Col>
        <Col md="8">
          {currentNormalizedFuel && fuelCarbonTaxDetail && (
            <>
              <Row>
                <Col md="12">
                  <Card>
                    <Card.Header className="bc-card-header">
                      <Card.Title>
                        {currentNormalizedFuel.normalizedFuelType}
                      </Card.Title>
                    </Card.Header>
                    <Card.Body>
                      <Table striped bordered hover>
                        <tbody>
                          <tr>
                            <td>State: </td>
                            <td>{currentNormalizedFuel.state}</td>
                          </tr>
                          <tr>
                            <td>CTA Rate Units: </td>
                            <td>{currentNormalizedFuel.ctaRateUnits}</td>
                          </tr>
                          <tr>
                            <td>Unit Conversion Factor: </td>
                            <td>
                              {currentNormalizedFuel.unitConversionFactor}
                            </td>
                          </tr>
                          <tr>
                            <td>CTA Fuel Type: </td>
                            <td>
                              {
                                currentNormalizedFuel
                                  .carbonTaxActFuelTypeByCarbonTaxActFuelTypeId
                                  ?.carbonTaxFuelType
                              }
                            </td>
                          </tr>
                        </tbody>
                      </Table>
                    </Card.Body>
                  </Card>
                </Col>
              </Row>
              <br />
              <Row>
                <Col md="12">
                  <MappedFuelTypeTable
                    normalizedFuelType={fuelCarbonTaxDetail}
                  />
                </Col>
              </Row>
            </>
          )}
          {!currentNormalizedFuel && (
            <Row>
              <Col>
                Please select a Normalized Fuel on the left to view details and
                associated fuel types
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
      `}</style>
    </>
  );
};

export default NormalizedFuelType;
