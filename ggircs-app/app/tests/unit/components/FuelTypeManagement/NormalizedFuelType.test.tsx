import React from "react";
import { render, screen, fireEvent, act } from "@testing-library/react";
import NormalizedFuelType from "components/FuelManagement/NormalizedFuelType";
import {
  graphql,
  RelayEnvironmentProvider,
  useLazyLoadQuery,
} from "react-relay";
import { createMockEnvironment, MockPayloadGenerator } from "relay-test-utils";
import compiledNormalizedFuelTypeQuery, {
  NormalizedFuelTypeQuery,
} from "__generated__/NormalizedFuelTypeQuery.graphql";
import { mocked } from "jest-mock";
import { useRouter } from "next/router";

jest.mock("next/router");

const routerPush = jest.fn();
const routerReplace = jest.fn();
mocked(useRouter).mockReturnValue({
  pathname: "/",
  query: {},
  push: routerPush,
  replace: routerReplace,
} as any);

const loadedQuery = graphql`
  query NormalizedFuelTypeQuery($fuelCarbonTaxDetailId: ID!) {
    query {
      ...NormalizedFuelType_query
        @arguments(fuelCarbonTaxDetailId: $fuelCarbonTaxDetailId)
    }
  }
`;

let environment;
const TestRenderer = () => {
  const data = useLazyLoadQuery<NormalizedFuelTypeQuery>(loadedQuery, {
    fuelCarbonTaxDetailId: "test-fuel-carbon-tax-detail-id",
  });
  return <NormalizedFuelType query={data.query} pageQuery={loadedQuery} />;
};
const renderNormalizedFuelTypeComponent = () => {
  return render(
    <RelayEnvironmentProvider environment={environment}>
      <TestRenderer />
    </RelayEnvironmentProvider>
  );
};

const getMockQueryPayload = () => ({
  Query() {
    return {
      fuelCarbonTaxDetail: {
        id: "test-fuel-carbon-tax-detail-id",
        normalizedFuelType: "test-normalized-fuel-type",
        state: "test-state",
        ctaRateUnits: "test-cta-rate-units",
        unitConversionFactor: "test-unit-conversion-factor",
        carbonTaxActFuelTypeByCarbonTaxActFuelTypeId: {
          carbonTaxFuelType: "test-carbon-tax-fuel-type",
        },
        fuelMappingsByFuelCarbonTaxDetailId: {
          __id: "test-connection-id",
          edges: [
            {
              node: {
                id: "test-fuel-mapping-id",
                fuelType: "test-fuel-type",
              },
            },
          ],
        },
      },
      allFuelCarbonTaxDetails: {
        edges: [
          {
            node: {
              id: "test-normalized-fuel-id",
              normalizedFuelType: "test-normalized-fuel-type",
            },
          },
          {
            node: {
              id: "test-normalized-fuel-id-2",
              normalizedFuelType: "test-normalized-fuel-type-2",
            },
          },
        ],
      },
    };
  },
});

describe("The NormalizedFuelType component when there are unmapped fuels", () => {
  beforeEach(() => {
    jest.restoreAllMocks();

    environment = createMockEnvironment();

    environment.mock.queueOperationResolver((operation) =>
      MockPayloadGenerator.generate(operation, getMockQueryPayload())
    );

    environment.mock.queuePendingOperation(compiledNormalizedFuelTypeQuery, {
      fuelCarbonTaxDetailId: "test-fuel-carbon-tax-detail-id",
    });
  });

  it("Renders the component", () => {
    renderNormalizedFuelTypeComponent();

    expect(
      screen.getByText("Select a Normalized Fuel Type:")
    ).toBeInTheDocument();
    expect(screen.getByText("Mapped Fuel Type Variations")).toBeInTheDocument();
  });

  it("Calls the update mutation fuel is removed from the list of associated fuel types", () => {
    const mutationSpy = jest.fn();
    jest
      .spyOn(require("react-relay"), "useMutation")
      .mockImplementation(() => [mutationSpy, jest.fn()]);

    renderNormalizedFuelTypeComponent();

    fireEvent.click(screen.getAllByText("Remove")[0]);

    expect(mutationSpy).toHaveBeenCalledWith({
      onError: expect.any(Function),
      variables: {
        connections: [
          "client:test-fuel-carbon-tax-detail-id:__MappedFuelTypes_fuelMappingsByFuelCarbonTaxDetailId_connection",
        ],
        input: {
          id: "test-fuel-mapping-id",
          fuelMappingPatch: {
            fuelCarbonTaxDetailId: null,
          },
        },
      },
    });
  });

  it("when given a pageQuery prop, pre-fetches the query with the new variables", () => {
    renderNormalizedFuelTypeComponent();
    fireEvent.click(screen.getByText("test-normalized-fuel-type-2"));

    expect(routerReplace).not.toHaveBeenCalled();
    act(() => {
      environment.mock.resolveMostRecentOperation(() => ({
        data: { query: { id: "abc", __typename: "Query" } },
      }));
    });

    const expectedRoute = {
      pathname: "/",
      query: {
        fuelCarbonTaxDetailId: "test-normalized-fuel-id-2",
      },
    };

    expect(routerReplace).toHaveBeenCalledWith(expectedRoute, expectedRoute, {
      shallow: true,
    });
  });
});
