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
1. If using a Hera Runner example, copy the snippet below<sup>1</sup> into the top of the workflow.py file. Ensure no script
   decorators have set their own `image`.
1. Run `make run`. See output below<sup>2</sup>.
1. See the Workflow at the link printed to the console.

<br>

1. Runner config snippet:

```py
from hera.workflows import Script
from hera.shared import global_config

global_config.set_class_defaults(Script, constructor="runner")
global_config.image = "hera-scratch:v1"
```

2. `make run` output:
```
poetry run python -m hera_scratch
Submitted hello-world-5grb2
Open https://localhost:2746/workflows/argo/hello-world-5grb2
```
