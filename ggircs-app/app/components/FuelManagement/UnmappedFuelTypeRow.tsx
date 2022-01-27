import React, { useState } from "react";
import Dropdown from "@button-inc/bcgov-theme/Dropdown";
import Button from "@button-inc/bcgov-theme/Button";

interface Props {
  fuel: {fuelType: string, fuelMappingId: number};
  index: number;
  normalizedFuels: any;
  handleFuelMapping: (map: any) => void;
}

export const UnmappedFuelTypeRow: React.FunctionComponent<Props> = ({
  fuel,
  normalizedFuels,
  index,
  handleFuelMapping
}) => {
  const [selectedNormalizedFuel, setSelectedNormalizedFuel] = useState(null);
  const [disabledApplyButton, setDisabledApplyButton] = useState(true);
  const [disabledDropdown, setDisabledDropdown] = useState(false);

  const handleChange = (e: any) => {
    console.log(e.target.value);
    setSelectedNormalizedFuel(e.target.value);
    e.target.value ? setDisabledApplyButton(false) : setDisabledApplyButton(true);
  };

  const handleApply = () => {
    console.log("apply");
    console.log(selectedNormalizedFuel);
    handleFuelMapping({rowId: fuel.fuelMappingId, fuelType: fuel.fuelType, fuelCarbonTaxDetailsId: selectedNormalizedFuel});
    setDisabledDropdown(true);
  };

  const handleUndo = () => {
    console.log("undo");
    setDisabledDropdown(false);
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
            disabled={disabledDropdown}
            onChange={handleChange}
          >
            <option value={null} />
            {normalizedFuels.map(({ node }) => (
              <option key={node.id} value={node.rowId}>
                {node.normalizedFuelType}
              </option>
            ))}
          </Dropdown>
        </td>
        <td>
          {disabledDropdown ? (
            <Button variant="secondary" onClick={handleUndo}>
              Undo
            </Button>
          ) : (
            <Button onClick={handleApply} disabled={disabledApplyButton}>
              Apply
            </Button>
          )}
        </td>
      </tr>
    </>
  );
};

export default UnmappedFuelTypeRow;
