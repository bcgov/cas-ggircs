import React, { useCallback, useState } from "react";
import {
  fetchQuery,
  GraphQLTaggedNode,
  useRelayEnvironment,
} from "react-relay";
import { useRouter } from "next/router";
import { ListGroup } from "react-bootstrap";
import withRelayOptions from "lib/relay/withRelayOptions";

interface Props {
  queryParameter: string;
  displayParameter: string;
  data: {
    edges: ReadonlyArray<{
      readonly node: {
        readonly id: string;
        readonly normalizedFuelType?: string | null;
        readonly carbonTaxFuelType?: string | null;
      } | null;
    }>;
  };
  pageQuery: GraphQLTaggedNode;
}

export const FuelSelectionComponent: React.FC<Props> = ({
  queryParameter,
  displayParameter,
  data,
  pageQuery,
}) => {
  const router = useRouter();
  const environment = useRelayEnvironment();
  const [isRefetching, setIsRefetching] = useState(false);

  const handleRouteUpdate = useCallback(
    (url, mode: "replace" | "push") => {
      const afterFetch = () => {
        setIsRefetching(false);
        // At this point the data for the query should be cached,
        // so we can update the route and re-render without suspending
        if (mode === "replace") router.replace(url, url, { shallow: true });
        else router.push(url, url, { shallow: true });
      };

      if (!pageQuery) {
        afterFetch();
        return;
      }

      if (isRefetching) {
        return;
      }

      setIsRefetching(true);

      // fetchQuery will fetch the query and write the data to the Relay store.
      // This will ensure that when we re-render, the data is already cached and we don't suspend
      // See https://github.com/facebook/relay/blob/b8e78ca0fbbfe05f34b4854484df574d91ba2113/website/docs/guided-tour/refetching/refetching-queries-with-different-data.md#if-you-need-to-avoid-suspense
      fetchQuery(
        environment,
        pageQuery,
        withRelayOptions.variablesFromContext(url),
        { fetchPolicy: "store-or-network" }
      ).subscribe({
        complete: afterFetch,
        error: () => {
          // if the query fails, we still want to update the route,
          // which will retry the query and let a 500 page be rendered if it fails again
          afterFetch();
        },
      });
    },
    [environment, isRefetching, router, pageQuery]
  );

  const handleClick = (id: string) => {
    const routerParams = router.query;
    const url = {
      pathname: router.pathname,
      query: {
        ...routerParams,
        [queryParameter]: id,
      },
    };
    handleRouteUpdate(url, "replace");
  };

  return (
    <>
      <div className="scrollable" tabIndex={0}>
        <ListGroup variant="flush">
          {data?.edges?.map(({ node }) => (
            <ListGroup.Item
              key={node.id}
              action
              onClick={() => handleClick(node?.id)}
              active={router.query?.[queryParameter] === node?.id}
            >
              <b>{node[displayParameter]}</b>
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
