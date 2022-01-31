const path = require("path");
const dotenv = require("dotenv");
const Dotenv = require("dotenv-webpack")
dotenv.config();

module.exports = {
  cssModules: true,
  webpack: (config) => {
    const configWithPlugins = { ...config };
    configWithPlugins.plugins = config.plugins || [];

    configWithPlugins.plugins = [
      ...configWithPlugins.plugins,
      // Read the .env file
      new Dotenv({
        path: path.join(__dirname, ".env"),
        systemvars: true,
      }),
    ];

    return configWithPlugins;
  },
  publicRuntimeConfig: {
    SUPPORT_EMAIL: process.env.SUPPORT_EMAIL,
  },
};
