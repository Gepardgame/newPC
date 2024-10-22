#!/bin/bash

function git_branch() {
  local b="$(git branch 2> /dev/null)"
  if [ -n "$b" ]; then
	echo -e "${h_aqua} ($(echo "$b"| awk '/\*/{print $2}'))${normal} ";
  fi
}

function GetMergeAndRebaseConflict() {
  local g="$(git rev-parse --git-dir 2>/dev/null)"
  local r
  local b
  if [ -n "$g" ]; then
    if [ -d "$g/rebase-apply" ]
    then
      if test -f "$g/rebase-apply/rebasing"
      then
        r="|REBASE"
	printf ${d_rot}${r}
      elif test -f "$g/rebase-apply/applying"
      then
        r="|AM"
	printf ${d_rot}${r}${normal}
      else
        r="|AM/REBASE"
	printf ${d_rot}${r}${normal}
      fi
      b="$(git symbolic-ref HEAD 2>/dev/null)"
    elif [ -f "$g/rebase-merge/interactive" ]
    then
      r="|REBASE-i"
      b="$(cat "$g/rebase-merge/head-name")"
      printf ${d_rot}${r}${normal}
    elif [ -d "$g/rebase-merge" ]
    then
      r="|REBASE-m"
      b="$(cat "$g/rebase-merge/head-name")"
      printf ${d_rot}${r}${normal}
    elif [ -f "$g/MERGE_HEAD" ]
    then
      r="|MERGING"
      b="$(git symbolic-ref HEAD 2>/dev/null)"
      printf ${d_rot}${r}${normal}
    fi
  fi
}
