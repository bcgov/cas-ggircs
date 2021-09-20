import React, { useState, useEffect } from "react";
import {graphql, createFragmentContainer} from 'react-relay';
import {RenderDiff_query} from 'RenderDiff_query.graphql';
import { diffLines, formatLines } from "unidiff";
import { parseDiff, Diff, Hunk, tokenize } from "react-diff-view";
import "react-diff-view/style/index.css";
import LoadingSpinner from "components/LoadingSpinner";
import format from "xml-formatter";
import { NextRouter } from "next/router";

const EMPTY_HUNKS = [];

interface Props {
  query: RenderDiff_query;
  router: NextRouter;
};

export const RenderDiff: React.FunctionComponent<Props> = ({query, router}) => {
  const shouldRenderDiff = query.firstSideReport && query.secondSideReport && router.query.FirstSideRelayId && router.query.SecondSideRelayId;
  if (!shouldRenderDiff)
    return null;

  const [loaded, setLoaded] = useState(false);
  const oldText=format(query.firstSideReport.latestSwrsReport.ecccXmlFileByEcccXmlFileId.xmlFile);
  const newText=format(query.secondSideReport.latestSwrsReport.ecccXmlFileByEcccXmlFileId.xmlFile);
  const collapse=false;



  // UseEffect & setState to determine if this slow component is loading. Renders the loading spinner while loading.
  useEffect(() => {
    setLoaded(true);
  }, []);

  if (!loaded) return <LoadingSpinner />;

  // context is the max number of lines to show around a change. When collapsed, we set it to 1. Otherwise 10000 to ensure we get the whole document.
  const diffText = formatLines(diffLines(oldText, newText), {
    context: collapse ? 1 : 10000,
  });
  const [{ type, hunks }] = parseDiff(diffText, { nearbySequences: "zip" });

  const getTokens = (hunks) => {
    if (!hunks) {
      return undefined;
    }

    const options = {
      highlight: false,
      language: "markup",
    };

    try {
      return tokenize(hunks, options);
    } catch (ex) {
      return undefined;
    }
  };

  const tokens = getTokens(hunks);

  const renderToken = (token, defaultRender, i) => {
    const pttrn = /^\s*</;
    const str = token.value;
    const leadingWhiteSpace = str.match(pttrn)?.[0].length - 1;
    let tagColor = "black";

    const tagHighlighterArray = [
      "#0000e0",
      "#aa0000",
      "#ff4500",
      "#360036",
      "#ff00ff",
      "#8d6708",
      "#1978d4",
    ];
    if (Number.isInteger(leadingWhiteSpace))
      leadingWhiteSpace < 25
        ? (tagColor = tagHighlighterArray[leadingWhiteSpace / 4])
        : "#ff0000";

    if (token.type === "text") {
      return (
        <span key={i} style={{ color: tagColor }}>
          {token.value}
        </span>
      );
    }

    // For other types, use the default render function
    return defaultRender(token, i);
  };

  return (
    <div style={{ height: "40em", overflow: "scroll" }}>
      <Diff
        viewType="split"
        diffType={type}
        hunks={hunks || EMPTY_HUNKS}
        tokens={tokens}
        renderToken={renderToken}
      >
        {(hunks) => hunks.map((hunk) => <Hunk key={hunk.content} hunk={hunk} />)}
      </Diff>
    </div>
  );
};

export default createFragmentContainer(RenderDiff, {
  query: graphql`
    fragment RenderDiff_query on Query
    @argumentDefinitions(
      FirstSideRelayId: {type: "ID!"}
      SecondSideRelayId: {type: "ID!"}
    ) {
    firstSideReport: report(id: $FirstSideRelayId) {
      swrsReportId
      latestSwrsReport {
        submissionDate
        ecccXmlFileByEcccXmlFileId {
          xmlFileName
          xmlFile
          ecccZipFileByZipFileId {
            zipFileName
          }
        }
      }
    }
    secondSideReport: report(
      id: $SecondSideRelayId
    ) {
        swrsReportId
        latestSwrsReport {
          submissionDate
          ecccXmlFileByEcccXmlFileId {
            xmlFileName
            xmlFile
            ecccZipFileByZipFileId {
              zipFileName
            }
          }
        }
      }
    }
  `
});
