import { shallow } from "enzyme";
import LoginRedirect from "pages/login-redirect";

describe("re-direct", () => {
  it("matches the last accepted Snapshot", () => {
    const wrapper = shallow(
      <LoginRedirect
        query={{
          session: null,
        }}
        router={{
          query: {
            sessionIdled: false,
          },
        }}
      />
    );
    expect(wrapper).toMatchSnapshot();
  });
});

describe("re-direct session idled", () => {
  it("matches the last accepted Snapshot", () => {
    const wrapper = shallow(
      <LoginRedirect
        query={{
          session: null,
        }}
        router={{
          query: {
            sessionIdled: true,
          },
        }}
      />
    );
    expect(wrapper).toMatchSnapshot();
  });
});
