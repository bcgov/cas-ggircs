import React from "react";
import {
  LoginRedirect,
  LoginRedirectQuery,
} from "../../../pages/login-redirect";
import { render, screen } from "@testing-library/react";
import "@testing-library/jest-dom";
import {
  createMockEnvironment,
  MockPayloadGenerator,
  RelayMockEnvironment,
} from "relay-test-utils";
import { RelayEnvironmentProvider, loadQuery } from "react-relay";
import { loginRedirectQuery } from "__generated__/loginRedirectQuery.graphql";
import { MockResolvers } from "relay-test-utils/lib/RelayMockPayloadGenerator";
import { useRouter } from "next/router";
import { mocked } from "jest-mock";
jest.mock("next/router");

mocked(useRouter).mockReturnValue({
  route: "/login-redirect",
  query: { sessionIdled: false },
  push: jest.fn(),
} as any);

let environment: RelayMockEnvironment;
let initialQueryRef;

const defaultMockResolver = {
  Query() {
    return {
      session: null,
    };
  },
};

const loadTestQuery = (mockResolver: MockResolvers = defaultMockResolver) => {
  environment.mock.queueOperationResolver((operation) => {
    return MockPayloadGenerator.generate(operation, mockResolver);
  });

  environment.mock.queuePendingOperation(LoginRedirectQuery, {});
  initialQueryRef = loadQuery<loginRedirectQuery>(
    environment,
    LoginRedirectQuery,
    {}
  );
};

const renderComponentUnderTest = () =>
  render(
    <RelayEnvironmentProvider environment={environment}>
      <LoginRedirect CSN preloadedQuery={initialQueryRef} />
    </RelayEnvironmentProvider>
  );

describe("The login-redirect page", () => {
  beforeEach(() => {
    environment = createMockEnvironment();
  });

  it("renders the login-redirect page", () => {
    loadTestQuery();
    renderComponentUnderTest();

    const router = useRouter();
    expect(router.query.sessionIdled).toBe(false);
    expect(
      screen.getByText(/Please log in to access this page./i)
    ).toBeInTheDocument();
  });

  it("renders the login-redirect page", () => {
    mocked(useRouter).mockReturnValue({
      route: "/login-redirect",
      query: { sessionIdled: true },
      push: jest.fn(),
    } as any);

    loadTestQuery();
    renderComponentUnderTest();

    const router = useRouter();
    expect(router.query.sessionIdled).toBe(true);
    expect(
      screen.getByText(/You were logged out due to inactivity./i)
    ).toBeInTheDocument();
  });
});
