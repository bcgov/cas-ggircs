import { shallow } from "enzyme";
import Index from "pages/ggircs";

describe("landing", () => {
  it("matches the last accepted Snapshot", () => {
    const wrapper = shallow(
      <Index
        query={{
          session: null,
        }}
      />
    );
    expect(wrapper).toMatchSnapshot();
  });
});
