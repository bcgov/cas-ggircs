import { Row, Col } from "react-bootstrap";
import Link from "next/link";
import Header from "components/Layout/Header";
import getConfig from "next/config";
import SiteNoticeBanner from "components/Layout/SiteNoticeBanner";

const runtimeConfig = getConfig()?.publicRuntimeConfig ?? {};

function NotFoundPage() {
  return (
    <>
      <Header isLoggedIn={false}>
        {runtimeConfig.SITEWIDE_NOTICE && (
          <SiteNoticeBanner content={runtimeConfig.SITEWIDE_NOTICE} />
        )}
      </Header>
      <Row className="justify-content-center" style={{ paddingTop: "3em" }}>
        <Col md={{ span: 6 }} style={{ textAlign: "center" }}>
          <h1>Page not found</h1>
          <p>Sorry, we couldn&apos;t find the page you were looking for.</p>
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

export default NotFoundPage;
