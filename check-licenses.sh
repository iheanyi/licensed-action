#!/bin/bash
set -e
bundle install

push_new_licenses () {
  echo "List origins"
  git remote get-url --all origin
  echo "Show git status"
  git status

  git config --global user.name "GitHub Actions"
  # TODO: Figure out how to perhaps set this to a more sane value.
  git config --global user.email "test@example.com"
  REPO_URL="https://$GITHUB_ACTOR:$GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY.git"
  if [ -n "$(git status --porcelain .licenses)" ]; then
    echo "New licenses found, pushing to repo..."
    # TODO: Add git add and git pushing logic.
    git add .licenses/
    git commit -am "Update licenses cache."
    git push
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
