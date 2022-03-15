import { useState } from "react";
import { useFragment, graphql } from "react-relay";
import Dropdown from "@button-inc/bcgov-theme/Dropdown";
import Button from "@button-inc/bcgov-theme/Button";
import { UnmappedFuelTypeRow_query$key } from "__generated__/UnmappedFuelTypeRow_query.graphql";
import { useUpdateFuelMappingMutation } from "mutations/fuelManagement/updateFuelMapping";
import { useCreateFuelMappingCascade } from "mutations/fuelManagement/createFuelMappingCascade";

interface Props {
  fuel: { fuelType: string; fuelMappingId: number };
  index: number;
  query: UnmappedFuelTypeRow_query$key;
}

export const UnmappedFuelTypeRow: React.FC<Props> = ({
  fuel,
  query,
  index,
}) => {
  const [selectedNormalizedFuel, setSelectedNormalizedFuel] = useState(null);

  const data = useFragment(
    graphql`
      fragment UnmappedFuelTypeRow_query on Query {
        allFuelCarbonTaxDetails {
          edges {
            node {
              id
              rowId
              normalizedFuelType
              fuelMappingsByFuelCarbonTaxDetailId(first: 2147483647)
                @connection(
                  key: "MappedFuelTypes_fuelMappingsByFuelCarbonTaxDetailId"
                ) {
                __id
                edges {
                  node {
                    __typename
                  }
                }
              }
            }
          }
        }
      }
    `,
    query
  );

  const handleChange = (e: any) => {
    setSelectedNormalizedFuel(e.target.value);
  };

  const [createFuelMapping] = useCreateFuelMappingCascade();
  const [updateFuelMapping] = useUpdateFuelMappingMutation();

  const handleApply = () => {
    const selectedData = JSON.parse(selectedNormalizedFuel);
    if (fuel.fuelMappingId) {
      updateFuelMapping({
        variables: {
          connections: [selectedData.connectionId],
          input: {
            rowId: fuel.fuelMappingId,
            fuelMappingPatch: {
              fuelCarbonTaxDetailId: Number(selectedData.rowId),
            },
          },
        },
        onError: (error: Error) => {
          console.error(error);
        },
      });
    } else {
      createFuelMapping({
        variables: {
          connections: [selectedData.connectionId],
          input: {
            fuelTypeInput: fuel.fuelType,
            fuelCarbonTaxDetailIdInput: Number(selectedData.rowId),
          },
        },
        onError: (error: Error) => {
          console.error(error);
        },
      });
    }
  };

  return (
    <>
      <tr key={fuel.fuelType}>
        <td>{fuel.fuelType}</td>
        <td>
          <Dropdown
            id={`normalized-fuel-select-${index}`}
            name="normalized-fuel-select"
            rounded
            size="medium"
            onChange={handleChange}
          >
            <option value={null} />
            {data?.allFuelCarbonTaxDetails?.edges?.map(({ node }) => (
              <option
                key={node.id}
                value={JSON.stringify({
                  rowId: node?.rowId,
                  connectionId: node?.fuelMappingsByFuelCarbonTaxDetailId.__id,
                })}
              >
                {node.normalizedFuelType}
              </option>
            ))}
          </Dropdown>
        </td>
        <td>
          <Button onClick={handleApply}>Apply</Button>
        </td>
      </tr>
    </>
  );
};

export default UnmappedFuelTypeRow;
