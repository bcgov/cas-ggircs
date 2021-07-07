import React from "react";
import Card from "@button-inc/bcgov-theme/Card";
import Button from "@button-inc/bcgov-theme/Button";
import Link from "next/link";

const SwrsDataAccessCard: React.FunctionComponent = () => (
  <Card title="SWRS">
    Access reports and attachments from the Single Window Reporting System
    <br />
    <br />
    <Link href="/swrs-browser" passHref>
      <Button>Browse SWRS files</Button>
    </Link>
  </Card>
);

export default SwrsDataAccessCard;
