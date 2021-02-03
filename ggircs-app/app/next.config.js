const dotenv = require("dotenv");
dotenv.config();

module.exports = {
  cssModules: true,
  webpack: (config) => {
    config.plugins = config.plugins || [];

    config.plugins = [...config.plugins];

    return config;
  },
  publicRuntimeConfig: {
    SUPPORT_EMAIL: process.env.SUPPORT_EMAIL,
  },
};
