#!/usr/bin/awk -f

# prints the path names of the repo files and their corresponding destinations
# under the dotfiles directory.

BEGIN{
    RS = "\0"
}

{
    local = gensub(/dotfiles/, dotfile_homedir, "1", $0)
    sub(/dot_/, ".", local)
    printf("%s;%s\n", $0, local)
}
