#!/bin/bash
set -e
bundle install

push_new_licenses () {
  git remote get-url --all origin
  git status
  if [ -n "$(git status --porcelain .licenses)" ]; then
    echo "New licenses found, pushing to repo..."
    # TODO: Add git add and git pushing logic.
    # git add .licenses/
    echo "Finish pushing license cache to repo."
  else
    echo "No new licenses found."
  fi
}

echo "Checking open-source licenses..."
if [[ -z "$CONFIG_PATH" ]]; then
  bundle exec licensed cache
  push_new_licenses
  bundle exec licensed status
else
  bundle exec licensed cache -c $CONFIG_PATH
  push_new_licenses
  bundle exec licensed status -c $CONFIG_PATH
fi
echo "Finished checking licenses, all clear!"
