import React from "react";
import { render, screen, fireEvent } from "@testing-library/react";
import UnmappedFuelTypes from "components/FuelManagement/UnmappedFuelTypes";
import {
  graphql,
  RelayEnvironmentProvider,
  useLazyLoadQuery,
} from "react-relay";
import { createMockEnvironment, MockPayloadGenerator } from "relay-test-utils";
import compiledUnmappedFuelTypesQuery, {
  UnmappedFuelTypesQuery,
} from "__generated__/UnmappedFuelTypesQuery.graphql";

const loadedQuery = graphql`
  query UnmappedFuelTypesQuery {
    query {
      ...UnmappedFuelTypes_query
    }
  }
`;

let environment;
const TestRenderer = () => {
  const data = useLazyLoadQuery<UnmappedFuelTypesQuery>(loadedQuery, {
    fuelCarbonTaxDetailId: "test-fuel-carbon-tax-detail-id",
  });
  return <UnmappedFuelTypes query={data.query} />;
};
const renderUnmappedFuelTypesComponent = () => {
  return render(
    <RelayEnvironmentProvider environment={environment}>
      <TestRenderer />
    </RelayEnvironmentProvider>
  );
};

const getMockQueryPayload = () => ({
  Query() {
    return {
      unmappedFuel: {
        edges: [
          {
            node: {
              fuelType: "test-fuel-type-1",
              fuelMappingId: null,
            },
          },
          {
            node: {
              fuelType: "test-fuel-type-2",
              fuelMappingId: 1,
            },
          },
        ],
      },
      allFuelCarbonTaxDetails: {
        edges: [
          {
            node: {
              id: "test-normalized-fuel-id",
              rowId: 1,
              normalizedFuelType: "test-normalized-fuel-type",
              fuelMappingsByFuelCarbonTaxDetailId: {
                __id: "test-connection-id",
                edges: [
                  {
                    node: {
                      __typename: "FuelMapping",
                    },
                  },
                ],
              },
            },
          },
        ],
      },
    };
  },
});

const getNoFuelsMockQueryPayload = () => ({
  Query() {
    return {
      unmappedFuel: {
        edges: [],
      },
      allFuelCarbonTaxDetails: {
        edges: [
          {
            node: {
              id: "test-normalized-fuel-id",
              rowId: 1,
              normalizedFuelType: "test-normalized-fuel-type",
              fuelMappingsByFuelCarbonTaxDetailId: {
                __id: "test-connection-id",
                edges: [
                  {
                    node: {
                      __typename: "FuelMapping",
                    },
                  },
                ],
              },
            },
          },
        ],
      },
    };
  },
});

describe("The UnmappedFuelTypes component when there are unmapped fuels", () => {
  beforeEach(() => {
    jest.restoreAllMocks();

    environment = createMockEnvironment();

    environment.mock.queueOperationResolver((operation) =>
      MockPayloadGenerator.generate(operation, getMockQueryPayload())
    );

    environment.mock.queuePendingOperation(compiledUnmappedFuelTypesQuery, {
      fuelCarbonTaxDetailId: "test-fuel-carbon-tax-detail-id",
    });
  });

  it("Renders the component", () => {
    renderUnmappedFuelTypesComponent();

    expect(
      screen.getByText("Normalize un-mapped SWRS fuel types")
    ).toBeInTheDocument();
    expect(screen.getByText("Un-mapped fuel type")).toBeInTheDocument();
    expect(
      screen.getByText("Select a normalized fuel type")
    ).toBeInTheDocument();
  });

  it("Calls the create mutation when a change is made in the Manager dropdown and the fuelMappingId is null", () => {
    const mutationSpy = jest.fn();
    jest
      .spyOn(require("react-relay"), "useMutation")
      .mockImplementation(() => [mutationSpy, jest.fn()]);

    JSON.parse = jest.fn().mockImplementationOnce(() => {
      return {
        rowId: 1,
        connectionId:
          "client:test-normalized-fuel-id:__MappedFuelTypes_fuelMappingsByFuelCarbonTaxDetailId_connection",
      };
    });

    renderUnmappedFuelTypesComponent();

    fireEvent.click(screen.getAllByText("Apply")[0]);

    expect(mutationSpy).toHaveBeenCalledWith({
      onError: expect.any(Function),
      variables: {
        connections: [
          "client:test-normalized-fuel-id:__MappedFuelTypes_fuelMappingsByFuelCarbonTaxDetailId_connection",
        ],
        input: {
          fuelCarbonTaxDetailIdInput: 1,
          fuelTypeInput: "test-fuel-type-1",
        },
      },
    });
  });

  it("Calls the update mutation when a change is made in the Manager dropdown and the fuelMappingId is not null", () => {
    const mutationSpy = jest.fn();
    jest
      .spyOn(require("react-relay"), "useMutation")
      .mockImplementation(() => [mutationSpy, jest.fn()]);

    JSON.parse = jest.fn().mockImplementationOnce(() => {
      return {
        rowId: 1,
        connectionId:
          "client:test-normalized-fuel-id:__MappedFuelTypes_fuelMappingsByFuelCarbonTaxDetailId_connection",
      };
    });

    renderUnmappedFuelTypesComponent();

    fireEvent.click(screen.getAllByText("Apply")[1]);

    expect(mutationSpy).toHaveBeenCalledWith({
      onError: expect.any(Function),
      variables: {
        connections: [
          "client:test-normalized-fuel-id:__MappedFuelTypes_fuelMappingsByFuelCarbonTaxDetailId_connection",
        ],
        input: {
          fuelMappingPatch: {
            fuelCarbonTaxDetailId: 1,
          },
          rowId: 1,
        },
      },
    });
  });
});

describe("The UnmappedFuelTypes component when there are no unmapped fuels", () => {
  beforeEach(() => {
    jest.restoreAllMocks();

    environment = createMockEnvironment();

    environment.mock.queueOperationResolver((operation) =>
      MockPayloadGenerator.generate(operation, getNoFuelsMockQueryPayload())
    );

    environment.mock.queuePendingOperation(compiledUnmappedFuelTypesQuery, {
      fuelCarbonTaxDetailId: "test-fuel-carbon-tax-detail-id",
    });
  });

  it("Does not render the component", () => {
    renderUnmappedFuelTypesComponent();

    expect(
      screen.queryByText("Normalize un-mapped SWRS fuel types")
    ).not.toBeInTheDocument();
    expect(screen.queryByText("Un-mapped fuel type")).not.toBeInTheDocument();
    expect(
      screen.queryByText("Select a normalized fuel type")
    ).not.toBeInTheDocument();
  });
});
