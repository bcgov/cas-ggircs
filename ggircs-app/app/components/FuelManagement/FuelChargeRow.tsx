import { Col, Row, OverlayTrigger, Tooltip } from "react-bootstrap";
import React, { useState, ChangeEvent } from "react";
import { useFragment, graphql } from "react-relay";
import { FuelChargeRow_fuelCharge$key } from "__generated__/FuelChargeRow_fuelCharge.graphql";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faEdit,
  faQuestionCircle,
  faCheck,
  faTimes,
} from "@fortawesome/free-solid-svg-icons";
import DatePicker from "@button-inc/bcgov-theme/DatePicker";
import Input from "@button-inc/bcgov-theme/Input";
import Textarea from "@button-inc/bcgov-theme/Textarea";
import Alert from "@button-inc/bcgov-theme/Alert";

interface Props {
  fuelCharge: FuelChargeRow_fuelCharge$key;
}

interface CustomRatePeriodState {
  date: string;
  error: boolean;
}

export const FuelChargeRow: React.FC<Props> = ({ fuelCharge }) => {
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
  const [startPeriodData, setStartPeriodData] = useState<CustomRatePeriodState>(
    { date: "", error: false }
  );
  const [endPeriodData, setEndPeriodData] = useState<CustomRatePeriodState>({
    date: "",
    error: false,
  });
  const [fuelChargeData, setFuelChargeData] = useState<string>();
  const [commentData, setCommentData] = useState<string>();

  const dateOne = new Date("2018-01-01");
  const dateTwo = new Date("2018-07-02");

  const validateRatePeriod = (date: string) => {
    const dateThree = new Date(date);
    if (dateThree > dateOne && dateThree < dateTwo) {
      return false;
    }
    return true;
  };

  console.log(charge);

  const handleChange = (dataTarget: string, value: string | null) => {
    switch (dataTarget) {
      case "startPeriod":
        if (validateRatePeriod(value))
          setStartPeriodData({ date: value, error: false });
        else setStartPeriodData({ date: value, error: true });
        break;
      case "endPeriod":
        if (validateRatePeriod(value))
          setEndPeriodData({ date: value, error: false });
        else setEndPeriodData({ date: value, error: true });
        break;
      case "fuelCharge":
        console.log(typeof value);
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
    setIsEditing(false);
  };

  const handleEdit = () => {
    setStartPeriodData({ date: charge.startDate, error: false });
    setEndPeriodData({ date: charge.endDate, error: false });
    setFuelChargeData(charge.fuelCharge);
    setCommentData(charge.metadata);
    setIsEditing(true);
  };

  console.log(fuelChargeData, commentData);

  const editRow = (
    <>
      <th colSpan={5}>
        <Alert variant="warning">Editing Row</Alert>
      </th>
      <tr>
        <td>
          <DatePicker
            id="date-picker"
            label="Period Start"
            name="date"
            size="small"
            defaultValue={charge.startDate}
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
            defaultValue={charge.endDate}
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
            defaultValue={charge.fuelCharge}
            onBlur={(e: ChangeEvent<HTMLInputElement>) =>
              handleChange("fuelCharge", e.target.value)
            }
          />
        </td>
        <td className="icon-cell" colSpan={2}>
          <Row>
            <Col>
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
            </Col>
            <Col>
              <FontAwesomeIcon
                id="save-cancel-button"
                size="lg"
                icon={faTimes}
                onClick={handleCancelEdit}
              />
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
            defaultValue={charge.metadata}
            onBlur={(e: ChangeEvent<HTMLInputElement>) =>
              handleChange("metadata", e.target.value)
            }
          />
        </td>
      </tr>
      <style jsx>{`
        :global(.icon-header) {
          border: none;
          margin: auto;
          display: block;
        }
        :global(.icon-cell) {
          vertical-align: middle;
          text-align: center;
        }
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

  if (isEditing) return editRow;

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
            overlay={<Tooltip id="comment-tooltip">{charge.metadata}</Tooltip>}
          >
            <th className="icon-header" scope="col">
              <FontAwesomeIcon id="edit-button" icon={faQuestionCircle} />
            </th>
          </OverlayTrigger>
        )}
      </td>
      <td>
        <OverlayTrigger
          placement="top"
          delay={{ show: 250, hide: 400 }}
          overlay={<Tooltip id="edit-tooltip">Edit</Tooltip>}
        >
          <th className="icon-header" scope="col">
            <FontAwesomeIcon
              id="edit-button"
              icon={faEdit}
              onClick={handleEdit}
            />
          </th>
        </OverlayTrigger>
      </td>
    </tr>
  );
};

export default FuelChargeRow;
