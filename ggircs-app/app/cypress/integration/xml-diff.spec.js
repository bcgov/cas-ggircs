before(() => {
  cy.sqlFixture("xml-diff-setup");
});

after(() => {
  cy.sqlFixture("xml-diff-teardown");
});

describe("When using the XML diff tool", () => {
  beforeEach(() => {
    cy.mockLogin("GGIRCS User");
    cy.visit("/ggircs/xml-diff");
  });
  afterEach(() => {
    cy.logout();
  });
  it("loads the xml diff", () => {
    cy.get(".page-title").contains("ECCC SWRS XML Diff");
    // Input report ID values to display the diff
    cy.get(".order-md-1 > :nth-child(1) > .sc-bBrNTY > #report-id-input")
      .clear()
      .type("1");
    cy.get(".order-md-2 > :nth-child(1) > .sc-bBrNTY > #report-id-input")
      .clear()
      .type("2");

    // The diff properly loads
    cy.get(".order-md-1 > .row > :nth-child(2)").should("contain", "ZIPPITY_1");
    cy.get(".order-md-2 > .row > :nth-child(2)").should("contain", "DIPPITY_2");
    cy.get(":nth-child(3) > .diff-code-delete").should("contain", "1");
    cy.get(":nth-child(3) > .diff-code-insert").should("contain", "2");
    cy.get(":nth-child(13) > .diff-code-delete").should("contain", "true");
    cy.get(":nth-child(13) > .diff-code-insert").should("contain", "false");

    cy.get("body").happoScreenshot({
      component: "XML Diff",
      variant: "shows diff",
    });

    // Swap the sides of the diff
    cy.contains("Swap").click();

    // The diff properly swaps
    cy.get(".order-md-1 > .row > :nth-child(2)").should("contain", "DIPPITY_2");
    cy.get(".order-md-2 > .row > :nth-child(2)").should("contain", "ZIPPITY_1");

    cy.get(":nth-child(3) > .diff-code-delete").should("contain", "2");
    cy.get(":nth-child(3) > .diff-code-insert").should("contain", "1");
    cy.get(":nth-child(13) > .diff-code-delete").should("contain", "false");
    cy.get(":nth-child(13) > .diff-code-insert").should("contain", "true");

    // Summarize the diff (close unchanged lines)
    cy.get(".switch-off").click();

    // Unchanged lines have been removed and changed lines still show up
    cy.contains("grade").should("not.exist");
    cy.get(":nth-child(2) > .diff-line-compare > .diff-code-delete").should(
      "contain",
      "2"
    );
    cy.get(":nth-child(2) > .diff-line-compare > .diff-code-insert").should(
      "contain",
      "1"
    );
    cy.get(":nth-child(3) > .diff-line-compare > .diff-code-delete").should(
      "contain",
      "false"
    );
    cy.get(":nth-child(3) > .diff-line-compare > .diff-code-insert").should(
      "contain",
      "true"
    );
  });
});
