import Grid from "@button-inc/bcgov-theme/Grid";
import { useFragment, graphql } from "react-relay";
import { DefaultLayout_session$key } from "DefaultLayout_session.graphql";
import getConfig from "next/config";
import Header from "components/Layout/Header";
import Footer from "components/Layout/Footer";
import Help from "components/Layout/Help";
import SiteNoticeBanner from "components/Layout/SiteNoticeBanner";

const runtimeConfig = getConfig()?.publicRuntimeConfig ?? {};

interface Props {
  title?: string | JSX.Element;
  titleControls?: JSX.Element;
  session: DefaultLayout_session$key;
  width?: "narrow" | "wide";
  help?: {
    title: string;
    helpMessage: string;
  };
}

export const DefaultLayoutComponent: React.FunctionComponent<Props> = ({
  children,
  title = "Greenhouse Gas Industrial Reporting and Control System",
  titleControls = null,
  help = null,
  session,
  width = "narrow",
}) => {
  useFragment(
    graphql`
      fragment DefaultLayout_session on JwtToken {
        ggircsUserBySub {
          __typename
        }
      }
    `,
    session
  );
  return (
    <div className="page-wrap">
      <Header isLoggedIn={Boolean(session)}>
        {runtimeConfig.SITEWIDE_NOTICE && (
          <SiteNoticeBanner content={runtimeConfig.SITEWIDE_NOTICE} />
        )}
      </Header>
      <main>
        {title ? (
          <div className="page-title">
            <Grid cols={12}>
              <Grid.Row justify="center">
                <Grid.Col span={6}>
                  <h1>{title}</h1>
                  {help && (
                    <Help title={help.title} helpMessage={help.helpMessage} />
                  )}
                </Grid.Col>
                <Grid.Col>{titleControls}</Grid.Col>
              </Grid.Row>
            </Grid>
          </div>
        ) : null}

        <div id="page-content">
          <Grid cols={12} className={width}>
            <Grid.Row justify="center" gutter={[0, 50]}>
              <Grid.Col span={7}>{children}</Grid.Col>
            </Grid.Row>
          </Grid>
        </div>
      </main>
      <Footer />
      <style jsx>
        {`
          .page-wrap {
            min-height: 100%;
            display: flex;
            flex-direction: column;
          }

          main {
            flex-grow: 1;
          }
        `}
      </style>
      <style jsx global>
        {`
          html,
          body,
          #__next {
            height: 100%;
          }
          a {
            color: #0053b3;
          }
          .btn-link {
            color: #0053b3;
          }
          .content {
            padding-top: 50px;
            flex: 1 0 auto;
          }
          .footer {
            flex-shrink: 0;
          }
          h1 {
            font-size: 30px;
            display: inline-block;
          }
          .page-title {
            background: #f5f5f5;
            border-bottom: 1px solid #ccc;
            padding: 40px 0 20px;
          }
          .page-title h1 {
            font-size: 25px;
            font-weight: 400;
          }
          h3 {
            margin-bottom: 20px;
            font-weight: 500;
          }
          .blue {
            color: #036;
          }
          p {
            line-height: 25px;
          }
          button.full-width {
            width: 100%;
          }
          .btn-primary {
            background: #036;
            border-color: #036;
          }
          .with-shadow {
            box-shadow: 1px 8px 13px -5px #00336694;
          }
          .accordion .card-body {
            font-size: 15px;
          }
          .container.wide {
            max-width: 1600px;
          }

          /* BS overrides for purposes of accessibility: */

          .btn-outline-primary {
            color: #0053b3;
            border-color: #0053b3;
          }
          .badge-success,
          .btn-success {
            background-color: #24883e;
          }
        `}
      </style>
    </div>
  );
};

export default DefaultLayoutComponent;
