import React from "react";
import { SwrsBrowser, SwrsBrowserQuery } from "../../../pages/ggircs/swrs-browser";
import { render, screen } from "@testing-library/react";
import "@testing-library/jest-dom";
import {
  createMockEnvironment,
  MockPayloadGenerator,
  RelayMockEnvironment,
} from "relay-test-utils";
import { RelayEnvironmentProvider, loadQuery } from "react-relay";
import { swrsBrowserQuery } from "__generated__/swrsBrowserQuery.graphql";
import { MockResolvers } from "relay-test-utils/lib/RelayMockPayloadGenerator";

let environment: RelayMockEnvironment;
let initialQueryRef;

const defaultMockResolver = {
  Query() {
    return {
      session: { ggircsUserBySub: {} },
    };
  },
};

const loadTestQuery = (mockResolver: MockResolvers = defaultMockResolver) => {
  environment.mock.queueOperationResolver((operation) => {
    return MockPayloadGenerator.generate(operation, mockResolver);
  });

  environment.mock.queuePendingOperation(SwrsBrowserQuery, {});
  initialQueryRef = loadQuery<swrsBrowserQuery>(
    environment,
    SwrsBrowserQuery,
    {}
  );
};

const renderComponentUnderTest = () =>
  render(
    <RelayEnvironmentProvider environment={environment}>
      <SwrsBrowser CSN preloadedQuery={initialQueryRef} />
    </RelayEnvironmentProvider>
  );

describe("The swrs-browser page", () => {
  beforeEach(() => {
    environment = createMockEnvironment();
  });

  it("renders the swrs-browser page", () => {
    loadTestQuery();
    renderComponentUnderTest();

    expect(
      screen.getByText(
        /ECCC SWRS File Explorer/i
      )
    ).toBeInTheDocument();
  });
});

