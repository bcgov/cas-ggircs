import logAxeResults from "../plugins/logAxeResults";

before(() => {
  cy.sqlFixture("carbon-tax-act-management-setup");
});

after(() => {
  cy.sqlFixture("carbon-tax-act-management-teardown");
});

describe("When using the carbon tax act management tool", () => {
  beforeEach(() => {
    cy.mockLogin("GGIRCS User");
    cy.visit("/ggircs/carbon-tax-act-management?showAll=false");
  });
  afterEach(() => {
    cy.logout();
  });
  it("can show and hide all rate periods", () => {
    cy.get(".page-title").contains("Carbon Tax Act Management");
    cy.contains("Butterflies").click();
    cy.get("tbody.jsx-882639014 > :nth-child(1) > :nth-child(1)").contains(
      "2020-04-01"
    );
    cy.get("tbody.jsx-882639014 > :nth-child(1) > :nth-child(1)").contains(
      "2020"
    );
    cy.get("#show-hide-toggle").click();
    cy.get("tbody.jsx-882639014 > :nth-child(1) > :nth-child(1)").contains(
      "1899"
    );
    cy.injectAxe();
    cy.checkA11y("main", null, logAxeResults);
    cy.get("body").happoScreenshot({
      component: "Carbon Tax Act Management",
      variant: "view tax rate data",
    });
  });

  it("can edit a rate period", () => {
    cy.get(".page-title").contains("Carbon Tax Act Management");
    cy.contains("Butterflies").click();
    cy.get(".edit-button").first().click();
    cy.injectAxe();
    cy.checkA11y(".table-responsive", null, logAxeResults);
    cy.get(".table-responsive").happoScreenshot({
      component: "Carbon Tax Act Management",
      variant: "edit tax rate data",
    });
    cy.get("input[name=charge]").first().clear().type("0.5");
    cy.get(".save-cancel-button").first().click();
    cy.get("tbody.jsx-882639014 > :nth-child(1) > :nth-child(3)").contains(
      "0.5"
    );
  });

  it("cannot create a rate period that overlaps with an existing rate period", () => {
    cy.get(".page-title").contains("Carbon Tax Act Management");
    cy.contains("Butterflies").click();
    cy.get("input[name=start-date]").click().type("2020-01-01");
    cy.get("input[name=end-date]").click();
    cy.get(":nth-child(5) > :nth-child(1)").contains("Date overlaps");
    cy.get(".save-button-disabled").should("exist");
  });

  it("can create a rate period", () => {
    cy.get(".page-title").contains("Carbon Tax Act Management");
    cy.contains("Butterflies").click();
    cy.get("input[name=start-date]").click().type("2099-04-01");
    cy.get("input[name=end-date]").click().type("2100-03-31");
    cy.get("input[name=charge]").clear().type("0.5");
    cy.get(".save-cancel-button").first().click();
    cy.get("tbody.jsx-882639014 > :nth-child(3) > :nth-child(1)").contains(
      "2099-04-01"
    );
  });
});
