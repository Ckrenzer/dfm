#!/usr/bin/bash

# prints the mkdir commands and the paths created by dotfile_to_syspath.awk.

if [ -d dotfiles ]
then
    find dotfiles/ -type f -print0 > out.txt && \
        awk -f fileops/dotfile_to_syspath.awk -v dotfile_homedir="~" out.txt \
            > dotfile_to_syspath_out.txt && \
        echo "MKDIR COMMANDS" && \
        cut -d";" -f2 < dotfile_to_syspath_out.txt | \
            awk -f fileops/make_destination_dirs.awk -v print_only=1 && \
        echo -e "\nDOTFILE_TO_SYSPATH" && \
        cat dotfile_to_syspath_out.txt && \
        rm out.txt dotfile_to_syspath_out.txt ||
        rm out.txt dotfile_to_syspath_out.txt
else
    echo "dotfiles directory not found. ensure pathtest.sh is called from dfm's root."
fi
