import { Col, Row, OverlayTrigger, Tooltip } from "react-bootstrap";
import React, { useState, useEffect, ChangeEvent } from "react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faCheck, faTimes } from "@fortawesome/free-solid-svg-icons";
import DatePicker from "@button-inc/bcgov-theme/DatePicker";
import Input from "@button-inc/bcgov-theme/Input";
import Textarea from "@button-inc/bcgov-theme/Textarea";
import Alert from "@button-inc/bcgov-theme/Alert";
import { useCreateFuelChargeMutation } from "mutations/fuelManagement/createFuelCharge";
import { useUpdateFuelChargeMutation } from "mutations/fuelManagement/updateFuelCharge";

interface Props {
  operation: "create" | "edit";
  charge?: {
    id: string;
    startDate: string;
    endDate: string;
    fuelCharge: string;
    metadata: string;
  };
  fuelId: number;
  connectionId?: string;
  validateRatePeriod: (date: string, id?: string) => boolean;
  setIsEditing?: (x: boolean) => void;
}

export const CreateEditFuelChargeRow: React.FC<Props> = ({
  operation,
  charge,
  fuelId,
  connectionId,
  validateRatePeriod,
  setIsEditing,
}) => {
  const [startPeriodData, setStartPeriodData] = useState<string>("");
  const [startPeriodHasError, setStartPeriodHasError] =
    useState<boolean>(false);
  const [endPeriodData, setEndPeriodData] = useState<string>("");
  const [endPeriodHasError, setEndPeriodHasError] = useState<boolean>(false);
  const [fuelChargeData, setFuelChargeData] = useState<string>("");
  const [commentData, setCommentData] = useState<string>("");

  // Set the initial values for the form
  useEffect(() => {
    setStartPeriodData(charge?.startDate || "");
    setEndPeriodData(charge?.endDate || "");
    setFuelChargeData(charge?.fuelCharge || "");
    setCommentData(charge?.metadata || "");
  }, [charge]);

  const [addFuelChargeMutation] = useCreateFuelChargeMutation();
  const [updateFuelChargeMutation] = useUpdateFuelChargeMutation();

  const addFuelCharge = () => {
    addFuelChargeMutation({
      variables: {
        input: {
          fuelCharge: {
            carbonTaxActFuelTypeId: fuelId,
            startDate: startPeriodData,
            endDate: endPeriodData,
            fuelCharge: fuelChargeData,
            metadata: commentData,
          },
        },
        connections: [connectionId],
      },
    });
  };

  const updateFuelCharge = () => {
    updateFuelChargeMutation({
      variables: {
        input: {
          id: charge?.id,
          fuelChargePatch: {
            startDate: startPeriodData,
            endDate: endPeriodData,
            fuelCharge: fuelChargeData,
            metadata: commentData,
          },
        },
      },
    });
  };

  // Validate that the date values are valid (do not overlap)
  const handleValidate = (dataTarget: string, value: string) => {
    if (!validateRatePeriod(value, charge?.id)) {
      if (dataTarget === "startPeriod") {
        setStartPeriodHasError(true);
      } else {
        setEndPeriodHasError(true);
      }
    }
  };

  const clearStateData = () => {
    setStartPeriodData("");
    setEndPeriodData("");
    setFuelChargeData("");
    setCommentData("");
    setStartPeriodHasError(false);
    setEndPeriodHasError(false);
  };

  const handleCancelEdit = () => {
    clearStateData();
    if (operation === "edit") setIsEditing(false);
  };

  // Disable saving if there are errors or the data is incomplete
  const disableSaveButton =
    startPeriodHasError ||
    endPeriodHasError ||
    !startPeriodData ||
    !endPeriodData ||
    !fuelChargeData;

  const handleSave = () => {
    if (disableSaveButton) return;
    clearStateData();
    if (operation === "edit") {
      setIsEditing(false);
      updateFuelCharge();
    } else {
      addFuelCharge();
    }
  };

  return (
    <>
      <tr>
        <td colSpan={5}>
          {operation === "edit" ? (
            <Alert
              id={`edit-row-aria-label-${charge?.id}`}
              aria-label={`edit-row-label-${charge?.id}`}
              variant="warning"
            >
              Editing Row
            </Alert>
          ) : (
            <Alert variant="info">Add a New Rate Period</Alert>
          )}
        </td>
      </tr>
      <tr>
        <td>
          <DatePicker
            label="Period Start"
            name="start-date"
            size="small"
            value={startPeriodData}
            onChange={(e: ChangeEvent<HTMLInputElement>) =>
              setStartPeriodData(e.target.value)
            }
            onBlur={(e: ChangeEvent<HTMLInputElement>) =>
              handleValidate("startPeriod", e.target.value)
            }
          />
          {startPeriodHasError && (
            <p style={{ fontSize: "0.8rem", color: "#cd2026" }}>
              Date overlaps with an existing period
            </p>
          )}
        </td>
        <td>
          <DatePicker
            label="Period End"
            name="end-date"
            size="small"
            value={endPeriodData}
            onChange={(e: ChangeEvent<HTMLInputElement>) =>
              setEndPeriodData(e.target.value)
            }
            onBlur={(e: ChangeEvent<HTMLInputElement>) =>
              handleValidate("endPeriod", e.target.value)
            }
          />
          {endPeriodHasError && (
            <p style={{ fontSize: "0.8rem", color: "#cd2026" }}>
              Date overlaps with an existing period
            </p>
          )}
        </td>
        <td>
          <Input
            label="Charge"
            size="small"
            name="charge"
            type="number"
            value={fuelChargeData}
            onChange={(e: ChangeEvent<HTMLInputElement>) =>
              setFuelChargeData(e.target.value)
            }
          />
        </td>
        <td className="icon-cell" colSpan={2}>
          <Row>
            <Col>
              <OverlayTrigger
                placement="top"
                delay={{ show: 250, hide: 400 }}
                overlay={<Tooltip id="save-tooltip">Save</Tooltip>}
              >
                <div>
                  <FontAwesomeIcon
                    role="button"
                    name="save"
                    className={
                      disableSaveButton
                        ? "save-button-disabled"
                        : "save-cancel-button"
                    }
                    size="lg"
                    icon={faCheck}
                    onClick={handleSave}
                  />
                </div>
              </OverlayTrigger>
            </Col>
            <Col>
              <OverlayTrigger
                placement="top"
                delay={{ show: 250, hide: 400 }}
                overlay={<Tooltip id="cancel-tooltip">Cancel</Tooltip>}
              >
                <div>
                  <FontAwesomeIcon
                    role="button"
                    name="cancel"
                    className="save-cancel-button"
                    size="lg"
                    icon={faTimes}
                    onClick={handleCancelEdit}
                  />
                </div>
              </OverlayTrigger>
            </Col>
          </Row>
        </td>
      </tr>
      <tr>
        <td colSpan={5}>
          <Textarea
            fullWidth
            label="Comments"
            rows={10}
            value={commentData}
            onChange={(e: ChangeEvent<HTMLInputElement>) =>
              setCommentData(e.target.value)
            }
          />
        </td>
      </tr>
      <style jsx>{`
        :global(.save-cancel-button) {
          color: #003366;
        }
        :global(.save-cancel-button:hover) {
          color: #000000;
          cursor: pointer;
        }
        :global(.save-button-disabled) {
          color: gray;
        }
        :global(.save-button-disabled:hover) {
          color: gray;
        }
      `}</style>
    </>
  );
};

export default CreateEditFuelChargeRow;
