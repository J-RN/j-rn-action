#!/usr/bin/env bash
set -euo pipefail

# sanitise notebook(s)
git ls-files -z '*.ipynb' | xargs -0 "${PYTHON}" -m nbstripout --keep-count --keep-output

# create temporary gh-pages repo
mkdir -p _build/html
mkdir -p _static
pushd _build/html
git init -b "${DEPLOY_BRANCH}"
git remote add local_repo "file://${GITHUB_WORKSPACE}/.git"
git pull local_repo "${DEPLOY_BRANCH}":"${DEPLOY_BRANCH}" || :
git ls-files -z | xargs -0 git rm -rf || :
popd

# build static site
cp "${GITHUB_ACTION_PATH}"/conf.py . || :
cp "${GITHUB_ACTION_PATH}"/Makefile . || :
cp "${GITHUB_ACTION_PATH}"/logo.svg _static/ || :
make html

# update local branch
pushd _build/html
git add --all
git commit -m "update static site" || :
git push -u local_repo "${DEPLOY_BRANCH}":"${DEPLOY_BRANCH}"
popd
