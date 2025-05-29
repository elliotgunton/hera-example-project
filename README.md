# Hera Example Project

This project can run Hera Workflows on a local Kubernetes installation of Argo Workflows. It builds an image so you can
use the Hera Runner easily.

## Prerequisites

* `pipx`
* `poetry` (install with `pipx install poetry`)
    * `poetry-plugin-export` (install with `pipx inject poetry poetry-plugin-export`)
* `docker` (desktop, with a Kubernetes cluster running)
* Argo Workflows installed, and the Argo server port-forwarded

## Running

1. Copy an example Workflow from Hera into [workflow.py](hera_scratch/workflow.py)
1. If using a Hera Runner example, ensure no script decorators have set their own `image`.
1. Run `make run`.
1. See the Workflow at the link printed to the console.
