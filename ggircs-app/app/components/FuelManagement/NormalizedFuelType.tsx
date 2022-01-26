import React from "react";
import { Card, Col, Row, Table } from "react-bootstrap";
import { NormalizedFuelSelection } from "./NormalizedFuelSelection";
import { createFragmentContainer, graphql, RelayProp } from "react-relay";
import { NormalizedFuelType_query } from "__generated__/NormalizedFuelType_query.graphql";
import MappedFuelTypeTable from "./MappedFuelTypeTable";

interface Props {
  relay: RelayProp;
  query: NormalizedFuelType_query;
}

export const NormalizedFuelType: React.FunctionComponent<Props> = ({
  query,
}) => {
  const normalizedFuelTypes = query.allFuelCarbonTaxDetails?.edges.map((e) => {
    return {
      id: e.node.id,
      normalizedFuelType: e.node.normalizedFuelType
    };
  });

  const currentNormalizedFuel = query.fuelCarbonTaxDetail;

  return (
    <>
      <Row>
        <Col md="4">
          <Card>
            <Card.Header className="bc-card-header">
              Select a Normalized Fuel Type:
            </Card.Header>
            <NormalizedFuelSelection normalizedFuelTypes={normalizedFuelTypes} />
          </Card>
        </Col>
        <Col md="8">
          {currentNormalizedFuel && query.fuelCarbonTaxDetail && (
            <>
              <Row>
                <Col md="12">
                  <Card>
                    <Card.Header className="bc-card-header">
                      <Card.Title>{currentNormalizedFuel.normalizedFuelType}</Card.Title>
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
                            <td>{currentNormalizedFuel.unitConversionFactor}</td>
                          </tr>
                          <tr>
                            <td>CTA Fuel Type: </td>
                            <td>{currentNormalizedFuel.carbonTaxActFuelTypeByCarbonTaxActFuelTypeId?.carbonTaxFuelType}</td>
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
                <MappedFuelTypeTable normalizedFuelType={query.fuelCarbonTaxDetail} />
                </Col>
              </Row>
            </>
          )}
          {!currentNormalizedFuel && (
            <Row>
              <Col>
                Please select a Normalized Fuel on the left to view details and associated fuel types
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

export default createFragmentContainer(NormalizedFuelType, {
  query: graphql`
    fragment NormalizedFuelType_query on Query
    @argumentDefinitions(fuelCarbonTaxDetailId: { type: "ID!" }) {
      fuelCarbonTaxDetail(id: $fuelCarbonTaxDetailId) {
        ...MappedFuelTypeTable_normalizedFuelType
        id
        normalizedFuelType
        state
        ctaRateUnits
        unitConversionFactor
        carbonTaxActFuelTypeByCarbonTaxActFuelTypeId {
          carbonTaxFuelType
        }
      }
      allFuelCarbonTaxDetails {
        edges {
          node {
            id
            normalizedFuelType
          }
        }
      }
    }
  `,
});
