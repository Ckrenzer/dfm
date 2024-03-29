#!/usr/bin/awk -f

# copies dotfiles from this repo to the intended destination on disk.

BEGIN{
    FS = ";"
}

{
    # $1 is the path to the dotfile in the repo  Ex. ~/dot_bashrc
    # $2 is the path to the pre-existing dotfile Ex. ~/.bashrc
    cmd_copy = sprintf("cp %s %s", $1, $2)
    system(cmd_copy)
}
