import React from "react";
import {
  CarbonTaxActManagement,
  CarbonTaxActManagementQuery,
} from "../../../../pages/ggircs/carbon-tax-act-management";
import { render, screen } from "@testing-library/react";
import "@testing-library/jest-dom";
import {
  createMockEnvironment,
  MockPayloadGenerator,
  RelayMockEnvironment,
} from "relay-test-utils";
import { RelayEnvironmentProvider, loadQuery } from "react-relay";
import {
  carbonTaxActManagementQuery,
  carbonTaxActManagementQuery$variables,
} from "__generated__/carbonTaxActManagementQuery.graphql";
import { MockResolvers } from "relay-test-utils/lib/RelayMockPayloadGenerator";
import { useRouter } from "next/router";
import { mocked } from "jest-mock";
import debounce from "lodash.debounce";

jest.mock("next/router");
jest.mock("lodash.debounce");

mocked(debounce).mockImplementation((fn) => fn);

mocked(useRouter).mockReturnValue({
  route: "/carbon-tax-act-management",
  query: {},
  push: jest.fn(),
} as any);

let environment: RelayMockEnvironment;
let initialQueryRef;

const defaultMockResolver = {
  Query() {
    return {
      session: { ggircsUserBySub: {} },
      carbonTaxActFuelType: {
        id: "test-id",
        rowId: 1,
        carbonTaxFuelType: "test-fuel",
        ctaRateUnits: "test-units",
        fuelChargesByCarbonTaxActFuelTypeId: {
          __id: "connection-id",
          edges: [
            {
              node: {
                id: "test-charge-id",
                startDate: "2020-01-01",
                endDate: "2020-01-31",
                fuelCharge: 0.5,
                metadata: "test-metadata",
              },
            },
          ],
        },
      },
      allCarbonTaxActFuelTypes: {
        allCarbonTaxActFuelTypes: {
          edges: [
            {
              node: {
                id: "test-fuel-id",
                carbonTaxFuelType: "test-fuel",
              },
            },
          ],
        },
      },
    };
  },
};

const loadTestQuery = (mockResolver: MockResolvers = defaultMockResolver) => {
  const variables: carbonTaxActManagementQuery$variables = {
    carbonTaxActFuelTypeId: "",
  };

  environment.mock.queueOperationResolver((operation) => {
    return MockPayloadGenerator.generate(operation, mockResolver);
  });

  environment.mock.queuePendingOperation(
    CarbonTaxActManagementQuery,
    variables
  );
  initialQueryRef = loadQuery<carbonTaxActManagementQuery>(
    environment,
    CarbonTaxActManagementQuery,
    variables
  );
};

const renderComponentUnderTest = () =>
  render(
    <RelayEnvironmentProvider environment={environment}>
      <CarbonTaxActManagement CSN preloadedQuery={initialQueryRef} />
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

  it("renders the CTA management page", async () => {
    loadTestQuery();
    renderComponentUnderTest();

    expect(
      await screen.findByText(/Carbon Tax Act Management/i)
    ).toBeInTheDocument();
  });
});
