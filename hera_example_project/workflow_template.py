from importlib.metadata import version

from hera.workflows import WorkflowTemplate, script

# The workflow template and the container versions are the same to stay fully in sync
VERSION_STR = f"v{version('hera-example-project')}"


@script(constructor="runner")
def hello(s: str):
    print(f"Hello, {s}!")


with WorkflowTemplate(
    name=f"hello-world-{VERSION_STR}",
    entrypoint="hello",
    arguments={"s": "world"},
) as w:
    hello()
