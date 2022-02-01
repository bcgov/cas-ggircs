import React from "react";
import { XmlDiff, XmlDiffQuery } from "../../../pages/ggircs/xml-diff";
import { render, screen } from "@testing-library/react";
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
jest.mock("next/router");

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
              swrsReportId: "1",
            },
          },
          {
            node: {
              id: "2",
              swrsReportId: "2",
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
  beforeEach(() => {
    environment = createMockEnvironment();
  });

  it("renders the xml diff page", () => {
    loadTestQuery();
    renderComponentUnderTest();

    expect(screen.getByText(/ECCC SWRS XML Diff/i)).toBeInTheDocument();
  });
});
