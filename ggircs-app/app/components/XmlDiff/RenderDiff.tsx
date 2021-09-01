import React from "react";
import { diffLines, formatLines } from "unidiff";
import { parseDiff, Diff, Hunk } from "react-diff-view";
import "react-diff-view/style/index.css";

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
  // context is the max number of lines to show around a change. When collapsed, we set it to 1. Otherwise 10000 to ensure we get the whole document.
  const diffText = formatLines(diffLines(oldText, newText), {
    context: collapse ? 1 : 10000,
  });
  const [{ type, hunks }] = parseDiff(diffText, { nearbySequences: "zip" });

  return (
    <Diff viewType="split" diffType={type} hunks={hunks || EMPTY_HUNKS}>
      {(hunks) => hunks.map((hunk) => <Hunk key={hunk.content} hunk={hunk} />)}
    </Diff>
  );
};

export default RenderDiff;
