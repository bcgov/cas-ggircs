import { withRelay, RelayProps } from "relay-nextjs";
import { graphql, usePreloadedQuery } from "react-relay/hooks";
import { Row, Col } from "react-bootstrap";
import withRelayOptions from "lib/relay/withRelayOptions";
import { xmlDiffQuery } from "__generated__/xmlDiffQuery.graphql";
import DefaultLayout from "components/Layout/DefaultLayout";
import ReportSelector from "components/XmlDiff/ReportSelector";
import DiffDetailsContainer from "components/XmlDiff/DiffDetailsContainer";
import RenderDiff from "components/XmlDiff/RenderDiff";
import DiffControls from "components/XmlDiff/DiffControls";
import { useRouter, NextRouter } from "next/router";
import type { NextPageContext } from "next";
import { useState } from "react";

export const XmlDiffQuery = graphql`
  query xmlDiffQuery($FirstSideRelayId: ID!, $SecondSideRelayId: ID!) {
    query {
      session {
        ...DefaultLayout_session
      }
      allReports {
        edges {
          node {
            id
            swrsReportId
          }
        }
      }
      ...DiffDetailsContainer_query
        @arguments(
          FirstSideRelayId: $FirstSideRelayId
          SecondSideRelayId: $SecondSideRelayId
        )
      ...RenderDiff_query
        @arguments(
          FirstSideRelayId: $FirstSideRelayId
          SecondSideRelayId: $SecondSideRelayId
        )
    }
  }
`;

export function XmlDiff({ preloadedQuery }: RelayProps<{}, xmlDiffQuery>) {
  const { query } = usePreloadedQuery(XmlDiffQuery, preloadedQuery);

  const [firstSelectorEditing, setFirstSelectorEditing] = useState(false);
  const [secondSelectorEditing, setSecondSelectorEditing] = useState(false);

  const router = useRouter();

  return (
    <DefaultLayout
      session={query.session}
      title="ECCC SWRS XML Diff"
      width="wide"
    >
      <Row>
        <Col md={{ span: 6, order: router.query.reversed ? 2 : 1 }}>
          <ReportSelector
            diffSide={router.query.reversed ? "Second" : "First"}
            allReports={query.allReports.edges}
            onUserTyping={(isUserTyping) =>
              setFirstSelectorEditing(isUserTyping)
            }
            disabled={secondSelectorEditing}
          />
        </Col>
        <Col md={{ span: 6, order: router.query.reversed ? 1 : 2 }}>
          <ReportSelector
            diffSide={router.query.reversed ? "First" : "Second"}
            allReports={query.allReports.edges}
            onUserTyping={(isUserTyping) =>
              setSecondSelectorEditing(isUserTyping)
            }
            disabled={firstSelectorEditing}
          />
        </Col>
      </Row>
      <DiffControls />

      <DiffDetailsContainer query={query} />

      <RenderDiff query={query} />
    </DefaultLayout>
  );
}

const withRelayOptionsOverride = {
  ...withRelayOptions,
  variablesFromContext: (ctx: NextPageContext | NextRouter) => ({
    FirstSideRelayId: "",
    SecondSideRelayId: "",
    ...ctx.query,
  }),
};

export default withRelay(XmlDiff, XmlDiffQuery, withRelayOptionsOverride);
