import React, { useState, useEffect } from "react";
import { useRouter } from "next/router";
import { fetchQuery, graphql } from "relay-runtime";
import LoadingSpinner from "components/LoadingSpinner";
import RelayModernEnvironment from "relay-runtime/lib/store/RelayModernEnvironment";
import { PageComponent } from "next-env";
import { getUserGroupLandingRoute } from "lib/user-groups";
import {
  PageRedirectHandlerQuery,
  PageRedirectHandlerQueryResponse,
} from "PageRedirectHandlerQuery.graphql";
import createGgircsUserFromSessionMutation from "mutations/ggircsUser/createGgircsUserFromSessionMutation";

interface Props {
  environment: RelayModernEnvironment;
  pageComponent: PageComponent;
}

const sessionQuery = graphql`
  query PageRedirectHandlerQuery {
    session {
      userGroups
      ggircsUserBySub {
        __typename
      }
    }
  }
`;

const PageRedirectHandler: React.FunctionComponent<Props> = ({
  children,
  environment,
  pageComponent,
}) => {
  const [shouldRender, setShouldRender] = useState(false);

  const router = useRouter();
  useEffect(() => {
    const checkSessionAndGroups = async () => {
      const { isAccessProtected, allowedGroups = [] } = pageComponent;
      const response = (await fetchQuery<PageRedirectHandlerQuery>(
        environment,
        sessionQuery,
        {}
      )) as unknown as PageRedirectHandlerQueryResponse;

      if (isAccessProtected && !response?.session) {
        router.push({
          pathname: "/login-redirect",
          query: {
            redirectTo: router.asPath,
          },
        });
        return;
      }

      const userGroups = response?.session?.userGroups || ["Guest"];

      const canAccess =
        allowedGroups.length === 0 ||
        userGroups.some((g) => allowedGroups.includes(g));

      // Redirect users attempting to access a page that their group doesn't allow
      // to their landing route. This needs to happen before redirecting to the registration
      // to ensure that a pending analyst doesn't get redirect to the registration page
      if (!canAccess) {
        router.push({
          pathname: getUserGroupLandingRoute(userGroups),
        });
        return;
      }

      if (
        isAccessProtected &&
        !response?.session?.ggircsUserBySub &&
        router.route !== "/request-access-notice"
      ) {
        await createGgircsUserFromSessionMutation(environment, { input: {} });
      }

      setShouldRender(true);
    };

    checkSessionAndGroups();
  }, [pageComponent, router, environment]);

  useEffect(() => {
    let timeoutId;

    const checkSessionIdle = async () => {
      const { isAccessProtected } = pageComponent;
      if (isAccessProtected && shouldRender) {
        const response = await fetch("/session-idle-remaining-time");
        if (response.ok) {
          const timeout = Number(await response.json());
          if (timeout) {
            timeoutId = setTimeout(checkSessionIdle, (timeout + 1) * 1000);
          } else {
            router.push({
              pathname: "/login-redirect",
              query: {
                redirectTo: router.asPath,
                sessionIdled: true,
              },
            });
          }
        }
      }
    };

    checkSessionIdle();

    // Return cleanup function
    return () => {
      clearTimeout(timeoutId);
    };
  }, [router, pageComponent]);

  // eslint-disable-next-line react/jsx-no-useless-fragment
  if (shouldRender) return <>{children}</>;

  return (
    <div>
      <LoadingSpinner />
      <style jsx>{`
        div {
          height: 100vh;
        }
      `}</style>
    </div>
  );
};

export default PageRedirectHandler;
