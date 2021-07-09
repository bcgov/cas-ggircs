import React from "react";
import Card from "@button-inc/bcgov-theme/Card";
import Button from "@button-inc/bcgov-theme/Button";
import Link from "next/link";

const SwrsDataAccessCard: React.FunctionComponent = () => (
  <Card title="SWRS">
    <p>
      Access reports and attachments from the Single Window Reporting System
    </p>
    <Link href="/swrs-browser" passHref>
      <Button marginTop="2em">Browse SWRS files</Button>
    </Link>
    <style jsx>
      {`
        p {
          margin-bottom: 1.5em;
        }
      `}
    </style>
  </Card>
);

export default SwrsDataAccessCard;
