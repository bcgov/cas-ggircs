import React, { Component } from "react";
import { graphql } from "react-relay";
import { fuelTypeManagementQueryResponse } from "fuelTypeManagementQuery.graphql";
import { PageComponentProps } from "next-env";
import DefaultLayout from "components/Layout/DefaultLayout";
import { USER_GROUP } from "data/group-constants";
import NormalizedFuelType from "components/FuelManagement/NormalizedFuelType";
import UnmappedFuelTypes from "components/FuelManagement/UnmappedFuelTypes";

const ALLOWED_GROUPS = [...USER_GROUP];

interface Props extends PageComponentProps {
  query: fuelTypeManagementQueryResponse["query"];
}
export default class Index extends Component<Props> {
  static allowedGroups = ALLOWED_GROUPS;
  static isAccessProtected = true;
  static query = graphql`
    query fuelTypeManagementQuery($fuelCarbonTaxDetailId: ID!) {
      query {
        ...NormalizedFuelType_query
          @arguments(fuelCarbonTaxDetailId: $fuelCarbonTaxDetailId)
        ...UnmappedFuelTypes_query
        session {
          ...DefaultLayout_session
        }
      }
    }
  `;

  static async getInitialProps() {
    return {
      variables: {
        fuelCarbonTaxDetailId: "",
      },
    };
  }

  render() {
    const { query } = this.props;
    const { session } = query || {};

    return (
      <>
        <DefaultLayout
          session={session}
          title="Fuel Type Management"
          width="wide"
        >
          <div id="unmapped">
            <UnmappedFuelTypes
              query={query}
            />
          </div>
          <div>
            <NormalizedFuelType
              query={query}
            />
          </div>
        </DefaultLayout>
        <style jsx>
          {`
            #unmapped {
              margin-bottom: 2em;
            }
          `}
        </style>
      </>
    );
  }
}
