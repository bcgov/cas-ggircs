import { useRouter } from "next/router";
import { useFragment, graphql } from "react-relay";
import { NormalizedFuelSelection_query$key } from "__generated__/NormalizedFuelSelection_query.graphql";
import { ListGroup } from "react-bootstrap";

interface Props {
  query: NormalizedFuelSelection_query$key;
}

export const NormalizedFuelSelection: React.FC<Props> = ({ query }) => {
  const router = useRouter();

  const data = useFragment(
    graphql`
      fragment NormalizedFuelSelection_query on Query {
        allFuelCarbonTaxDetails {
          edges {
            node {
              id
              normalizedFuelType
            }
          }
        }
      }
    `,
    query
  );

  const handleClick = (id) => {
    const url = {
      pathname: router.pathname,
      query: {
        fuelCarbonTaxDetailId: id,
      },
    };
    router.push(url, url, { shallow: true });
  };

  return (
    <>
      <div className="scrollable" tabIndex={0}>
        <ListGroup variant="flush">
          {data?.allFuelCarbonTaxDetails?.edges?.map(({ node }) => (
            <ListGroup.Item
              key={node.id}
              action
              onClick={() => handleClick(node?.id)}
              active={router.query?.fuelCarbonTaxDetailId === node?.id}
            >
              <b>{node.normalizedFuelType}</b>
            </ListGroup.Item>
          ))}
        </ListGroup>
      </div>
      <style jsx>
        {`
          :global(.list-group-item.active) {
            background-color: #38598a;
            color: white;
          }
        `}
      </style>
      <style jsx>
        {`{

          .scrollable {
            overflow-y: scroll;
            max-height: calc(100vh - 180px);
          }
          .scrollable::-webkit-scrollbar {
            -webkit-appearance: none;
            width: 8px;
          }
          .scrollable::-webkit-scrollbar-thumb {
            border-radius: 4px;
            background-color: rgba(0, 0, 0, 0.5);
            box-shadow: 0 0 1px rgba(255, 255, 255, 0.5);
          }
        `}
      </style>
    </>
  );
};
