#!/usr/bin/awk -f

# creates a backup of the user's dotfiles using dotfile_to_syspath.awk's output.

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
    system_file = $(system_file_field)
    file_exists = system(sprintf("[ -f %s ]", system_file)) == 0
    if(file_exists){
        cmd_copy = sprintf("cp %s %s", system_file, backup_dir)
        system(cmd_copy)
    }
}

END{
    cmd_archive = sprintf("tar cf %s.tar %s", backup_dir, backup_dir)
    cmd_compress = sprintf("gzip %s.tar", backup_dir)
    cmd_remove = sprintf("rm -rf %s", backup_dir)
    system(sprintf("%s && %s && %s", cmd_archive, cmd_compress, cmd_remove))
}
