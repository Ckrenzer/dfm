#!/usr/bin/awk -f

# copies dotfiles from the repo to the intended destination on disk
# (uses dotfile_to_syspath.awk's output to determine paths).

BEGIN{
    FS = ";"
    repo_file_field = 1
    system_file_field = 2
}

{
    # pass the input to the next command in a pipeline
    if(forward_input){
        print $0
    }
    repo_file = $(repo_file_field)
    system_file = $(system_file_field)
    cmd_copy = sprintf("cp %s %s", repo_file, system_file)
    system(cmd_copy)
}
