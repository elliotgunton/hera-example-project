ARGO_WORKFLOWS_VERSION=v3.7.4

.PHONY: build
build:
	poetry export --without-hashes --without-urls > requirements.txt
	docker build . -t elliotgunton/hera-example-project:v$(shell poetry version -s)

.PHONY: push
push:
	docker push elliotgunton/hera-example-project:v$(shell poetry version -s)

.PHONY: run
run:
	poetry run python -m hera_example_project

.PHONY: run-wt
run-wt:
	poetry run python -m hera_example_project.workflow_template

.PHONY: format
format: ## Format and sort imports for source, tests, examples, etc.
	@poetry run ruff format .
	@poetry run ruff check . --fix

.PHONY: run-quick-start-argo
run-quick-start-argo:  ## Run Argo's quick start commands (run in docker desktop)
	@kubectl get namespace argo || kubectl create namespace argo
	@kubectl apply -n argo -f "https://github.com/argoproj/argo-workflows/releases/download/${ARGO_WORKFLOWS_VERSION}/quick-start-minimal.yaml"
	@kubectl -n argo port-forward deployment/argo-server 2746:2746 &

.PHONY: create-yaml  ## Convert Hera WorkflowTemplate into YAML for GitOps
create-yaml:
	python -m hera_example_project.output_yaml > manifests/workflow_template.yaml
