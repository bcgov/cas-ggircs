import Card from "@button-inc/bcgov-theme/Card";
import Button from "@button-inc/bcgov-theme/Button";
import Grid from "@button-inc/bcgov-theme/Grid";
import Link from "next/link";

const SwrsDataAccessCard: React.FC = () => (
  <Grid.Row>
    <Grid.Col span={5}>
      <Card title="SWRS Reports">
        <p>
          Access reports and attachments from the Single Window Reporting System
        </p>
        <Link href="/ggircs/swrs-browser" passHref>
          <Button marginTop="2em">Browse SWRS files</Button>
        </Link>
        <div id="bottom-button">
          <Link href="/ggircs/xml-diff" passHref>
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
    </Grid.Col>
    <Grid.Col span={5}>
      <Card title="SWRS Fuels">
        <p>Manage fuel types and normalized fuel types in the SWRS database</p>
        <Link href="/ggircs/fuel-type-management" passHref>
          <Button marginTop="2em">Manage SWRS fuel types</Button>
        </Link>
        <div id="bottom-button">
          <Link href="/ggircs/carbon-tax-act-management?showAll=false" passHref>
            <Button marginTop="2em">
              Manage tax rates for carbon-taxed fuels
            </Button>
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
    </Grid.Col>
  </Grid.Row>
);

export default SwrsDataAccessCard;
