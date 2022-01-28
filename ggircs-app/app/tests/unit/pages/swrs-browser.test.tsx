import { shallow } from "enzyme";
import SwrsBrowser from "pages/swrs-browser";

describe("The swrs-browser page", () => {
  it("matches the last accepted Snapshot", () => {
    const wrapper = shallow(
      <SwrsBrowser
        query={{
          session: null,
        }}
      />
    );
    expect(wrapper).toMatchSnapshot();
  });
});
