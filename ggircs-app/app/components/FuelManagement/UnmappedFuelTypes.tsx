import { useFragment, graphql } from "react-relay";
import { Table } from "react-bootstrap";
import Alert from "@button-inc/bcgov-theme/Alert";
import UnmappedFuelTypeRow from "./UnmappedFuelTypeRow";
import { UnmappedFuelTypes_query$key } from "__generated__/UnmappedFuelTypes_query.graphql";

interface Props {
  query: UnmappedFuelTypes_query$key;
}

export const UnmappedFuelTypes: React.FC<Props> = ({ query }) => {
  const { unmappedFuel, normalizedFuels } = useFragment(
    graphql`
      fragment UnmappedFuelTypes_query on Query {
        unmappedFuel {
          edges {
            node {
              fuelType
              fuelMappingId
            }
          }
        }
        normalizedFuels: query {
          ...UnmappedFuelTypeRow_query
        }
      }
    `,
    query
  );

  if (unmappedFuel.edges.length < 1) return null;
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
          {unmappedFuel.edges.map(({ node }, index) => (
            <UnmappedFuelTypeRow
              key={node.fuelType}
              fuel={node}
              index={index}
              query={normalizedFuels}
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

export default UnmappedFuelTypes;
