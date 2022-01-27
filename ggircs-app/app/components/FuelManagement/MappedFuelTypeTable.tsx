import React from "react";
import { Alert, Table } from "react-bootstrap";
import { createFragmentContainer, graphql, RelayProp } from "react-relay";
import { MappedFuelTypeTable_normalizedFuelType } from "__generated__/MappedFuelTypeTable_normalizedFuelType.graphql";

interface Props {
  relay: RelayProp;
  normalizedFuelType: MappedFuelTypeTable_normalizedFuelType;
}

export const MappedFuelTypeTable: React.FunctionComponent<Props> = ({
  normalizedFuelType,
}) => {
  if (
    !normalizedFuelType?.fuelMappingsByFuelCarbonTaxDetailsId?.edges?.length
  ) {
    return (
      <Alert variant="secondary" id="no-search-results">
        No fuels are mapped to this normalized fuel type.
      </Alert>
    );
  }

  return (
    <>
      <Table striped bordered hover>
        <thead>
          <tr>
            <th scope="col">Mapped Fuel Type Variations</th>
          </tr>
        </thead>
        <tbody>
          {normalizedFuelType?.fuelMappingsByFuelCarbonTaxDetailsId?.edges?.map(
            ({ node }) => (
              <tr key={node.id}>
                <td>{node.fuelType}</td>
                <td className="centered">Delete</td>
              </tr>
            )
          )}
        </tbody>
      </Table>
      <style jsx>{`
        th {
          color: white;
          background: #003366;
        }
        th.centered {
          text-align: center;
        }
      `}</style>
    </>
  );
};

export default createFragmentContainer(MappedFuelTypeTable, {
  normalizedFuelType: graphql`
    fragment MappedFuelTypeTable_normalizedFuelType on FuelCarbonTaxDetail {
      id
      fuelMappingsByFuelCarbonTaxDetailsId(first: 2147483647)
        @connection(
          key: "MappedFuelTypes_fuelMappingsByFuelCarbonTaxDetailsId"
        ) {
        edges {
          node {
            id
            fuelType
          }
        }
      }
    }
  `,
});
