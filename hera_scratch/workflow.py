from hera.workflows import Workflow, script


@script()
def hello(s: str):
    print(f"Hello, {s}!")


with Workflow(
    generate_name="hello-world-",
    entrypoint="hello",
    arguments={"s": "world"},
) as w:
    hello()
