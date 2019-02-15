#!/bin/bash
set -e
bundle install

setup_git_env () {
  echo "Setting up git environment..."
  git config --global user.name "GitHub Actions"
  git config --global user.email "actions@github.com"
}

push_new_licenses () {
  if [ -n "$(git status --porcelain .licenses)" ]; then
    setup_git_env
    echo "New licenses found, pushing to repo..."
    git add .licenses/
    git commit -m "Update licenses cache."
    git push --set-upstream origin $(git symbolic-ref --short HEAD)
    echo "Finish pushing license cache to repo."
  else
    echo "No new licenses found, skipping push..."
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
