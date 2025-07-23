ARGO_WORKFLOWS_VERSION="v3.6.10"

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

.PHONY: run-quick-start-argo
run-quick-start-argo:  ## Run Argo's quick start commands (run in docker desktop)
	@kubectl get namespace argo || kubectl create namespace argo
	@kubectl apply -n argo -f "https://github.com/argoproj/argo-workflows/releases/download/${ARGO_WORKFLOWS_VERSION}/quick-start-minimal.yaml"
	# @kubectl -n argo port-forward deployment/argo-server 2746:2746 &
