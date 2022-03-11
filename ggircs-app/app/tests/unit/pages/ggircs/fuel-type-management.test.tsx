import React from "react";
import {
  FuelTypeManagement,
  FuelTypeManagementQuery,
} from "../../../../pages/ggircs/fuel-type-management";
import { render, screen } from "@testing-library/react";
import "@testing-library/jest-dom";
import {
  createMockEnvironment,
  MockPayloadGenerator,
  RelayMockEnvironment,
} from "relay-test-utils";
import { RelayEnvironmentProvider, loadQuery } from "react-relay";
import {
  fuelTypeManagementQuery,
  fuelTypeManagementQuery$variables,
} from "__generated__/fuelTypeManagementQuery.graphql";
import { MockResolvers } from "relay-test-utils/lib/RelayMockPayloadGenerator";
import { useRouter } from "next/router";
import { mocked } from "jest-mock";
import debounce from "lodash.debounce";

jest.mock("next/router");
jest.mock("lodash.debounce");

mocked(debounce).mockImplementation((fn) => fn);

mocked(useRouter).mockReturnValue({
  route: "/fuel-type-management",
  query: {},
  push: jest.fn(),
} as any);

let environment: RelayMockEnvironment;
let initialQueryRef;

const defaultMockResolver = {
  Query() {
    return {
      session: { ggircsUserBySub: {} },
      fuelCarbonTaxDetail: {
        id: "test-deteail-id",
        normalizedFuelType: "test-normalized-fuel-type",
        state: "solid",
        ctaRateUnits: "tonnes",
        unitConversionFactor: "$/tonne",
        carbonTaxActFuelTypeByCarbonTaxActFuelTypeId: {
          carbonTaxFuelType: "test-carbon-tax-fuel-type",
        },
        fuelMappingsByFuelCarbonTaxDetailId: {
          __id: "test-fuel-mapping-connection-id",
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
      normalizedFuels: {
        allFuelCarbonTaxDetails: {
          edges: [
            {
              node: {
                id: "test-normalized-fuel-id",
                normalizedFuelType: "test-normalized-fuel-type",
              },
            },
          ],
        },
      },
      unmappedFuel: {
        edges: [
          {
            node: {
              fuelType: "unmapped-test-fuel-type",
              fuelMappingId: null,
            },
          },
        ],
      },
      moreNormalizedFuel: {
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
                        __typename: "test-typename",
                      },
                    },
                  ],
                },
              },
            },
          ],
        },
      },
    };
  },
};

const loadTestQuery = (mockResolver: MockResolvers = defaultMockResolver) => {
  const variables: fuelTypeManagementQuery$variables = {
    fuelCarbonTaxDetailId: "test-",
  };

  environment.mock.queueOperationResolver((operation) => {
    return MockPayloadGenerator.generate(operation, mockResolver);
  });

  environment.mock.queuePendingOperation(FuelTypeManagementQuery, variables);
  initialQueryRef = loadQuery<fuelTypeManagementQuery>(
    environment,
    FuelTypeManagementQuery,
    variables
  );
};

const renderComponentUnderTest = () =>
  render(
    <RelayEnvironmentProvider environment={environment}>
      <FuelTypeManagement CSN preloadedQuery={initialQueryRef} />
    </RelayEnvironmentProvider>
  );

describe("The fuel type management page", () => {
  // this is the jest official way:
  // https://jestjs.io/docs/26.x/manual-mocks#mocking-methods-which-are-not-implemented-in-jsdom
  beforeAll(() => {
    Object.defineProperty(window, "matchMedia", {
      writable: true,
      value: jest.fn().mockImplementation((query) => ({
        matches: false,
        media: query,
        onchange: null,
        addListener: jest.fn(), // Deprecated
        removeListener: jest.fn(), // Deprecated
        addEventListener: jest.fn(),
        removeEventListener: jest.fn(),
        dispatchEvent: jest.fn(),
      })),
    });
  });

  beforeEach(() => {
    environment = createMockEnvironment();
    mocked(debounce).mockClear();
  });

  it("renders the fuel type management page", async () => {
    loadTestQuery();
    renderComponentUnderTest();

    expect(
      await screen.findByText(/Fuel Type Management/i)
    ).toBeInTheDocument();
  });
});
