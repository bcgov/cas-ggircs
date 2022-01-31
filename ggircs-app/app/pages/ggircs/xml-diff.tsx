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

const XmlDiffQuery = graphql`
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


function XmlDiff({ preloadedQuery }: RelayProps<{}, xmlDiffQuery>) {
  const { query } = usePreloadedQuery(XmlDiffQuery, preloadedQuery);
  return (
    <DefaultLayout session={query.session} title="ECCC SWRS XML Diff" width="wide">
      <Row>
        <Col
          md={{ span: 6, order: this.props.router.query.reversed ? 2 : 1 }}
        >
          <ReportSelector
            diffSide={this.props.router.query.reversed ? "Second" : "First"}
            allReports={query.allReports.edges}
            router={this.props.router}
          />
        </Col>
        <Col
          md={{ span: 6, order: this.props.router.query.reversed ? 1 : 2 }}
        >
          <ReportSelector
            diffSide={this.props.router.query.reversed ? "First" : "Second"}
            allReports={query.allReports.edges}
            router={this.props.router}
          />
        </Col>
      </Row>
      <DiffControls router={this.props.router} />

      <DiffDetailsContainer
        query={this.props.query}
        router={this.props.router}
      />

      <RenderDiff query={this.props.query} router={this.props.router} />
    </DefaultLayout>
  );
}

export default withRelay(XmlDiff, XmlDiffQuery, withRelayOptions);
