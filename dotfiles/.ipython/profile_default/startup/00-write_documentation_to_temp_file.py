def write_help_documentation_to_file(obj, path="/tmp/python_help_documentation_file_for_nvim_split_window.txt"):
    from IPython.core.oinspect import Inspector
    import sys

    inspector = Inspector(theme_name="neutral")
    try:
        temp_help_file = open(path, "w")
        original_stdout = sys.stdout
        sys.stdout = temp_help_file
        object_metadata = inspector.info(obj)
        for field_name in object_metadata:
            temp_help_file.write(field_name.upper() + ":\n")
            temp_help_file.write(str(object_metadata[field_name]) + "\n\n\n")
    finally:
        temp_help_file.close()
        sys.stdout = original_stdout
