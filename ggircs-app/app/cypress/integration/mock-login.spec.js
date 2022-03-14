describe("When logged in as an GGIRCS User", () => {
  it("The index page redirects to the dashboard", () => {
    cy.mockLogin("GGIRCS User");
    cy.visit("/");
    cy.get(".page-title").contains(
      "Greenhouse Gas Industrial Reporting and Control System"
    );
  });
});

describe("When logged in as an unauthorized user", () => {
  it("The index page redirects to the unauthorized idir page", () => {
    cy.mockLogin("Pending GGIRCS User");
    cy.visit("/");
    cy.get("#page-content").contains("This application has restricted access");
  });
});
