import React from "react";
import { shallow } from "enzyme";
import XmlDiff from "pages/xml-diff";

describe("The swrs-browser page", () => {
  it("renders the diff component when it has two defined xml reports & showDiff is set to true", () => {
    const wrapper = shallow(
      <XmlDiff
        query={{
          session: null,
          allReports: { edges: null },
        }}
      />
    );
    const leftSideReport = {
      submissionDate: "Jan 1 2020",
      ecccXmlFileByEcccXmlFileId: {
        xmlFileName: "xmltestL",
        xmlFile: "<report1></report1>",
        ecccZipFileByZipFileId: {
          zipFileName: "ziptest",
        },
      },
    };
    const rightSideReport = {
      submissionDate: "Jan 2 2020",
      ecccXmlFileByEcccXmlFileId: {
        xmlFileName: "xmltestR",
        xmlFile: "<report2></report2>",
        ecccZipFileByZipFileId: {
          zipFileName: "ziptestR",
        },
      },
    };
    wrapper.setState({
      leftSideReport,
      rightSideReport,
      leftSideId: 1,
      rightSideId: 2,
      isReversed: false,
      isCollapsed: false,
      renderDiff: true,
    });
    expect(wrapper).toMatchSnapshot();
  });
});
