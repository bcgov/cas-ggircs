import React, { useState, useEffect } from "react";
import { diffLines, formatLines } from "unidiff";
import { parseDiff, Diff, Hunk, tokenize } from "react-diff-view";
import "react-diff-view/style/index.css";
import LoadingSpinner from "components/LoadingSpinner";

const EMPTY_HUNKS = [];

interface Props {
  oldText: string;
  newText: string;
  collapse: boolean;
}

export const RenderDiff: React.FunctionComponent<Props> = ({
  oldText,
  newText,
  collapse,
}) => {
  const [loaded, setLoaded] = useState(false);

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
    if (Number.isInteger(leadingWhiteSpace))
      switch (leadingWhiteSpace) {
        case 0:
          tagColor = "#0000e0";
          break;
        case 4:
          tagColor = "#aa0000";
          break;
        case 8:
          tagColor = "#ff4500";
          break;
        case 12:
          tagColor = "#360036";
          break;
        case 16:
          tagColor = "#ff00ff";
          break;
        case 20:
          tagColor = "#8d6708";
          break;
        case 24:
          tagColor = "#1978d4";
          break;
        default:
          tagColor = "#ff0000";
      }
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
    <Diff
      viewType="split"
      diffType={type}
      hunks={hunks || EMPTY_HUNKS}
      tokens={tokens}
      renderToken={renderToken}
    >
      {(hunks) => hunks.map((hunk) => <Hunk key={hunk.content} hunk={hunk} />)}
    </Diff>
  );
};

export default RenderDiff;
