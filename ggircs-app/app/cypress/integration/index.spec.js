describe("When visiting the index page", () => {
  it("The index page renders the need login message when unauthenticated", () => {
    cy.visit("/");
    cy.get("#page-content").contains("You need to be logged in");
  });
});
