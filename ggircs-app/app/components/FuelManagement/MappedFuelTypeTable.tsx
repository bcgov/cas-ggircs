import { Table } from "react-bootstrap";
import Button from "@button-inc/bcgov-theme/Button";
import Alert from "@button-inc/bcgov-theme/Alert";
import { useFragment, graphql } from "react-relay";
import { MappedFuelTypeTable_normalizedFuelType$key } from "__generated__/MappedFuelTypeTable_normalizedFuelType.graphql";
import { useDeleteFuelMappingMutation } from "mutations/fuelManagement/deleteFuelMapping";

interface Props {
  normalizedFuelType: MappedFuelTypeTable_normalizedFuelType$key;
}

export const MappedFuelTypeTable: React.FC<Props> = ({
  normalizedFuelType,
}) => {
  const { fuelMappingsByFuelCarbonTaxDetailId } = useFragment(
    graphql`
      fragment MappedFuelTypeTable_normalizedFuelType on FuelCarbonTaxDetail {
        fuelMappingsByFuelCarbonTaxDetailId(first: 2147483647)
          @connection(
            key: "MappedFuelTypes_fuelMappingsByFuelCarbonTaxDetailId"
          ) {
          __id
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

  const [deleteFuelMapping] = useDeleteFuelMappingMutation();

  const handleRemove = (id: string) => {
    deleteFuelMapping({
      variables: {
        connections: [fuelMappingsByFuelCarbonTaxDetailId.__id],
        input: {
          id: id,
          fuelMappingPatch: {
            fuelCarbonTaxDetailId: null,
          },
        },
      },
      onError: (error: Error) => {
        console.error(error);
      },
    });
  };

  if (!fuelMappingsByFuelCarbonTaxDetailId?.edges?.length) {
    return (
      <Alert id="no-search-results">
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
              <td>
                <Button onClick={() => handleRemove(node.id)}>Remove</Button>
              </td>
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
        td {
          text-align: center;
        }
      `}</style>
    </>
  );
};

export default MappedFuelTypeTable;
