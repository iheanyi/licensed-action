#!/bin/bash
set -e

setup_git_env () {
  echo "Setting up git environment..."
  if [ ! -n "$(git config user.name)" ]; then
    git config user.name "GitHub Actions"
  fi
  if [ ! -n "$(git config user.email)" ]; then
    git config user.email "actions@github.com"
  fi
}

do_git_push () {
  echo "New licenses found, pushing to repo..."
  git add .licenses/
  git commit -m "Update licenses cache."
  git push --set-upstream origin $(git symbolic-ref --short HEAD)
  echo "Finish pushing license cache to repo."
}

push_new_licenses () {
  if [ -n "$(git status --porcelain .licenses)" ]; then
    setup_git_env
    do_git_push
  else
    echo "No new licenses found, skipping push..."
  fi
}

echo "Checking open-source licenses..."

if [ ! -d node_modules ]; then
  if [ -f package.json ]; then
    echo "node_modules not found, package.json found, installing npm dependencies..."
    npm install
  fi
fi

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
