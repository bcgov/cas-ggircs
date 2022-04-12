import { OverlayTrigger, Tooltip } from "react-bootstrap";
import React, { useState } from "react";
import { useFragment, graphql } from "react-relay";
import { FuelChargeRow_fuelCharge$key } from "__generated__/FuelChargeRow_fuelCharge.graphql";
import { CreateEditFuelChargeRow } from "./CreateEditFuelChargeRow";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faEdit, faQuestionCircle } from "@fortawesome/free-solid-svg-icons";

interface Props {
  fuelCharge: FuelChargeRow_fuelCharge$key;
  fuelId: number;
  validateRatePeriod: (date: string, id?: string) => boolean;
}

export const FuelChargeRow: React.FC<Props> = ({
  fuelCharge,
  fuelId,
  validateRatePeriod,
}) => {
  const charge = useFragment(
    graphql`
      fragment FuelChargeRow_fuelCharge on FuelCharge {
        id
        startDate
        endDate
        fuelCharge
        metadata
      }
    `,
    fuelCharge
  );

  const [isEditing, setIsEditing] = useState(false);

  if (isEditing)
    return (
      <CreateEditFuelChargeRow
        operation={"edit"}
        charge={charge}
        fuelId={fuelId}
        validateRatePeriod={validateRatePeriod}
        setIsEditing={setIsEditing}
      />
    );

  return (
    <tr>
      <td>{charge.startDate}</td>
      <td>{charge.endDate}</td>
      <td>{charge.fuelCharge}</td>
      <td className="icon-cell">
        {charge.metadata && (
          <OverlayTrigger
            placement="top"
            delay={{ show: 250, hide: 400 }}
            overlay={
              <Tooltip className="comment-tooltip">{charge.metadata}</Tooltip>
            }
          >
            <div>
              <FontAwesomeIcon
                className="edit-button"
                icon={faQuestionCircle}
              />
            </div>
          </OverlayTrigger>
        )}
      </td>
      <td className="icon-cell">
        <OverlayTrigger
          placement="top"
          delay={{ show: 250, hide: 400 }}
          overlay={<Tooltip id="edit-tooltip">Edit</Tooltip>}
        >
          <div>
            <FontAwesomeIcon
              className="edit-button"
              icon={faEdit}
              onClick={() => setIsEditing(true)}
            />
          </div>
        </OverlayTrigger>
      </td>
    </tr>
  );
};

export default FuelChargeRow;
