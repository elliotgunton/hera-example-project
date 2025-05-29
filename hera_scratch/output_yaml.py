if __name__ == "__main__":
    from hera.workflows import Script
    from hera.shared import global_config

    global_config.set_class_defaults(Script, constructor="runner")
    global_config.image = "hera-scratch:v1"

    from hera_scratch.workflow import w

    print(w.to_yaml())
