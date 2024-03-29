import { Row, Col } from "react-bootstrap";
import Header from "components/Layout/Header";
import Link from "next/link";
import getConfig from "next/config";
import SiteNoticeBanner from "components/Layout/SiteNoticeBanner";

const runtimeConfig = getConfig()?.publicRuntimeConfig ?? {};

function ForbiddenPage() {
  const supportEmail = getConfig()?.publicRuntimeConfig?.SUPPORT_EMAIL;
  const mailtoLink = `mailto:${supportEmail}?subject=Support Request`;
  return (
    <>
      <Header isLoggedIn={false}>
        {runtimeConfig.SITEWIDE_NOTICE && (
          <SiteNoticeBanner content={runtimeConfig.SITEWIDE_NOTICE} />
        )}
      </Header>
      <Row className="justify-content-center" style={{ paddingTop: "3em" }}>
        <Col md={{ span: 6 }} style={{ textAlign: "center" }}>
          <h1>Something went wrong</h1>
          <p>
            Please consider reporting this error to our development team at{" "}
            <a href={mailtoLink}>{supportEmail}</a>.
          </p>
          <p>
            <Link href="/">
              <a className="full-width btn btn-primary">Return Home</a>
            </Link>
          </p>
        </Col>
      </Row>
      <style jsx>{`
        p {
          margin: 2em 0;
        }
      `}</style>
    </>
  );
}

export default ForbiddenPage;
