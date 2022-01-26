import React from "react";
import Card from "@button-inc/bcgov-theme/Card";
import Grid from "@button-inc/bcgov-theme/Grid";
import Dropdown from "@button-inc/bcgov-theme/Dropdown";
import {Table} from 'react-bootstrap';
import Callout from '@button-inc/bcgov-theme/Callout';
import Alert from '@button-inc/bcgov-theme/Alert';

interface Props {
  unMappedFuels: any[]
}

export const UnmappedFuelTypes: React.FunctionComponent<Props> = ({
  unMappedFuels
}) => {

  return (
    <>
      <Alert>Normalize un-mapped SWRS fuel types</Alert>
      <Table striped bordered hover>
        <thead>
          <tr>
            <th>Un-mapped fuel type</th>
            <th>Select a normalized fuel type</th>
          </tr>
        </thead>
        <tbody>
        {unMappedFuels.map((fuel) => (
          <tr key={fuel}>
            <td>{fuel}</td>
            <td>
              <Dropdown />
            </td>
          </tr>
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
