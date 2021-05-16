.PHONY: check build push deploy comment
default: check build push
PIP=${PYTHON} -m pip
FLAKE8=${PYTHON} -m flake8
requirements-%:
	$(PIP) install -r "${GITHUB_ACTION_PATH}/${@}.txt"

check:
	$(MAKE) -f "${GITHUB_ACTION_PATH}/action.Makefile" requirements-$@
	if [ -n "${IGNORE_ERRORS}" ]; then $(FLAKE8) --exit-zero; else $(FLAKE8); fi

build:
	$(MAKE) -f "${GITHUB_ACTION_PATH}/action.Makefile" requirements-$@
	"${GITHUB_ACTION_PATH}/build.sh"

push:
	git fetch origin "${DEPLOY_BRANCH}" || :
	git push -u origin -f "${DEPLOY_BRANCH}":"${DEPLOY_BRANCH}"

deploy: check build push conf.py meta.py index.ipynb
	git checkout "${DEPLOY_BRANCH}" -- '*.ipynb'
	git add -u || :
	git config --local user.name "J-RN[bot]"
	git config --local user.email "80856664+j-rn-bot@users.noreply.github.com"
	git commit -m "render notebooks" && echo TODO retag || :
	git push || echo "WARN: git push origin -- *.ipynb failed" >&2

comment:
	"${GITHUB_ACTION_PATH}/comment.sh"
