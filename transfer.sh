#!/usr/bin/bash

# moves dotfiles from the repo to their intended destinations.

test -d dotfiles && \
    ls dotfiles/ -1RF | \
    awk -f fileops/dotfile_to_syspath.awk -v dotfile_homedir="~" | \
    awk -f fileops/make_destination_dirs.awk -v forward_input=1 | \
    awk -f fileops/archive.awk -v forward_input=1 -v pwd=$(pwd) | \
    awk -f fileops/transfer.awk || \
    echo "dotfiles directory not found. ensure transfer.sh is called from dfm's root."

