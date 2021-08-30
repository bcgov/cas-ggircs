import React, {useState} from 'react';
import Input from "@button-inc/bcgov-theme/Input";
import {FontAwesomeIcon} from '@fortawesome/react-fontawesome';
import {
  faCheck,
  faTimes
} from '@fortawesome/free-solid-svg-icons';

interface Props {
  diffSide: String;
  setSwrsReportId: (id: number) => void;
  validSwrsReportIds: number[];
  swrsReportId?: number;
}

export const ReportSelector: React.FunctionComponent<Props> = ({diffSide, setSwrsReportId, validSwrsReportIds, swrsReportId}) => {
  const [swrsReportIdIsValid, setSwrsReportIdIsvalid] = useState<boolean>(null)
  function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  const validateReportId = (id: number) => {
    validSwrsReportIds.includes(id) ? setSwrsReportIdIsvalid(true) : setSwrsReportIdIsvalid(false);
  };

  const handleChange = async(e: React.SyntheticEvent) => {
    e.stopPropagation();
    e.preventDefault();
    e.persist();
    const target = e.target as HTMLInputElement
    await sleep(500);
    if (target.value) {
      validateReportId(Number(target.value));
      setSwrsReportId(Number(target.value));
    }
    else {
      setSwrsReportIdIsvalid(null)
      setSwrsReportId(null);
    }
  }

  const idSelector =
    <Input
      id='report-id-input'
      type='number'
      placeholder="eg. 17778"
      maxLength={15}
      name='report-id-input'
      rounded
      size="medium"
      onChange={handleChange}
    />;

  console.log(swrsReportId)

  return (
    <div>
      <div><strong>{diffSide} File for Comparison:</strong></div>
      <p><em>Enter the SWRS Report Id. The file contents will show below automatically.</em></p>
      {idSelector}
      {!swrsReportIdIsValid && swrsReportId && <small style={{color:'red'}}><FontAwesomeIcon icon={faTimes}></FontAwesomeIcon>&nbsp;The ID you have entered does not exist</small>}
      {swrsReportIdIsValid && swrsReportId && <small style={{color:'green'}}><FontAwesomeIcon icon={faCheck}></FontAwesomeIcon>&nbsp;ID is valid</small>}
    </div>
  );
};

export default ReportSelector;
