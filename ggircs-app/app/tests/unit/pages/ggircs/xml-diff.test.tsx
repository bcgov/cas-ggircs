import React from "react";
import { XmlDiff, XmlDiffQuery } from "../../../../pages/ggircs/xml-diff";
import { fireEvent, render, screen } from "@testing-library/react";
import "@testing-library/jest-dom";
import {
  createMockEnvironment,
  MockPayloadGenerator,
  RelayMockEnvironment,
} from "relay-test-utils";
import { RelayEnvironmentProvider, loadQuery } from "react-relay";
import {
  xmlDiffQuery,
  xmlDiffQuery$variables,
} from "__generated__/xmlDiffQuery.graphql";
import { MockResolvers } from "relay-test-utils/lib/RelayMockPayloadGenerator";
import { useRouter } from "next/router";
import { mocked } from "jest-mock";
import { act } from "react-dom/test-utils";
import debounce from "lodash.debounce";

jest.mock("next/router");
jest.mock("lodash.debounce");

mocked(debounce).mockImplementation((fn) => fn);

mocked(useRouter).mockReturnValue({
  route: "/xml-diiff",
  query: {},
  push: jest.fn(),
} as any);

let environment: RelayMockEnvironment;
let initialQueryRef;

const defaultMockResolver = {
  Query() {
    return {
      session: { ggircsUserBySub: {} },
      allReports: {
        edges: [
          {
            node: {
              id: "1",
              swrsReportId: 123,
            },
          },
          {
            node: {
              id: "2",
              swrsReportId: 456,
            },
          },
        ],
      },
    };
  },
};

const loadTestQuery = (mockResolver: MockResolvers = defaultMockResolver) => {
  const variables: xmlDiffQuery$variables = {
    FirstSideRelayId: "1",
    SecondSideRelayId: "2",
  };

  environment.mock.queueOperationResolver((operation) => {
    return MockPayloadGenerator.generate(operation, mockResolver);
  });

  environment.mock.queuePendingOperation(XmlDiffQuery, variables);
  initialQueryRef = loadQuery<xmlDiffQuery>(
    environment,
    XmlDiffQuery,
    variables
  );
};

const renderComponentUnderTest = () =>
  render(
    <RelayEnvironmentProvider environment={environment}>
      <XmlDiff CSN preloadedQuery={initialQueryRef} />
    </RelayEnvironmentProvider>
  );

describe("The xml-diff page", () => {
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

  it("renders the xml diff page", async () => {
    jest
      .spyOn(require("components/XmlDiff/RenderDiff"), "default")
      .mockImplementation(() => <div>mock RenderDiff</div>);

    loadTestQuery();
    renderComponentUnderTest();

    expect(await screen.findByText(/ECCC SWRS XML Diff/i)).toBeInTheDocument();
  });

  it("allows the user to select reports", async () => {
    jest
      .spyOn(require("components/XmlDiff/RenderDiff"), "default")
      .mockImplementation(() => <div>mock RenderDiff</div>);
    const mockRouterImplementation = {
      push: jest.fn(),
      query: {
        existingParam: "existingValue",
      },
      pathname: "test-pathname",
    };
    jest
      .spyOn(require("next/router"), "useRouter")
      .mockImplementation(() => mockRouterImplementation);

    loadTestQuery();
    renderComponentUnderTest();

    const inputs = await screen.findAllByPlaceholderText("eg. 17778");
    expect(inputs).toHaveLength(2);

    act(() => {
      fireEvent.change(inputs[0], { target: { value: 123 } });
    });

    expect(mockRouterImplementation.push).toHaveBeenCalledWith(
      {
        pathname: "test-pathname",
        query: {
          FirstSideId: 123,
          FirstSideRelayId: "1",
          existingParam: "existingValue",
        },
      },
      {
        pathname: "test-pathname",
        query: {
          FirstSideId: 123,
          FirstSideRelayId: "1",
          existingParam: "existingValue",
        },
      },
      { shallow: true }
    );
  });

  it("shares the same router instance between report selectors", async () => {
    jest
      .spyOn(require("components/XmlDiff/RenderDiff"), "default")
      .mockImplementation(() => <div>mock RenderDiff</div>);

    const calledRouters = [];
    jest
      .spyOn(require("components/XmlDiff/ReportSelector"), "default")
      .mockImplementation((props) => {
        calledRouters.push(props.router);
        return <div>mock ReportSelector</div>;
      });

    loadTestQuery();
    renderComponentUnderTest();

    await screen.findAllByText(/ECCC SWRS XML Diff/i);

    expect(calledRouters).toHaveLength(2);
    expect(calledRouters[0]).toBe(calledRouters[1]);
  });
});
