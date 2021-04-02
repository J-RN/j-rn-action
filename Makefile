.PHONY: build push
default: check build
PYTHON=python
PIP=$(PYTHON) -m pip
FLAKE8=$(PYTHON) -m flake8
NBSTRIPOUT=$(PYTHON) -m nbstripout --keep-count --keep-output
requirements-%:
	$(PIP) install -r "${GITHUB_ACTION_PATH}/${@}.txt"

check:
	@$(MAKE) requirements-$@
	if [ -n "${IGNORE_ERRORS}" ]; then $(FLAKE8) --exit-zero; else $(FLAKE8); fi

build:
	@$(MAKE) requirements-$@
	git ls-files '*.ipynb' | xargs | $(NBSTRIPOUT)

push:
	@$(MAKE) requirements-$@
