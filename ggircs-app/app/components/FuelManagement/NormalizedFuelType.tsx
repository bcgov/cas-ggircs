import React from "react";
import { Card, Col, Row } from "react-bootstrap";
import { NormalizedFuelSelection } from "./NormalizedFuelSelection";
import { createFragmentContainer, graphql, RelayProp } from "react-relay";
import { NormalizedFuelType_query } from "__generated__/NormalizedFuelType_query.graphql";

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
                  <h2>
                    {currentNormalizedFuel.normalizedFuelType}
                  </h2>
                </Col>
              </Row>
              <Row>
                <Col md="12">
                  <p><strong>FUEL CARBON TAX DETAILS</strong></p>
                  <p>STATE: {currentNormalizedFuel.state}</p>
                  <p>CTA RATE UNITS: {currentNormalizedFuel.ctaRateUnits}</p>
                  <p>UNIT CONVERSION FACTOR: {currentNormalizedFuel.unitConversionFactor}</p>
                  <p>CTA FUEL TYPE: {currentNormalizedFuel.carbonTaxActFuelTypeByCarbonTaxActFuelTypeId?.carbonTaxFuelType}</p>
                </Col>
              </Row>
              <br />
              <Row>
                <Col md="12">
                <p><strong>FUELS</strong></p>
                  <ul>
                  {currentNormalizedFuel.fuelMappingsByFuelCarbonTaxDetailsId.edges.map(({node}) => {
                    return (
                      <li key={node.id}>{node.fuelType}</li>
                    );
                  })}
                  </ul>
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
        id
        normalizedFuelType
        state
        ctaRateUnits
        unitConversionFactor
        fuelMappingsByFuelCarbonTaxDetailsId {
          edges {
            node {
              id
              fuelType
            }
          }
        }
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
