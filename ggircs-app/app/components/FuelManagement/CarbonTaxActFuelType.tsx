import { Card, Col, Row, Table } from "react-bootstrap";
import React from "react";
import { GraphQLTaggedNode, useFragment, graphql } from "react-relay";
import { CarbonTaxActFuelType_query$key } from "__generated__/CarbonTaxActFuelType_query.graphql";
import { FuelSelectionComponent } from "./FuelSelectionComponent";
import { FuelChargeRow } from "./FuelChargeRow";
import CreateEditFuelChargeRow from "./CreateEditFuelChargeRow";

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

  const validateRatePeriod = (date: string, id?: string) => {
    const dateToValidate = new Date(date);
    const invalidDate =
      carbonTaxActFuelType.fuelChargesByCarbonTaxActFuelTypeId.edges
        .filter((edge) => edge.node.id !== id)
        .some(
          (edge) =>
            new Date(edge.node.startDate) <= dateToValidate &&
            new Date(edge.node.endDate) >= dateToValidate
        );
    if (invalidDate) return false;

    return true;
  };

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
                          <tr>
                            <th>Period Start</th>
                            <th>Period End</th>
                            <th>Charge</th>
                            <th>Comments</th>
                            <th>Edit</th>
                          </tr>
                        </thead>
                        <tbody>
                          {carbonTaxActFuelType.fuelChargesByCarbonTaxActFuelTypeId.edges.map(
                            ({ node }) => (
                              <FuelChargeRow
                                key={node.id}
                                fuelCharge={node}
                                validateRatePeriod={validateRatePeriod}
                              />
                            )
                          )}
                          <CreateEditFuelChargeRow
                            operation={"create"}
                            validateRatePeriod={validateRatePeriod}
                          />
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
        :global(.icon-cell) {
          vertical-align: middle !important;
          text-align: center;
        }
      `}</style>
    </>
  );
};

export default CarbonTaxActFuelType;
