import React, { useState, useCallback, useEffect } from "react";
import { RelayReportObject, SwrsReportData } from "next-env";
import Input from "@button-inc/bcgov-theme/Input";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faCheck, faTimes } from "@fortawesome/free-solid-svg-icons";
import { NextRouter } from "next/router";
import debounce from 'lodash.debounce';

interface Props {
  diffSide: String;
  setSwrsReport: (report: SwrsReportData) => void;
  allReports: readonly RelayReportObject[];
  router: NextRouter
}

export const ReportSelector: React.FunctionComponent<Props> = ({
  diffSide,
  setSwrsReport,
  allReports,
  router
}) => {
  const [swrsReportIdIsValid, setSwrsReportIdIsvalid] = useState<boolean>(null);
  const [swrsReportId, setSwrsReportId] = useState<number>(Number(router.query[`${diffSide}SideId`]));

  const validateReportId = (id: number) => {
    const edge = allReports.find((edge) => edge.node.swrsReportId === id);
    if (!id) {
      setSwrsReportIdIsvalid(null)
      setSwrsReport(null);
      handleRouter(id, false)
    }
    else if (edge) {
      setSwrsReportIdIsvalid(true);
      setSwrsReport(edge.node.latestSwrsReport);
      handleRouter(id, true)
    } else {
      setSwrsReportIdIsvalid(false);
      setSwrsReport(null);
      handleRouter(id, false)
    }
  };

	const debouncedToRouter = useCallback(
    debounce(nextValue => validateReportId(Number(nextValue)), 1000),
  []);

	const handleChange = event => {
		const { value: nextValue } = event.target;
		setSwrsReportId(nextValue);
		debouncedToRouter(nextValue);
	};

  const handleRouter = (id: number, valid: boolean) => {
    let query;
    if (valid) {
      query = {
        ...router.query,
        [`${diffSide}SideId`]: id
      };
    }
    else {
      query = router.query
      delete query[`${diffSide}SideId`];
    }
    const url = {
      pathname: router.pathname,
      query: query
    };
    router.push(url, url, {shallow: true});
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
      value={String(swrsReportId)}
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
      {swrsReportIdIsValid === false && swrsReportId && (
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

export default ReportSelector;
