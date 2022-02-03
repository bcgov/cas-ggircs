import { Alert, Table } from "react-bootstrap";
import { useFragment, graphql } from "react-relay";
import { MappedFuelTypeTable_normalizedFuelType$key } from "__generated__/MappedFuelTypeTable_normalizedFuelType.graphql";

interface Props {
  normalizedFuelType: MappedFuelTypeTable_normalizedFuelType$key;
}

export const MappedFuelTypeTable: React.FunctionComponent<Props> = ({
  normalizedFuelType,
}) => {
  const {fuelMappingsByFuelCarbonTaxDetailsId} = useFragment(
    graphql`
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
    normalizedFuelType
  );

  if (
    !fuelMappingsByFuelCarbonTaxDetailsId?.edges?.length
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
          {fuelMappingsByFuelCarbonTaxDetailsId?.edges?.map(
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

export default MappedFuelTypeTable;
