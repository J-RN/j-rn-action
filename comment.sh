#!/usr/bin/env bash

echo ${!GIT*}
jq . "$GITHUB_EVENT_PATH"
env
