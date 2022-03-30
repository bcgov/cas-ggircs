import { Card, Col, Row, Table } from "react-bootstrap";
import { NormalizedFuelSelection } from "./NormalizedFuelSelection";
import React, { useCallback, useState } from "react";
import {
  fetchQuery,
  GraphQLTaggedNode,
  useRelayEnvironment,
  useFragment,
  graphql,
} from "react-relay";
// import { useFragment, graphql } from "react-relay";
import { NormalizedFuelType_query$key } from "__generated__/NormalizedFuelType_query.graphql";
import MappedFuelTypeTable from "./MappedFuelTypeTable";
import { useRouter } from "next/router";
import withRelayOptions from "lib/relay/withRelayOptions";

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
  const router = useRouter();
  const environment = useRelayEnvironment();
  const [isRefetching, setIsRefetching] = useState(false);

  const currentNormalizedFuel = fuelCarbonTaxDetail;

  const handleRouteUpdate = useCallback(
    (url, mode: "replace" | "push") => {
      const afterFetch = () => {
        setIsRefetching(false);
        // At this point the data for the query should be cached,
        // so we can update the route and re-render without suspending
        if (mode === "replace") router.replace(url, url, { shallow: true });
        else router.push(url, url, { shallow: true });
      };

      if (!pageQuery) {
        afterFetch();
        return;
      }

      if (isRefetching) {
        return;
      }

      setIsRefetching(true);

      // fetchQuery will fetch the query and write the data to the Relay store.
      // This will ensure that when we re-render, the data is already cached and we don't suspend
      // See https://github.com/facebook/relay/blob/b8e78ca0fbbfe05f34b4854484df574d91ba2113/website/docs/guided-tour/refetching/refetching-queries-with-different-data.md#if-you-need-to-avoid-suspense
      fetchQuery(
        environment,
        pageQuery,
        withRelayOptions.variablesFromContext(url),
        { fetchPolicy: "store-or-network" }
      ).subscribe({
        complete: afterFetch,
        error: () => {
          // if the query fails, we still want to update the route,
          // which will retry the query and let a 500 page be rendered if it fails again
          afterFetch();
        },
      });
    },
    [environment, isRefetching, router, pageQuery]
  );

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
              handleRouteUpdate={handleRouteUpdate}
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
