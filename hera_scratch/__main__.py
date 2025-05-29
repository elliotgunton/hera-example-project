from typing import cast
from hera.workflows import Workflow, WorkflowsService
from hera.workflows import models as m


def run_workflow(w: Workflow):
    w.namespace = "argo"
    w.workflows_service = WorkflowsService(
        host="https://localhost:2746",
        verify_ssl=False,
    )
    submitted_w = cast(m.Workflow, w.create())
    print(f"Submitted {submitted_w.metadata.name}")
    print(f"Open https://localhost:2746/workflows/argo/{submitted_w.metadata.name}")


if __name__ == "__main__":
    from hera.workflows import Script
    from hera.shared import global_config

    global_config.set_class_defaults(Script, constructor="runner")
    global_config.image = "hera-scratch:v1"

    from hera_scratch.workflow import w

    run_workflow(w)
