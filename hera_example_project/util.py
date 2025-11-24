from hera.workflows import WorkflowsService


HOST = "https://localhost:2746"


def get_workflows_service() -> WorkflowsService:
    return WorkflowsService(
        host=HOST,
        verify_ssl=False,
    )
