import { Card, Col, Row, Table } from "react-bootstrap";
import React from "react";
import { GraphQLTaggedNode, useFragment, graphql } from "react-relay";
import { CarbonTaxActFuelType_query$key } from "__generated__/CarbonTaxActFuelType_query.graphql";
import { FuelSelectionComponent } from "./FuelSelectionComponent";
import { FuelChargeRow } from "./FuelChargeRow";
import CreateEditFuelChargeRow from "./CreateEditFuelChargeRow";
import { useRouter } from "next/router";
import Button from "@button-inc/bcgov-theme/Button";

interface Props {
  query: CarbonTaxActFuelType_query$key;
  pageQuery: GraphQLTaggedNode;
}

const DEFAULT_RATE_PERIODS_TO_SHOW = 3;

export const CarbonTaxActFuelType: React.FC<Props> = ({ query, pageQuery }) => {
  const { carbonTaxActFuelType, allCarbonTaxActFuelTypes } = useFragment(
    graphql`
      fragment CarbonTaxActFuelType_query on Query
      @argumentDefinitions(carbonTaxActFuelTypeId: { type: "ID!" }) {
        carbonTaxActFuelType(id: $carbonTaxActFuelTypeId) {
          id
          rowId
          carbonTaxFuelType
          ctaRateUnits
          fuelChargesByCarbonTaxActFuelTypeId(
            first: 1000
            orderBy: START_DATE_ASC
          )
            @connection(
              key: "CarbonTaxActFuelType_fuelChargesByCarbonTaxActFuelTypeId"
            ) {
            __id
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
        allCarbonTaxActFuelTypes {
          edges {
            node {
              id
              carbonTaxFuelType
            }
          }
        }
      }
    `,
    query
  );

  const router = useRouter();

  const isDateInFuelTypeFuelCharges = (date: string, fuelChargeId?: string) => {
    const dateToValidate = new Date(date);
    const invalidDate =
      carbonTaxActFuelType.fuelChargesByCarbonTaxActFuelTypeId.edges
        .filter((edge) => edge.node.id !== fuelChargeId)
        .some(
          (edge) =>
            new Date(edge.node.startDate) <= dateToValidate &&
            new Date(edge.node.endDate) >= dateToValidate
        );

    return !invalidDate;
  };

  // Default the number of fuel charge rows shown to the last 3 rows in the list.
  // Allow alternating between showing all rows or the last 3 rows with handleShowCharges().
  const startIndex =
    router.query.showAll === "true"
      ? 0
      : carbonTaxActFuelType?.fuelChargesByCarbonTaxActFuelTypeId?.edges
          ?.length - DEFAULT_RATE_PERIODS_TO_SHOW;
  const showPeriodText =
    router.query.showAll === "true"
      ? "Show Less Rate Periods"
      : `Show All Rate Periods (${carbonTaxActFuelType?.fuelChargesByCarbonTaxActFuelTypeId?.edges?.length})`;

  const handleShowCharges = () => {
    const url = {
      pathname: router.pathname,
      query: {
        ...router.query,
        showAll: router.query.showAll === "false" ? "true" : "false",
      },
    };
    router.replace(url, url, { shallow: true });
  };

  return (
    <div>
      <Row>
        <Col md="3">
          <Card>
            <Card.Header className="bc-card-header">
              Select a carbon taxed fuel:
            </Card.Header>
            <FuelSelectionComponent
              queryParameter="carbonTaxActFuelTypeId"
              displayParameter="carbonTaxFuelType"
              data={allCarbonTaxActFuelTypes}
              pageQuery={pageQuery}
            />
          </Card>
        </Col>
        <Col md="9">
          {carbonTaxActFuelType && (
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
                    <Button
                      id="show-hide-toggle"
                      variant="secondary"
                      onClick={handleShowCharges}
                    >
                      {showPeriodText}
                    </Button>
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
                        {carbonTaxActFuelType.fuelChargesByCarbonTaxActFuelTypeId.edges
                          .slice(startIndex)
                          .map(({ node }) => (
                            <FuelChargeRow
                              key={node.id}
                              fuelId={carbonTaxActFuelType.rowId}
                              fuelCharge={node}
                              isDateInFuelTypeFuelCharges={
                                isDateInFuelTypeFuelCharges
                              }
                            />
                          ))}
                        <CreateEditFuelChargeRow
                          operation={"create"}
                          fuelId={carbonTaxActFuelType.rowId}
                          connectionId={
                            carbonTaxActFuelType
                              .fuelChargesByCarbonTaxActFuelTypeId.__id
                          }
                          isDateInFuelTypeFuelCharges={
                            isDateInFuelTypeFuelCharges
                          }
                        />
                      </tbody>
                    </Table>
                  </Card.Body>
                </Card>
              </Col>
            </Row>
          )}
          {!carbonTaxActFuelType && (
            <Row>
              <Col>
                Please select a Carbon Tax Act Fuel on the left to view details
                and related fuel rates
              </Col>
            </Row>
          )}
        </Col>
      </Row>
      <style jsx>{`
        div :global(.bc-card-header) {
          color: white;
          background: #003366;
        }
        div :global(.edit-button) {
          color: #003366;
        }
        div :global(.edit-button):hover {
          color: #000000;
          cursor: pointer;
        }
        div :global(.icon-cell) {
          vertical-align: middle !important;
          text-align: center;
        }
        div :global(.save-cancel-controls) {
          float: right;
        }
        div :global(.cancel-button) {
          margin-right: 0.5rem;
        }
      `}</style>
    </div>
  );
};

export default CarbonTaxActFuelType;
