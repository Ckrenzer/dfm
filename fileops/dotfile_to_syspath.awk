#!/usr/bin/awk -f

# prints the path names of the repo files
# and their corresponding destinations in
# the dotfiles directory.

/:$/{
    repo_dirname = gensub(/\/:$|:$/, "/", "1", $0)
    system_dirname = gensub(/dotfiles/, dotfile_homedir, "1", repo_dirname)
    system_dirname = gensub(/dot_/, ".", "g", system_dirname)
}

# ignore directories (":$" and "/$") and newlines
!/:$/ && !/\/$/ && length($0) > 0{
    repo = repo_dirname $0
    local = system_dirname $0
    local = gensub(/dot_/, ".", "1", local)
    printf("%s;%s\n", repo, local)
}
