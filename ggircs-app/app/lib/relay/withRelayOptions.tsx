import { getClientEnvironment } from "./client";
import { getUserGroupLandingRoute } from "lib/user-groups";
import { isRouteAuthorized } from "lib/authorization";
import type { NextPageContext } from "next";
import type { Request } from "express";
import { WiredOptions } from "relay-nextjs/wired/component";
import { NextRouter } from "next/router";
import LoadingFallback from "components/Layout/LoadingFallback";

const withRelayOptions: WiredOptions<any> = {
  fallback: <LoadingFallback />,
  createClientEnvironment: () => getClientEnvironment()!,
  createServerEnvironment: async (ctx: NextPageContext) => {
    const { createServerEnvironment } = await import("./server");
    return createServerEnvironment({ cookieHeader: ctx.req.headers.cookie });
  },
  serverSideProps: async (ctx: NextPageContext) => {
    // Server-side redirection of the user to their landing route, if they are logged in
    const { getUserGroups } = await import(
      "server/helpers/userGroupAuthentication"
    );

    const groups = getUserGroups(ctx.req as Request);

    const isAuthorized = isRouteAuthorized(ctx.req.url, groups);

    if (isAuthorized) return {};

    if (groups.length === 0 || groups[0] === "Guest") {
      return {
        redirect: {
          destination: `/login-redirect?redirectTo=${encodeURIComponent(
            ctx.req.url
          )}`,
        },
      };
    }
    const landingRoute = getUserGroupLandingRoute(groups);

    return {
      redirect: { destination: landingRoute, permanent: false },
    };
  },
  variablesFromContext: (ctx: NextPageContext | NextRouter) => {
    return {
      ...ctx.query,
    };
  },
};

export default withRelayOptions;
