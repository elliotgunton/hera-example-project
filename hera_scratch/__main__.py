from typing import cast
from hera.workflows import Workflow, WorkflowsService
from hera.workflows import models as m


def run_workflow(w: Workflow):
    host = "https://localhost:2746"
    w.namespace = "argo"
    w.workflows_service = WorkflowsService(
        host=host,
        verify_ssl=False,
    )
    submitted_w = cast(m.Workflow, w.create())
    name = submitted_w.metadata.name
    namespace = submitted_w.metadata.namespace
    print(f"Submitted {name}")
    print(f"Open {host}/workflows/{namespace}/{name}")


if __name__ == "__main__":
    from hera.workflows import Script
    from hera.shared import global_config

    global_config.set_class_defaults(Script, constructor="runner")
    global_config.image = "hera-scratch:v1"

    from hera_scratch.workflow import w

    run_workflow(w)
