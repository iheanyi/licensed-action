#!/bin/bash
set -e

# setup_git_env is responsible for setting a username and email for updating the 
# cache of licenses.
setup_git_env () {
  if [ ! -n "$(git config user.email)" ]; then
    echo "Setting up git environment..."
    git config user.name "GitHub Actions"
    git config user.email "actions@github.com"
  fi
}

# do_git_push actually pushes changes to the repo.
do_git_push () {
  echo "New licenses found, pushing to repo..."
  git add .licenses/
  git commit -m "Update licenses cache."
  git push --set-upstream origin $(git symbolic-ref --short HEAD)
  echo "Finish pushing license cache to repo."
}

# push_new_licenses sets up and pushes changes to the licenses
push_new_licenses () {
  if [ -n "$(git status --porcelain .licenses)" ]; then
    setup_git_env
    do_git_push
  else
    echo "No new licenses found, skipping push..."
  fi
}

install_ruby_deps_if_necessary () {
 if [ -f Gemfile.lock ]; then
  echo "Gemfile.lock found, installing ruby dependencies..."
  bundle install
 fi
}

# install_npm_deps_if_necessary installs npm dependencies if there's a
# package.json file.
install_npm_deps_if_necessary() {
  if [ ! -d node_modules ]; then
    if [ -f package.json ]; then
      echo "node_modules not found, package.json found, installing npm dependencies..."
      npm install
    fi
  fi
}

echo "Checking open-source licenses..."
install_npm_deps_if_necessary
install_ruby_deps_if_necessary

if [[ -z "$CONFIG_PATH" ]]; then
  licensed cache
  push_new_licenses
  licensed status
else
  licensed cache -c $CONFIG_PATH
  push_new_licenses
  licensed status -c $CONFIG_PATH
fi
echo "Finished checking licenses, all clear!"
