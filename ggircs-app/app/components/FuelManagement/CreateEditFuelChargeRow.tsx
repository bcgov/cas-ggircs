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

interface CustomRatePeriodState {
  date: string;
  error: boolean;
}

export const CreateEditFuelChargeRow: React.FC<Props> = ({
  operation,
  charge,
  fuelId,
  connectionId,
  validateRatePeriod,
  setIsEditing,
}) => {
  const [startPeriodData, setStartPeriodData] = useState<CustomRatePeriodState>(
    { date: "", error: false }
  );
  const [endPeriodData, setEndPeriodData] = useState<CustomRatePeriodState>({
    date: "",
    error: false,
  });
  const [fuelChargeData, setFuelChargeData] = useState<string>();
  const [commentData, setCommentData] = useState<string>();

  useEffect(() => {
    setStartPeriodData({ date: charge?.startDate, error: false });
    setEndPeriodData({ date: charge?.endDate, error: false });
    setFuelChargeData(charge?.fuelCharge);
    setCommentData(charge?.metadata);
  }, [charge]);

  const [addFuelChargeMutation] = useCreateFuelChargeMutation();
  const [updateFuelChargeMutation] = useUpdateFuelChargeMutation();

  const addFuelCharge = () => {
    addFuelChargeMutation({
      variables: {
        input: {
          fuelCharge: {
            carbonTaxActFuelTypeId: fuelId,
            startDate: startPeriodData.date,
            endDate: endPeriodData.date,
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
            startDate: startPeriodData.date,
            endDate: endPeriodData.date,
            fuelCharge: fuelChargeData,
            metadata: commentData,
          },
        },
      },
    });
  };

  const handleChange = (dataTarget: string, value: string | null) => {
    switch (dataTarget) {
      case "startPeriod":
        if (validateRatePeriod(value, charge?.id))
          setStartPeriodData({ date: value, error: false });
        else setStartPeriodData({ date: value, error: true });
        break;
      case "endPeriod":
        if (validateRatePeriod(value, charge?.id))
          setEndPeriodData({ date: value, error: false });
        else setEndPeriodData({ date: value, error: true });
        break;
      case "fuelCharge":
        setFuelChargeData(value);
        break;
      case "metadata":
        setCommentData(value);
        break;
      default:
        break;
    }
  };

  const clearStateData = () => {
    setStartPeriodData({ date: "", error: false });
    setEndPeriodData({ date: "", error: false });
    setFuelChargeData("");
    setCommentData("");
  };

  const handleCancelEdit = () => {
    clearStateData();
    setIsEditing(false);
  };

  const handleSave = () => {
    if (startPeriodData.error || endPeriodData.error) return;
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
            <Alert variant="warning">Editing Row</Alert>
          ) : (
            <Alert variant="info">Add a New Rate Period</Alert>
          )}
        </td>
      </tr>
      <tr>
        <td>
          <DatePicker
            id="date-picker"
            label="Period Start"
            name="date"
            size="small"
            defaultValue={charge?.startDate}
            onBlur={(e: ChangeEvent<HTMLInputElement>) =>
              handleChange("startPeriod", e.target.value)
            }
          />
          {startPeriodData.error && (
            <p style={{ fontSize: "0.8rem", color: "#cd2026" }}>
              Date overlaps with an existing period
            </p>
          )}
        </td>
        <td>
          <DatePicker
            id="date-picker-2"
            label="Period End"
            name="date"
            size="small"
            defaultValue={charge?.endDate}
            onBlur={(e: ChangeEvent<HTMLInputElement>) =>
              handleChange("endPeriod", e.target.value)
            }
          />
          {endPeriodData.error && (
            <p style={{ fontSize: "0.8rem", color: "#cd2026" }}>
              Date overlaps with an existing period
            </p>
          )}
        </td>
        <td>
          <Input
            id="input-1"
            label="Charge"
            size="small"
            type="number"
            defaultValue={charge?.fuelCharge}
            onBlur={(e: ChangeEvent<HTMLInputElement>) =>
              handleChange("fuelCharge", e.target.value)
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
                    id={
                      startPeriodData.error || endPeriodData.error
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
                    id="save-cancel-button"
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
            id="textarea-1"
            label="Comments"
            rows={10}
            defaultValue={charge?.metadata}
            onBlur={(e: ChangeEvent<HTMLInputElement>) =>
              handleChange("metadata", e.target.value)
            }
          />
        </td>
      </tr>
      <style jsx>{`
        :global(#save-cancel-button) {
          color: #003366;
        }
        :global(#save-cancel-button:hover) {
          color: #000000;
          cursor: pointer;
        }
        :global(#save-button-disabled) {
          color: gray;
        }
        :global(#save-button-disabled:hover) {
          color: gray;
        }
      `}</style>
    </>
  );
};

export default CreateEditFuelChargeRow;
