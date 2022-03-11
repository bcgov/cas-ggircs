import { useCallback, useState } from "react";
import { RelayReportObject } from "types";
import Input from "@button-inc/bcgov-theme/Input";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faCheck, faTimes } from "@fortawesome/free-solid-svg-icons";
import debounce from "lodash.debounce";
import { useRouter } from "next/router";

interface Props {
  diffSide: String;
  allReports: readonly RelayReportObject[];
  onUserTyping: (isUserTyping: boolean) => void;
  disabled: boolean;
}

export const ReportSelector: React.FunctionComponent<Props> = ({
  diffSide,
  allReports,
  onUserTyping,
  disabled,
}) => {
  const router = useRouter();

  const [swrsReportIdIsValid, setSwrsReportIdIsvalid] = useState<boolean>(null);
  const [swrsReportId, setSwrsReportId] = useState<number>(
    Number(router.query[`${diffSide}SideId`])
  );

  const handleRouter = useCallback(
    (id: number, relayId: string, valid: boolean) => {
      let query;
      if (valid) {
        query = {
          ...router.query,
          [`${diffSide}SideId`]: id,
          [`${diffSide}SideRelayId`]: relayId,
        };
      } else {
        query = { ...router.query };
        delete query[`${diffSide}SideId`];
        delete query[`${diffSide}SideRelayId`];
      }
      if (!relayId) delete query[`${diffSide}SideRelayId`];
      const url = {
        pathname: router.pathname,
        query,
      };
      router.push(url, url, { shallow: true });
    },
    [router, diffSide]
  );

  const validateReportId = (id: number) => {
    const edge = allReports.find((edge) => edge?.node.swrsReportId === id);
    if (!id) {
      setSwrsReportIdIsvalid(null);
      handleRouter(null, null, false);
    } else if (edge) {
      setSwrsReportIdIsvalid(true);
      handleRouter(id, edge?.node.id, true);
    } else {
      setSwrsReportIdIsvalid(false);
      handleRouter(id, edge?.node.id, false);
    }
  };

  const debouncedToRouter = useCallback(
    debounce((nextValue) => {
      onUserTyping(false);
      validateReportId(Number(nextValue));
    }, 1000),
    [router]
  );

  const handleChange = (event) => {
    const { value: nextValue } = event.target;
    setSwrsReportId(nextValue);
    onUserTyping(true);
    debouncedToRouter(nextValue);
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
      disabled={disabled}
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
