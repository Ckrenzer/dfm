#!/usr/bin/awk -f

# creates a backup of the user's dotfiles.

BEGIN{
    system("test -d backup || mkdir backup")
    timestamp = strftime("%Y%m%d%H%M%S", systime())
    backup_dir = sprintf("backup/%s", timestamp)
    system(sprintf("mkdir %s", backup_dir))
    FS = ";"
}

{
    # $2 is the path to the pre-existing dotfile Ex. ~/.bashrc
    cmd_copy = sprintf("cp %s %s 2>/dev/null", $2, backup_dir)
    system(cmd_copy)
}

END{
    cmd_archive = sprintf("tar cf %s.tar %s", backup_dir, backup_dir)
    cmd_compress = sprintf("gzip %s.tar", backup_dir)
    cmd_remove = sprintf("rm -r %s", backup_dir)
    system(sprintf("%s && %s && %s", cmd_archive, cmd_compress, cmd_remove))
}
