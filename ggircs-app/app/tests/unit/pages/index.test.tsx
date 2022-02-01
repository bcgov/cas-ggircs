import React from "react";
import { GgircsLanding, GgircsLandingQuery } from "../../../pages/ggircs/index";
import { render, screen } from "@testing-library/react";
import "@testing-library/jest-dom";
import {
  createMockEnvironment,
  MockPayloadGenerator,
  RelayMockEnvironment,
} from "relay-test-utils";
import { RelayEnvironmentProvider, loadQuery } from "react-relay";
import { ggircsLandingQuery } from "__generated__/ggircsLandingQuery.graphql";
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

const loadIndexQuery = (mockResolver: MockResolvers = defaultMockResolver) => {
  environment.mock.queueOperationResolver((operation) => {
    return MockPayloadGenerator.generate(operation, mockResolver);
  });

  environment.mock.queuePendingOperation(GgircsLandingQuery, {});
  initialQueryRef = loadQuery<ggircsLandingQuery>(
    environment,
    GgircsLandingQuery,
    {}
  );
};

const renderIndex = () =>
  render(
    <RelayEnvironmentProvider environment={environment}>
      <GgircsLanding CSN preloadedQuery={initialQueryRef} />
    </RelayEnvironmentProvider>
  );

describe("The index page", () => {
  beforeEach(() => {
    environment = createMockEnvironment();
  });

  it("renders the index page", () => {
    loadIndexQuery();
    renderIndex();

    expect(
      screen.getByText(
        /Access reports and attachments from the Single Window Reporting System/i
      )
    ).toBeInTheDocument();
  });
});
