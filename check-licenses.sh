#!/bin/bash
set -e

if [[ -z "$CONFIG_PATH" ]]; then
  bundle exec licensed cache
  bundle exec licensed status
else
  bundle exec licensed cache -c $CONFIG_PATH
  bundle exec licensed status -c $CONFIG_PATH
fi
