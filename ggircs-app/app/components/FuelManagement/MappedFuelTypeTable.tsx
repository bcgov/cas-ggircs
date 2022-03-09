import { Alert, Table } from "react-bootstrap";
import { useFragment, graphql } from "react-relay";
import { MappedFuelTypeTable_normalizedFuelType$key } from "__generated__/MappedFuelTypeTable_normalizedFuelType.graphql";

interface Props {
  normalizedFuelType: MappedFuelTypeTable_normalizedFuelType$key;
}

export const MappedFuelTypeTable: React.FC<Props> = ({
  normalizedFuelType,
}) => {
  const { fuelMappingsByFuelCarbonTaxDetailId } = useFragment(
    graphql`
      fragment MappedFuelTypeTable_normalizedFuelType on FuelCarbonTaxDetail {
        id
        fuelMappingsByFuelCarbonTaxDetailId(first: 2147483647)
          @connection(
            key: "MappedFuelTypes_fuelMappingsByFuelCarbonTaxDetailId"
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

  if (!fuelMappingsByFuelCarbonTaxDetailId?.edges?.length) {
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
          {fuelMappingsByFuelCarbonTaxDetailId?.edges?.map(({ node }) => (
            <tr key={node.id}>
              <td>{node.fuelType}</td>
              <td className="centered">Delete</td>
            </tr>
          ))}
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
