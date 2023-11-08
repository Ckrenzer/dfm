#!/usr/bin/bash

# moves dotfiles from the repo to their intended destinations.

[ -d dotfiles ] && \
    ls dotfiles/ --recursive -1 --color=never -U --classify | \
    awk -f fileops/dotfile_to_syspath.awk -v dotfile_homedir="~" | \
    awk -f fileops/archive.awk -v forward_input=1 -v pwd=$(pwd) | \
    awk -f fileops/transfer.awk

