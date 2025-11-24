ARGO_WORKFLOWS_VERSION=v3.7.4
DOCKERHUB_USERNAME=elliotgunton

.PHONY: build
build:
	poetry export --without-hashes --without-urls > requirements.txt
	docker build . -t ${DOCKERHUB_USERNAME}/hera-example-project:v$(shell poetry version -s)

.PHONY: push
push:
	docker push ${DOCKERHUB_USERNAME}/hera-example-project:v$(shell poetry version -s)

.PHONY: run
run:
	poetry run python -m hera_example_project

.PHONY: run-wt
run-wt:
	@(kubectl -n argo port-forward deployment/argo-server 2746:2746 &)
	poetry run python -m hera_example_project

.PHONY: format
format: ## Format and sort imports for source, tests, examples, etc.
	@poetry run ruff format .
	@poetry run ruff check . --fix

.PHONY: install-k3d
install-k3d: ## Install k3d client
	curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

.PHONY: set-up-cluster
set-up-cluster: ## Create the cluster and argo namespace
	k3d cluster list | grep test-cluster || k3d cluster create test-cluster
	k3d kubeconfig merge test-cluster --kubeconfig-switch-context

.PHONY: set-up-argo
set-up-argo: ## Start the argo service
	kubectl get namespace argo || kubectl create namespace argo
	kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/$(ARGO_WORKFLOWS_VERSION)/install.yaml
	kubectl patch deployment argo-server --namespace argo --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/args", "value": ["server", "--auth-mode=server"]}]'
	kubectl create rolebinding default-admin --clusterrole=admin --serviceaccount=argo:default --namespace=argo
	kubectl rollout status -n argo deployment/argo-server --timeout=120s --watch=true

.PHONY: stop-cluster
stop-cluster:  ## Stop the cluster
	k3d cluster stop test-cluster

.PHONY: run-quick-start-argo
run-quick-start-argo:  ## Run Argo's quick start commands (run in docker desktop)
	@kubectl get namespace argo || kubectl create namespace argo
	@kubectl apply -n argo -f "https://github.com/argoproj/argo-workflows/releases/download/${ARGO_WORKFLOWS_VERSION}/quick-start-minimal.yaml"
	@kubectl -n argo port-forward deployment/argo-server 2746:2746 &

.PHONY: create-yaml  ## Convert Hera WorkflowTemplate into YAML for GitOps
create-yaml:
	python -m hera_example_project.output_yaml > manifests/workflow_template.yaml
