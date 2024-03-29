#!/usr/bin/bash

# moves dotfiles from the repo to their intended destinations.

if [ -d dotfiles ]
then
    find dotfiles/ -type f -print0 > out.txt && \
        awk -f fileops/dotfile_to_syspath.awk -v dotfile_homedir="~" out.txt \
            > dotfile_to_syspath_out.txt && \
        cut -d";" -f2 < dotfile_to_syspath_out.txt | \
        awk -f fileops/make_destination_dirs.awk && \
        awk -f fileops/archive.awk -v pwd=$(pwd) dotfile_to_syspath_out.txt && \
        awk -f fileops/transfer.awk dotfile_to_syspath_out.txt && \
        rm out.txt dotfile_to_syspath_out.txt || \
        rm out.txt dotfile_to_syspath_out.txt
else
    echo "dotfiles directory not found. ensure transfer.sh is called from dfm's root."
fi
