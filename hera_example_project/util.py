from hera.workflows import WorkflowsService
from importlib.metadata import version, PackageNotFoundError


HOST = "https://localhost:2746"

try:
    VERSION_STR = f"v{version('hera-example-project')}"
except PackageNotFoundError:
    # Running on cluster
    VERSION_STR = ""

def get_workflows_service() -> WorkflowsService:
    return WorkflowsService(
        host=HOST,
        verify_ssl=False,
    )
