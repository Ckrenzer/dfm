#!/usr/bin/awk -f

# creates a backup of the user's dotfiles
# (uses dotfile_to_syspath.awk's output to determine paths).

BEGIN{
    system("test -d backup || mkdir backup")
    timestamp = strftime("%Y%m%d%H%M%S", systime())
    backup_dir = sprintf("backup/%s", timestamp)
    system(sprintf("mkdir %s", backup_dir))
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
    cmd_copy = sprintf("cp %s %s 2>/dev/null", system_file, backup_dir)
    system(cmd_copy)
}

END{
    cmd_archive = sprintf("tar cf %s.tar %s", backup_dir, backup_dir)
    cmd_compress = sprintf("gzip %s.tar", backup_dir)
    cmd_remove = sprintf("rm -r %s", backup_dir)
    system(sprintf("%s && %s && %s", cmd_archive, cmd_compress, cmd_remove))
}
