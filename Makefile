.PHONY: build push
default: check build
requirements-%:
	echo pip install -r "${GITHUB_ACTION_PATH}/${@}.txt"

check:
	@$(MAKE) requirements-$@
	if [ ${IGNORE_ERRORS} ]; then flake8 --exit-zero; else flake8; fi

build:
	@$(MAKE) requirements-$@
	git ls-files '*.ipynb' | xargs | nbstripout --keep-count --keep-output

push:
	@$(MAKE) requirements-$@
