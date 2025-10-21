ARGO_WORKFLOWS_VERSION="v3.6.10"

.PHONY: build
build:
	poetry export --without-hashes --without-urls > requirements.txt
	docker build . -t hera-scratch:v1

.PHONY: run
run:
	poetry run python -m hera_scratch

.PHONY: format
format: ## Format and sort imports for source, tests, examples, etc.
	@poetry run ruff format .
	@poetry run ruff check . --fix

.PHONY: run-quick-start-argo
run-quick-start-argo:  ## Run Argo's quick start commands (run in docker desktop)
	@kubectl get namespace argo || kubectl create namespace argo
	@kubectl apply -n argo -f "https://github.com/argoproj/argo-workflows/releases/download/${ARGO_WORKFLOWS_VERSION}/quick-start-minimal.yaml"
	@kubectl -n argo port-forward deployment/argo-server 2746:2746 &

.PHONY: create-yaml  ## Convert Hera Workflow into YAML for GitOps (usually for WorkflowTemplates or CronWorkflows)
create-yaml:
	python -m hera_scratch.output_yaml > manifests/workflow.yaml
