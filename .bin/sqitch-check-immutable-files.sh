#!/usr/bin/env bash
# We consider any sqitch change prior to a tag to be immutable, as it may already be released to production, and should not be reverted
# This script checks whether those changes were modified in the current dir since the base branch and returns an error if that is the case
# usage: sqitch-immutable-files.sh schema_dir base_branch

set -xeuo pipefail
# gets the list of modified files via git diff, and removes the schema/deploy prefix, and the .sql suffix to match the sqitch plan change name
modified_changes=$(git diff --name-only "${2}" -- "${1}"/deploy | sed -e "s/deploy\///g; s/@.*//g; s/\.sql$//g")

# finds the last tag in the sqitch plan in the base branch
git show "${2}":"${1}"/sqitch.plan | tac > sqitch.plan.base.tac
last_tag_on_base_branch=$(sed -n '/^@/{p;q;}' sqitch.plan.base.tac | cut -d' ' -f1 )

if [ -z "$last_tag_on_base_branch" ]; then
  echo "No sqitch tag on base branch, all changes are mutable."
  exit 0
fi

# reads the sqitch.plan from the end and stops at the last tag that was on the base branch
tac "${1}"/sqitch.plan > sqitch.plan.tac
changes_after_last_tag=$(sed "/^$last_tag_on_base_branch/Q" sqitch.plan.tac | cut -d' ' -f1)

# comm compares two ordered files and returns three columns "-23" suppresses colums 2 and 3,
# so it only returns the first column (the lines unique to file 1)
immutable_modified_files=$(comm -23 <(echo "$modified_changes" | sort -u) <(echo "$changes_after_last_tag" | sort -u))
if [ -n "$immutable_modified_files" ]; then
  echo "The following sqitch changes are immutable as they are part of a tagged release. Please add incremental changes instead."
  echo "$immutable_modified_files"
  exit 1
fi
