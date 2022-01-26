import React from "react";
import {Table} from 'react-bootstrap';
import Alert from '@button-inc/bcgov-theme/Alert';
import UnmappedFuelTypeRow from './UnmappedFuelTypeRow';

interface Props {
  unMappedFuels: any[],
  normalizedFuels: any
}

export const UnmappedFuelTypes: React.FunctionComponent<Props> = ({
  unMappedFuels, normalizedFuels
}) => {
  return (
    <>
      <Alert>Normalize un-mapped SWRS fuel types</Alert>
      <Table striped bordered hover>
        <thead>
          <tr>
            <th>Un-mapped fuel type</th>
            <th>Select a normalized fuel type</th>
            <th/>
          </tr>
        </thead>
        <tbody>
        {unMappedFuels.map((fuel, index) => (
          <UnmappedFuelTypeRow fuel={fuel} index={index} normalizedFuels={normalizedFuels} />
        ))}
        </tbody>
      </Table>
      <style jsx>{`
        th {
          color: white;
          background: #003366;
        }
        th.centered {
          text-align: center;
        }
      `}</style>
    </>
  );
};

export default UnmappedFuelTypes;
