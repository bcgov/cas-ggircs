import React from "react";
import { EcccFile } from "next-env";
import { mount } from "enzyme";
import { act } from "react-dom/test-utils";
import FileList from "components/SwrsBrowser/FileList";

const ecccFiles: EcccFile[] = [
  {
    created_at: "Thu, 14 May 2020 05:25:43 GMT",
    name: "a.zip",
    size: 69.45,
  },
  {
    created_at: "Thu, 14 May 2020 05:31:32 GMT",
    name: "b.zip",
    size: 290.54,
  },
  {
    created_at: "Thu, 14 May 2020 05:31:30 GMT",
    name: "c.zip",
    size: 290.45,
  },
];

const mockFetch = async (url: string) => {
  if (url === "/api/eccc/files") {
    return {
      json: async () => ecccFiles,
    };
  }

  return {
    json: async () => ({
      zip_content_list: ["a.txt", "b.txt"],
    }),
  };
};

describe("The FileList component", () => {
  beforeAll(() => {
    jest.spyOn(global.Math, "random").mockImplementation(() => 0);
    global.fetch = jest.fn().mockImplementation(mockFetch);
  });

  afterAll(() => {
    global.fetch.mockClear();
    delete global.fetch;
  });

  it("should load the list of files", async () => {
    const component = await mount(<FileList />);
    await act(async () => {
      //
      await new Promise((resolve) => setImmediate(resolve));
      component.update();
    });
    expect(component).toMatchSnapshot();
    expect(component.find("button.list-group-item")).toHaveLength(3);
  });

  it("should load a file's content when clicking on it", async () => {
    const component = await mount(<FileList />);
    await act(async () => {
      await new Promise((resolve) => setImmediate(resolve));
      component.update();
      component.find("button.list-group-item").first().simulate("click");
      await new Promise((resolve) => setImmediate(resolve));
      component.update();
    });

    expect(component).toMatchSnapshot();
    expect(component.find("button.list-group-item.active")).toHaveLength(1);
    expect(component.find(".col-md-8 .list-group-item a")).toHaveLength(2);
  });
});
