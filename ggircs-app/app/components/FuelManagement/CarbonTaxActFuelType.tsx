import { Card, Col, Row } from "react-bootstrap";
import React from "react";
import { GraphQLTaggedNode, useFragment, graphql } from "react-relay";
import { CarbonTaxActFuelType_query$key } from "__generated__/CarbonTaxActFuelType_query.graphql";
import { FuelSelectionComponent } from "components/FuelManagement/FuelSelectionComponent";

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

  // const currentCarbonTaxActFuel = fuelCarbonTaxDetail;

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
        {/* <Col md="8">
          {currentCarbonTaxActFuel && fuelCarbonTaxDetail && (
            <>
              <Row>
                <Col md="12">
                  <Card>
                    <Card.Header className="bc-card-header">
                      <Card.Title>
                        {currentCarbonTaxActFuel.ncarbonTaxActFuelType}
                      </Card.Title>
                    </Card.Header>
                    <Card.Body>
                      <Table striped bordered hover>
                        <tbody>
                          <tr>
                            <td>State: </td>
                            <td>{currentCarbonTaxActFuel.state}</td>
                          </tr>
                          <tr>
                            <td>CTA Rate Units: </td>
                            <td>{currentCarbonTaxActFuel.ctaRateUnits}</td>
                          </tr>
                          <tr>
                            <td>Unit Conversion Factor: </td>
                            <td>
                              {currentCarbonTaxActFuel.unitConversionFactor}
                            </td>
                          </tr>
                          <tr>
                            <td>CTA Fuel Type: </td>
                            <td>
                              {
                                currentCarbonTaxActFuel
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
                    ncarbonTaxActFuelType={fuelCarbonTaxDetail}
                  />
                </Col>
              </Row>
            </>
          )}
          {!currentCarbonTaxActFuel && (
            <Row>
              <Col>
                Please select a CarbonTaxAct Fuel on the left to view details and
                associated fuel types
              </Col>
            </Row>
          )}
        </Col> */}
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

export default CarbonTaxActFuelType;
