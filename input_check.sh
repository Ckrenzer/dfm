#!/usr/bin/bash

# moves dotfiles from the repo to their intended destinations.

test -d dotfiles && \
    echo "MKDIR COMMANDS" && \
    ls dotfiles/ -1RF | \
    awk -f fileops/dotfile_to_syspath.awk -v dotfile_homedir="~" | \
    awk -f fileops/make_destination_dirs.awk -v only_print_dirname=1 && \
    printf "\nDOTFILE_TO_SYSPATH PATHS\n" && \
    ls dotfiles/ -1RF | \
    awk -f fileops/dotfile_to_syspath.awk -v dotfile_homedir="~" || \
    echo "dotfiles directory not found. ensure pathtest.sh is called from dfm's root."
