#!/bin/bash
set -e
bundle install

push_new_licenses () {
  echo "List origins"
  git remote get-url --all origin
  echo "Show git status"
  git status

  echo "Debugging repo_url"
  REPO_URL="https://$GITHUB_ACTOR:$GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY.git"
  echo $REPO_URL
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
