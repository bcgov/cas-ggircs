import { useFragment, graphql } from "react-relay";
import { Table } from "react-bootstrap";
import Alert from "@button-inc/bcgov-theme/Alert";
import UnmappedFuelTypeRow from "./UnmappedFuelTypeRow";
import { UnmappedFuelTypes_query$key } from "__generated__/UnmappedFuelTypes_query.graphql";
import updateFuelMappingMutation from "mutations/fuelManagement/updateFuelMapping";
import { useCreateFuelMappingCascade } from "mutations/fuelManagement/createFuelMappingCascade";

interface Props {
  query: UnmappedFuelTypes_query$key;
}

export const UnmappedFuelTypes: React.FC<Props> = ({ query }) => {
  const { unmappedFuel, allFuelCarbonTaxDetails } = useFragment(
    graphql`
      fragment UnmappedFuelTypes_query on Query {
        unmappedFuel {
          edges {
            node {
              fuelType
              fuelMappingId
            }
          }
        }
        allFuelCarbonTaxDetails {
          edges {
            node {
              id
              rowId
              normalizedFuelType
            }
          }
        }
      }
    `,
    query
  );

  if (unmappedFuel.edges.length < 1) return null;

  const normalizedFuels = allFuelCarbonTaxDetails.edges;

  const [createFuelMapping, isCreatingFuelMapping] = useCreateFuelMappingCascade();

  const handleFuelMapping = async (map: {
    rowId?: number;
    fuelType?: string;
    fuelCarbonTaxDetailId: number;
  }) => {
    if (map.rowId) {
      const variables = {
        input: {
          rowId: map.rowId,
          fuelMappingPatch: {
            fuelCarbonTaxDetailId: Number(map.fuelCarbonTaxDetailId),
          },
        },
      };
      // await updateFuelMappingMutation(relay.environment, variables);
    } else {
      createFuelMapping({
        variables: {
          input: {
            fuelTypeInput: map.fuelType,
            fuelCarbonTaxDetailIdInput: Number(map.fuelCarbonTaxDetailId),
          }
        },
        onError: (error: Error) => {
          console.error(error);
        }
      });
    }
  };

  return (
    <>
      <Alert>Normalize un-mapped SWRS fuel types</Alert>
      <Table striped bordered hover>
        <thead>
          <tr>
            <th>Un-mapped fuel type</th>
            <th>Select a normalized fuel type</th>
            <th />
          </tr>
        </thead>
        <tbody>
          {unmappedFuel.edges.map(({ node }, index) => (
            <UnmappedFuelTypeRow
              key={node.fuelType}
              fuel={node}
              index={index}
              normalizedFuels={normalizedFuels}
              handleFuelMapping={handleFuelMapping}
            />
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

export default UnmappedFuelTypes;
