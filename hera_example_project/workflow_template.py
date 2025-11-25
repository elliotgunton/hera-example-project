
from hera.workflows import WorkflowTemplate, script

from hera_example_project.util import VERSION_STR

@script()
def hello(s: str):
    print(f"Hello, {s}!")


with WorkflowTemplate(
    name=f"hello-world-{VERSION_STR}",
    entrypoint="hello",
    arguments={"s": "world"},
) as w:
    hello()
