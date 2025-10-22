from typing import cast
from hera.workflows import Workflow, Script
from hera.workflows import models as m

from hera_scratch.util import HOST, get_workflows_service


def create_workflow(w: Workflow):
    w.namespace = "argo"
    w.workflows_service = get_workflows_service()
    submitted_w = cast(m.Workflow, w.create())
    name = submitted_w.metadata.name
    namespace = submitted_w.metadata.namespace

    print(f"Submitted {name}")
    print(f"Open {HOST}/workflows/{namespace}/{name}")


if __name__ == "__main__":
    from hera.shared import global_config

    global_config.set_class_defaults(Script, constructor="runner")
    global_config.image = "hera-scratch:v1"

    from hera_scratch.workflow import w

    create_workflow(w)
