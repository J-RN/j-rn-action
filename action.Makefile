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

deploy: build
	git push -u origin "${DEPLOY_BRANCH}":"${DEPLOY_BRANCH}"

comment:
	$(MAKE) -f "${GITHUB_ACTION_PATH}/action.Makefile" requirements-$@
