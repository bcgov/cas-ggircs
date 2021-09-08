import React, { useState } from "react";
import { ArrayOfReports, SwrsReportData } from "next-env";
import Input from "@button-inc/bcgov-theme/Input";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faCheck, faTimes } from "@fortawesome/free-solid-svg-icons";

interface Props {
  diffSide: String;
  setSwrsReportId: (id: number, report: SwrsReportData) => void;
  swrsReportId?: number;
  allReports: ArrayOfReports;
}

export const ReportSelector: React.FunctionComponent<Props> = ({
  diffSide,
  setSwrsReportId,
  swrsReportId,
  allReports,
}) => {
  const [swrsReportIdIsValid, setSwrsReportIdIsvalid] = useState<boolean>(null);
  function sleep(ms) {
    return new Promise((resolve) => setTimeout(resolve, ms));
  }

  const validateReportId = (id: number) => {
    const edge = allReports.edges.find((edge) => edge.node.swrsReportId === id);
    if (edge) {
      setSwrsReportIdIsvalid(true);
      setSwrsReportId(edge.node.swrsReportId, edge.node.latestSwrsReport);
    } else {
      setSwrsReportIdIsvalid(false);
      setSwrsReportId(id, null);
    }
  };

  const handleChange = async (e: React.SyntheticEvent) => {
    e.stopPropagation();
    e.preventDefault();
    e.persist();
    const target = e.target as HTMLInputElement;
    await sleep(500);
    if (target.value) {
      validateReportId(Number(target.value));
    } else {
      setSwrsReportIdIsvalid(null);
      setSwrsReportId(null, null);
    }
  };

  const idSelector = (
    <Input
      id="report-id-input"
      type="number"
      placeholder="eg. 17778"
      maxLength={15}
      name="report-id-input"
      rounded
      size="medium"
      onChange={handleChange}
    />
  );

  return (
    <div>
      <div>
        <strong>{diffSide} File for Comparison:</strong>
      </div>
      <p>
        <em>
          Enter the SWRS Report Id. The file contents will show below
          automatically.
        </em>
      </p>
      {idSelector}
      {!swrsReportIdIsValid && swrsReportId && (
        <small style={{ color: "red" }}>
          <FontAwesomeIcon icon={faTimes} />
          &nbsp;The ID you have entered does not exist
        </small>
      )}
      {swrsReportIdIsValid && swrsReportId && (
        <small style={{ color: "green" }}>
          <FontAwesomeIcon icon={faCheck} />
          &nbsp;ID is valid
        </small>
      )}
    </div>
  );
};

ReportSelector.defaultProps = {
  swrsReportId: null,
};

export default ReportSelector;
