import getConfig from "next/config";
import Header from "components/Layout/Header";
import Footer from "components/Layout/Footer";
import SiteNoticeBanner from "components/Layout/SiteNoticeBanner";

const runtimeConfig = getConfig()?.publicRuntimeConfig ?? {};

const StaticLayout: React.FC = ({ children }) => {
  return (
    <div id="page-wrap">
      <Header>
        {runtimeConfig.SITEWIDE_NOTICE && (
          <SiteNoticeBanner content={runtimeConfig.SITEWIDE_NOTICE} />
        )}
      </Header>
      <main>{children}</main>
      <Footer />
      <style jsx>
        {`
          #page-wrap {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background-color: #fafafc;
          }
          main {
            padding: 30px 40px;
            flex-grow: 1;
            margin: auto;
          }
        `}
      </style>
    </div>
  );
};

export default StaticLayout;
