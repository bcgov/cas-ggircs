import { Table, Tooltip, OverlayTrigger } from "react-bootstrap";
import Button from "@button-inc/bcgov-theme/Button";
import Alert from "@button-inc/bcgov-theme/Alert";
import { useFragment, graphql } from "react-relay";
import { MappedFuelTypeTable_normalizedFuelType$key } from "__generated__/MappedFuelTypeTable_normalizedFuelType.graphql";
import { useDeleteFuelMappingMutation } from "mutations/fuelManagement/deleteFuelMapping";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faQuestionCircle } from "@fortawesome/free-solid-svg-icons";

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
            <OverlayTrigger
              placement="top"
              delay={{ show: 250, hide: 400 }}
              overlay={
                <Tooltip id="fuel-type-variations-tooltip">
                  The fuel type variations listed below are the different fuel
                  types as reported in SWRS reports that are currently mapped to
                  the Normalized Fuel Type above.
                </Tooltip>
              }
            >
              <th scope="col">
                Mapped Fuel Type Variations &ensp;
                <FontAwesomeIcon icon={faQuestionCircle} />
              </th>
            </OverlayTrigger>
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
