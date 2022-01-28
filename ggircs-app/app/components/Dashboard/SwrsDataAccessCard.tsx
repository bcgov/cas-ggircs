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
    <div id="bottom-button">
      <Link href="/xml-diff" passHref>
        <Button marginTop="2em">Compare SWRS report XML files</Button>
      </Link>
    </div>
    <style jsx>
      {`
        #bottom-button {
          margin-top: 2em;
        }
        p {
          margin-bottom: 1.5em;
        }
      `}
    </style>
  </Card>
);

export default SwrsDataAccessCard;
