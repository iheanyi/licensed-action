#!/bin/bash
set -e

if [[ -z "$CONFIG_PATH" ]]; then
  licensed cache
  licensed status
else
  licensed cache -c $CONFIG_PATH
  licensed status -c $CONFIG_PATH
fi
