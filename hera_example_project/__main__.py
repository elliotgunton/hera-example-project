import os
from typing import cast
from hera.workflows import Workflow, Script
from hera.workflows import models as m

from hera_example_project.util import HOST, get_workflows_service
from hera_example_project.workflow_template import VERSION_STR


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
    global_config.image = os.environ.get("IMAGE_NAME", f"elliotgunton/hera-example-project:{VERSION_STR}")

    from hera_example_project.workflow import w

    create_workflow(w)

    from hera_example_project.workflow_template import w

    w.namespace = "argo"
    w.workflows_service = get_workflows_service()
    submitted_w = cast(m.Workflow, w.create_as_workflow(wait=True))
    name = submitted_w.metadata.name
    namespace = submitted_w.metadata.namespace

    print(f"Submitted {name}")
    print(f"Open {HOST}/workflows/{namespace}/{name}")
