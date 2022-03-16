before(() => {
  cy.sqlFixture("fuel-management-setup");
});

after(() => {
  cy.sqlFixture("fuel-management-teardown");
});

describe("When using the fuel type management tool", () => {
  beforeEach(() => {
    cy.mockLogin("GGIRCS User");
    cy.visit("/ggircs/fuel-type-management");
  });
  afterEach(() => {
    cy.logout();
  });
  it("can map fuel types to an existing normalized fuel type", () => {
    cy.get(".page-title").contains("Fuel Type Management");
    // An unmapped fuel exists
    cy.get("tbody.jsx-1511681825 > tr > :nth-child(1)").contains("Not Mapped");
    cy.get("#normalized-fuel-select-0")
      .select("Acetylene (Sm^3)")
      .then(() => {
        cy.contains("Apply").click();
        cy.get(".list-group > :nth-child(1)").click();
        // The unmapped fuel was mapped when 'Apply' was clicked
        cy.get("tbody.jsx-2096797517 > :nth-child(3) > :nth-child(1)").contains(
          "Not Mapped"
        );
        cy.get("tbody.jsx-2096797517 > :nth-child(3) > :nth-child(2)").click();
        // The mapped fuel was ummapped when 'Remove' was clicked
        cy.get("tbody.jsx-1511681825 > tr > :nth-child(1)").contains(
          "Not Mapped"
        );
      });
  });
});
