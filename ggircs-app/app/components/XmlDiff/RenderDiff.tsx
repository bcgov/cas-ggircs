import { useState, useEffect, useMemo } from "react";
import { useFragment, graphql } from "react-relay";
import { diffLines, formatLines } from "unidiff";
import { parseDiff, Diff, Hunk, tokenize } from "react-diff-view";
import "react-diff-view/style/index.css";
import format from "xml-formatter";
import { useRouter } from "next/router";
import LoadingSpinner from "components/LoadingSpinner";
import { RenderDiff_query$key } from "__generated__/RenderDiff_query.graphql";

const EMPTY_HUNKS = [];

interface Props {
  query: RenderDiff_query$key;
}

const RenderDiff: React.FC<Props> = ({
  query
}) => {

  const router = useRouter();
  const {
    firstSideReport,
    secondSideReport
  } = useFragment(
    graphql`
      fragment RenderDiff_query on Query
        @argumentDefinitions(FirstSideRelayId: {type: "ID!"}, SecondSideRelayId: {type: "ID!"}) {
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
        secondSideReport: report(id: $SecondSideRelayId) {
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
    `,
    query
  );

  const shouldRenderDiff =
    firstSideReport &&
    secondSideReport &&
    router.query.FirstSideRelayId &&
    router.query.SecondSideRelayId;
  if (!shouldRenderDiff) return null;

  const [isLoading, setIsLoading] = useState(true);
  const [diffText, setDiffText] = useState(null);

  const oldText = format(
    firstSideReport.latestSwrsReport.ecccXmlFileByEcccXmlFileId.xmlFile
  );
  const newText = format(
    secondSideReport.latestSwrsReport.ecccXmlFileByEcccXmlFileId.xmlFile
  );

  useEffect(() => {
    setIsLoading(false);
  });

  useMemo(() => {
    setIsLoading(true);
    if (router.query.reversed)
      setDiffText(
        formatLines(diffLines(newText, oldText), {
          // context is the max number of lines to show around a change. When collapsed, we set it to 1. Otherwise 10000 to ensure we get the whole document.
          context: router.query.collapsed ? 1 : 10000,
        })
      );
    else
      setDiffText(
        formatLines(diffLines(oldText, newText), {
          context: router.query.collapsed ? 1 : 10000,
        })
      );
  }, [router.query]);

  if (isLoading) return <LoadingSpinner />;

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
        {(hunks) =>
          hunks.map((hunk) => <Hunk key={hunk.content} hunk={hunk} />)
        }
      </Diff>
    </div>
  );
};

export default RenderDiff;
