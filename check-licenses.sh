#!/bin/bash
set -e
export LC_ALL="en_US.UTF-8"
bundle install

if [[ -z "$CONFIG_PATH" ]]; then
  bundle exec licensed cache
  bundle exec licensed status
else
  bundle exec licensed cache -c $CONFIG_PATH
  bundle exec licensed status -c $CONFIG_PATH
fi
