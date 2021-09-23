import React, { useState } from "react";
import { Row, Col } from "react-bootstrap";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faExchangeAlt } from "@fortawesome/free-solid-svg-icons";
import Button from "@button-inc/bcgov-theme/Button";
import { NextRouter } from "next/router";
// Use dynamic import for BootstrapSwitchButton (workaround for SSR bug where window is not defined)
import dynamic from "next/dynamic";
const BootstrapSwitchButton = dynamic(
  () => import("bootstrap-switch-button-react"),
  {
    loading: () => <p>loading</p>,
    ssr: false, // This line is important. It's what prevents server-side render
  }
);

interface Props {
  router: NextRouter;
}

export const DiffDetails: React.FunctionComponent<Props> = ({ router }) => {
  const [collapsed, setCollapsed] = useState(false);
  const [reversed, setReversed] = useState(false);

  const handleRouter = (control: string, value: boolean) => {
    const query = {
      ...router.query,
      [control]: value,
    };
    if (!value) delete query[control];
    const url = {
      pathname: router.pathname,
      query,
    };
    router.push(url, url, { shallow: true });
  };

  const handleCollapse = () => {
    setCollapsed(!collapsed);
    handleRouter("collapsed", !collapsed);
  };

  const handleReverse = () => {
    setReversed(!reversed);
    handleRouter("reversed", !reversed);
  };

  return (
    <Row style={{ marginTop: "2em", marginBottom: "2em" }}>
      <Col md={{ span: 3, offset: 6 }}>
        <Row style={{ float: "right" }}>
          <p style={{ marginTop: "auto", marginBottom: "auto" }}>
            <strong>Summarize Changes:&nbsp;</strong>
          </p>
          <BootstrapSwitchButton
            checked={collapsed}
            onlabel="On"
            offlabel="Off"
            onChange={handleCollapse}
          />
        </Row>
      </Col>
      <Col md={{ span: 3 }}>
        <Button size="small" onClick={handleReverse}>
          <FontAwesomeIcon icon={faExchangeAlt} />
          &nbsp;Swap left/right
        </Button>
      </Col>
    </Row>
  );
};
export default DiffDetails;
