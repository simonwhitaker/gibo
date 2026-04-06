#!/bin/bash

set -euo pipefail

mode="${1:-sync}"

go_version=$(awk '/^go / { print $2; exit }' go.mod)

if [ -z "$go_version" ]; then
  echo "Unable to determine Go version from go.mod" >&2
  exit 1
fi

go_image_version=$(echo "$go_version" | awk -F. '{ print $1 "." $2 }')
expected_image="golang:${go_image_version}-alpine"
expected_from="FROM ${expected_image} AS build"
current_from=$(awk '/^FROM golang:[^ ]+ AS build$/ { print; exit }' Dockerfile)

if [ -z "$current_from" ]; then
  echo "Unable to determine Go build image from Dockerfile" >&2
  exit 1
fi

if [ "$mode" = "--check" ]; then
  if [ "$current_from" != "$expected_from" ]; then
    echo "Dockerfile Go image is out of sync with go.mod" >&2
    echo "Expected: ${expected_from}" >&2
    echo "Found:    ${current_from}" >&2
    exit 1
  fi

  exit 0
fi

if [ "$mode" != "sync" ]; then
  echo "Usage: $0 [sync|--check]" >&2
  exit 1
fi

if [ "$current_from" = "$expected_from" ]; then
  exit 0
fi

tmp_file=$(mktemp)

awk -v expected_from="$expected_from" '
  BEGIN { updated = 0 }
  /^FROM golang:[^ ]+ AS build$/ && !updated {
    print expected_from
    updated = 1
    next
  }
  { print }
' Dockerfile > "$tmp_file"

mv "$tmp_file" Dockerfile
