import React from "react";
import { createFragmentContainer, graphql, RelayProp } from "react-relay";
import { Table } from "react-bootstrap";
import Alert from "@button-inc/bcgov-theme/Alert";
import UnmappedFuelTypeRow from "./UnmappedFuelTypeRow";
import { UnmappedFuelTypes_query } from "__generated__/UnmappedFuelTypes_query.graphql";

interface Props {
  relay: RelayProp;
  query: UnmappedFuelTypes_query;
  normalizedFuels: any;
}

export const UnmappedFuelTypes: React.FunctionComponent<Props> = ({
  query,
  normalizedFuels,
}) => {
  return (
    <>
      <Alert>Normalize un-mapped SWRS fuel types</Alert>
      <Table striped bordered hover>
        <thead>
          <tr>
            <th>Un-mapped fuel type</th>
            <th>Select a normalized fuel type</th>
            <th />
          </tr>
        </thead>
        <tbody>
          {query.unmappedFuel.edges.map(({node}, index) => (
            <UnmappedFuelTypeRow
              fuel={node}
              index={index}
              normalizedFuels={normalizedFuels}
            />
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

export default createFragmentContainer(UnmappedFuelTypes, {
  query: graphql`
    fragment UnmappedFuelTypes_query on Query {
      unmappedFuel {
        edges {
          node
        }
      }
    }
  `,
});
