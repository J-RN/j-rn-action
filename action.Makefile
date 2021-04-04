.PHONY: check build deploy comment
default: check build
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

deploy: check build conf.py meta.py index.ipynb
	git push -u origin "${DEPLOY_BRANCH}":"${DEPLOY_BRANCH}"
	git checkout "${DEPLOY_BRANCH}" -- '*.ipynb'
	git add -u || :
	git commit -m "render notebooks" || :
	git push || echo "WARN: git push origin -- *.ipynb failed" >&2

comment:
	$(MAKE) -f "${GITHUB_ACTION_PATH}/action.Makefile" requirements-$@
