#!/usr/bin/awk -f

# moves the dotfiles from the repo to the intended destination on disk.

BEGIN{
    timestamp = strftime("%Y%m%d%H%M%S", systime())
    backup_dir = sprintf("backup/%s", timestamp)
    system(sprintf("mkdir %s -p", backup_dir))
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
    # ensure destination directory exists
    system_dirname = gensub(/[^/]+$/, "", "1", system_file)
    system(sprintf("mkdir %s -p", system_dirname))
    cmd_copy = sprintf("cp %s %s", repo_file, system_file)
    system(cmd_copy)
}
