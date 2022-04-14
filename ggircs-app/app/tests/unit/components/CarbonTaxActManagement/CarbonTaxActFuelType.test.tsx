import React from "react";
import { render, screen, fireEvent } from "@testing-library/react";
import CarbonTaxActFuelType from "components/FuelManagement/CarbonTaxActFuelType";
import {
  graphql,
  RelayEnvironmentProvider,
  useLazyLoadQuery,
} from "react-relay";
import { createMockEnvironment, MockPayloadGenerator } from "relay-test-utils";
import compiledCarbonTaxActFuelTypeQuery, {
  CarbonTaxActFuelTypeQuery,
} from "__generated__/CarbonTaxActFuelTypeQuery.graphql";
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
  query CarbonTaxActFuelTypeQuery($carbonTaxActFuelTypeId: ID!) {
    query {
      ...CarbonTaxActFuelType_query
        @arguments(carbonTaxActFuelTypeId: $carbonTaxActFuelTypeId)
    }
  }
`;

let environment;
const TestRenderer = () => {
  const data = useLazyLoadQuery<CarbonTaxActFuelTypeQuery>(loadedQuery, {
    carbonTaxActFuelTypeId: "test-fuel-id",
  });
  return <CarbonTaxActFuelType query={data.query} pageQuery={loadedQuery} />;
};
const renderCarbonTaxActFuelTypeComponent = () => {
  return render(
    <RelayEnvironmentProvider environment={environment}>
      <TestRenderer />
    </RelayEnvironmentProvider>
  );
};

const getMockQueryPayload = () => ({
  Query() {
    return {
      carbonTaxActFuelType: {
        id: "test-fuel-id",
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
});

describe("The CarbonTaxActFuelType component", () => {
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
    jest.restoreAllMocks();

    environment = createMockEnvironment();

    environment.mock.queueOperationResolver((operation) =>
      MockPayloadGenerator.generate(operation, getMockQueryPayload())
    );

    environment.mock.queuePendingOperation(compiledCarbonTaxActFuelTypeQuery, {
      carbonTaxActFuelTypeId: "test-fuel-id",
    });
  });

  it("Renders the component", () => {
    renderCarbonTaxActFuelTypeComponent();

    expect(screen.getByText("Select a carbon taxed fuel:")).toBeInTheDocument();
  });

  it("Calls the update mutation when editing a fuel charge", () => {
    const mutationSpy = jest.fn();
    jest
      .spyOn(require("react-relay"), "useMutation")
      .mockImplementation(() => [mutationSpy, jest.fn()]);

    renderCarbonTaxActFuelTypeComponent();

    fireEvent.click(screen.getByTitle("edit-icon-test-charge-id"));
    const chargeInput = screen.getAllByLabelText(/Charge/i)[0] as any;
    fireEvent.change(chargeInput, { target: { value: "0.9" } });
    fireEvent.click(screen.getAllByRole("button", { name: /save/i })[0]);

    expect(mutationSpy).toHaveBeenCalledWith({
      variables: {
        input: {
          fuelChargePatch: {
            endDate: "2020-01-31",
            fuelCharge: "0.9",
            metadata: "test-metadata",
            startDate: "2020-01-01",
          },
          id: "test-charge-id",
        },
      },
    });
  });

  it("Calls the create mutation when adding a fuel charge", () => {
    const mutationSpy = jest.fn();
    jest
      .spyOn(require("react-relay"), "useMutation")
      .mockImplementation(() => [mutationSpy, jest.fn()]);

    renderCarbonTaxActFuelTypeComponent();

    const startInput = screen.getByLabelText(/Period Start/i) as any;
    const endInput = screen.getByLabelText(/Period End/i) as any;
    const chargeInput = screen.getAllByLabelText(/Charge/i)[2] as any;
    fireEvent.change(startInput, { target: { value: "2099-04-01" } });
    fireEvent.change(endInput, { target: { value: "2100-03-31" } });
    fireEvent.change(chargeInput, { target: { value: "0.5" } });
    fireEvent.click(screen.getAllByRole("button", { name: /save/i })[0]);

    expect(mutationSpy).toHaveBeenCalledWith({
      variables: {
        connections: [
          'client:test-fuel-id:__CarbonTaxActFuelType_fuelChargesByCarbonTaxActFuelTypeId_connection(orderBy:"START_DATE_ASC")',
        ],
        input: {
          fuelCharge: {
            carbonTaxActFuelTypeId: 1,
            endDate: "2100-03-31",
            fuelCharge: "0.5",
            metadata: "",
            startDate: "2099-04-01",
          },
        },
      },
    });
  });
});
