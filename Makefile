.PHONY: run-offline
run-offline:
	poetry run python -m hera_scratch

.PHONY: run
run:
	@poetry export --without-hashes --without-urls > requirements.txt
	@docker build . -t hera-scratch:v1
	poetry run python -m hera_scratch

.PHONY: format
format: ## Format and sort imports for source, tests, examples, etc.
	@poetry run ruff format .
	@poetry run ruff check . --fix
