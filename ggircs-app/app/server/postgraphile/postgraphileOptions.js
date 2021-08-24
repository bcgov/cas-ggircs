const { makePluginHook } = require("postgraphile");
const PgManyToManyPlugin = require("@graphile-contrib/pg-many-to-many");
const PostgraphileLogConsola = require("postgraphile-log-consola");
const SmartTagsPlugin = require("postgraphile/plugins").TagsFilePlugin;

const postgraphileOptions = () => {
  // Use consola for logging instead of default logger
  const pluginHook = makePluginHook([PostgraphileLogConsola]);

  let options = {
    pluginHook,
    appendPlugins: [PgManyToManyPlugin, SmartTagsPlugin],
    classicIds: true,
    enableQueryBatching: true,
    dynamicJson: true,
  };

  if (process.env.NODE_ENV === "production") {
    options = {
      ...options,
      retryOnInitFail: true,
      extendedErrors: ["errcode"],
    };
  } else {
    options = {
      ...options,
      graphiql: true,
      enhanceGraphiql: true,
      allowExplain: true,
      extendedErrors: ["hint", "detail", "errcode"],
      showErrorStack: "json",
    };
  }

  return options;
};

module.exports = postgraphileOptions;
