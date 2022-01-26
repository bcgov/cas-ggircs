import Link from "next/link";
import { useRouter } from "next/router";
import React from "react";
import { ListGroup } from "react-bootstrap";

interface Props {
  normalizedFuelTypes: any[];
}

export const NormalizedFuelSelection: React.FunctionComponent<Props> = ({
  normalizedFuelTypes,
}) => {
  const router = useRouter();

  return (
    <>
      <div className="scrollable" tabIndex={0}>
        <ListGroup variant="flush">
          {normalizedFuelTypes.map(({ normalizedFuelType, id }) => (
            <Link
              key={id}
              prefetch={false}
              href={{
                pathname: router.pathname,
                query: {
                  ...router.query,
                  fuelCarbonTaxDetailId: id,
                },
              }}
            >
              <ListGroup.Item
                action
                active={router.query?.fuelCarbonTaxDetailId === id}
              >
                <b>{normalizedFuelType}</b>
              </ListGroup.Item>
            </Link>
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
