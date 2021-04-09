#!/usr/bin/env bash
set -euo pipefail

# sanitise notebook(s)
git ls-files -z '*.ipynb' | xargs -0 "${PYTHON}" -m nbstripout --keep-count --keep-output

# create temporary gh-pages repo
mkdir -p _build/html
pushd _build/html
git init -b "${DEPLOY_BRANCH}"
git remote add local_repo "file://${GITHUB_WORKSPACE}/.git"
git pull local_repo "${DEPLOY_BRANCH}":"${DEPLOY_BRANCH}" || :
git ls-files -z | xargs -0 git rm -rf || :
popd

# build static site
cp -R "${GITHUB_ACTION_PATH}"/_static/ . || :
cp -R "${GITHUB_ACTION_PATH}"/_templates/ . || :
cp "${GITHUB_ACTION_PATH}"/conf.py . || :
# cp "${GITHUB_ACTION_PATH}"/Makefile . || :
# make html
# sphinx-build . _build/html
which pandoc || sudo apt-get install pandoc -yqq || echo "WARN: could not install pandoc"
sphinx-multiversion . _build/html

# update local branch
pushd _build/html
sed "s/{{ latest }}/$(git -C ../.. branch --show-current)/" "${GITHUB_ACTION_PATH}"/_templates/redirect.html >index.html
echo ".doctrees/" >>.gitignore
git add --all
git config --local user.name "${GIT_AUTHOR_NAME:-J-RN[bot]}"
git config --local user.email "${GIT_AUTHOR_EMAIL:-80856664+j-rn-bot@users.noreply.github.com}"
git commit -m "update static site" || :
git push -u local_repo "${DEPLOY_BRANCH}":"${DEPLOY_BRANCH}"
popd
