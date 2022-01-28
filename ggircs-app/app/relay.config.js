module.exports = {
  src: "./",
  language: "typescript",
  artifactDirectory: "./__generated__",
  customScalars: {
    Datetime: "string",
    JSON: "any",
    BigFloat: "string",
  },
  exclude: [
    "**/.next/**",
    "**/node_modules/**",
    "**/__generated__/**",
    "**/server/**",
  ],
  schema: "./schema/schema.graphql",
  noFutureProofEnums: true,
};
