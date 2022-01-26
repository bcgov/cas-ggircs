import React from "react";
import Card from "@button-inc/bcgov-theme/Card";
import Grid from "@button-inc/bcgov-theme/Grid";

interface Props {
  unMappedFuels: any[]
}

export const UnmappedFuelTypes: React.FunctionComponent<Props> = ({
  unMappedFuels
}) => {

  return (
    <>
      <Card title="Normalize unmapped SWRS fuel types">
        {unMappedFuels.map((fuel) => (
          <Grid.Row>
          <Grid.Col span={6}>
            <p>
              {fuel}
            </p>
          </Grid.Col>
          <Grid.Col span={4}>
            DROPDOWN SELECT
          </Grid.Col>
        </Grid.Row>
        ))}
      </Card>
    </>
  );
};

export default UnmappedFuelTypes;
