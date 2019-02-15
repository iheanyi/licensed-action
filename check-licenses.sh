#!/bin/bash
set -e
bundle install

setup_git_env () {
  echo "Setting up git environment..."
  git config --global user.name "GitHub Actions"
  # TODO: Figure out how to perhaps set this to a more sane value.
  git config --global user.email "test@example.com"

  # git fetch
  # git pull
}

push_new_licenses () {
  setup_git_env
  REPO_URL="https://$GITHUB_TOKEN:x-oauth-basic@github.com/$GITHUB_REPOSITORY.git"
  if [ -n "$(git status --porcelain .licenses)" ]; then
    echo "New licenses found, pushing to repo..."
    # TODO: Add git add and git pushing logic.
    git add .licenses/
    git commit -m "Update licenses cache."
    git push --set-upstream origin $(git symbolic-ref --short HEAD)
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
