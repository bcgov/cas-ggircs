import React from "react";
import { Row, Col } from "react-bootstrap";
import DefaultLayout from "components/Layout/DefaultLayout";
import Link from "next/link";
import getConfig from "next/config";

export default () => {
  const supportEmail = getConfig()?.publicRuntimeConfig.SUPPORT_EMAIL;
  const mailtoLink = `mailto:${supportEmail}?subject=Support Request`;
  return (
    <>
      <DefaultLayout session={null}>
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
      </DefaultLayout>
      <style jsx>{`
        p {
          margin: 2em 0;
        }
      `}</style>
    </>
  );
};
