#!/bin/bash

default_tag=$(git describe)
tag=${1:-$default_tag}

if [ -z "$1" ]; then
  echo "Defaulted to version $tag"
fi

# Quit early if the release doesn't exist
gh release view "$tag" >/dev/null || exit 1

gh release delete-asset -y "$tag" checksums.windows.txt
gh release delete-asset -y "$tag" gibo-go_Windows_x86_64.zip
gh release delete-asset -y "$tag" gibo-go_Windows_i386.zip
gh release delete-asset -y "$tag" gibo-go_Windows_arm64.zip
