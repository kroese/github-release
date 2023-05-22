#!/bin/sh
set -eu

INPUT_TITLE="$(echo "$INPUT_TITLE" | tr -d ' ')"

if [ -z "${INPUT_TAG}" ]; then
  INPUT_TAG="$(date +%Y%m%d%H%M%S)"
fi

{ gh release delete "${INPUT_TAG}" --cleanup-tag --yes; rc=$?; } || :

if [ -z "${INPUT_COMMIT}" ]; then
  if [ -z "${INPUT_BODY}" ]; then
    hub release create -m "${INPUT_TITLE}" "${INPUT_TAG}" 
  else
    hub release create -m "${INPUT_TITLE}" -m "${INPUT_BODY}" "${INPUT_TAG}" 
  fi
else
  if [ -z "${INPUT_BODY}" ]; then
    hub release create -t "${INPUT_COMMIT}" -m "${INPUT_TITLE}" "${INPUT_TAG}" 
  else
    hub release create -t "${INPUT_COMMIT}" -m "${INPUT_TITLE}" -m "${INPUT_BODY}" "${INPUT_TAG}" 
  fi 
fi
