#!/bin/bash

# Git for Windows does not provide a dedicated rename function.
# This script replaces matched patterns of file names in the current
# working directory. Regular expressions in the pattern only update
# one file per call.
# Uses ls, awk, and mv.
#
# Put this in your .bashrc:
# function rename(){
#     [ $# == 0 ] && echo "You must supply a pattern and replacement to rename()!" && return 1
#     [ $# == 1 ] && echo "You must supply a pattern AND a replacement to rename()!" && return 1
#     [ $# -ne 2 ] && echo "You can only supply one pattern and one replacement to rename()!" && return 1
#     source "${PATH_TO_RENAME_SCRIPT}/rename.sh" $@
# }
#
# Usage:
# rename {pattern} {replacement}

ls -U -p -1 --color=never | awk -v pattern=$1 -v replacement=$2 'BEGIN{
            maxlen = 0
            num_updates = 0
            max_updates = 999999
            col1 = "FROM"
            col2 = "TO"
            if(pattern ~ /[\[\]?*+|]/){
                print "Regular expression detected in your pattern!"
                print "Only renaming the first file matched for your safety.\n"
                max_updates = 1
            }

        }

        !/\/$/ && $0 ~ pattern {
            match_found = 1
            current_filename = $NF
            new_filename = current_filename
            sub(pattern, replacement, new_filename)
            if(length(current_filename) > max_initial_length){
                max_initial_length = length(current_filename)
            }
            if(length(new_filename) > max_new_length){
                max_new_length = length(new_filename)
            }
            if(length(current_filename) > maxlen) maxlen = length(current_filename)
            if(length(new_filename) > maxlen) maxlen = length(new_filename)
            current_filenames[current_filename] = current_filename
            new_filenames[current_filename] = new_filename
        }

        END{
            if(!match_found){
                print "Match not found."
                exit(0)
            }
            maxlen = maxlen + 10
            max_new_length = max_new_length - length(col2)

            print "Files renamed.\n"
            printf("%-" max_initial_length "s%" (maxlen - max_new_length) "s\n", col1, col2)
            for(current_filename in current_filenames){
                new_filename = new_filenames[current_filename]
                # Need intermediate file names for case changes using mv
                # (allow changes from "file.txt" to "FILE.txt")
                tempname = current_filename ".temp"
                if(current_filename != new_filename && num_updates < max_updates){
                    printf("mv --no-clobber %s %s\n", current_filename, tempname) | "sh"
                    printf("mv --no-clobber %s %s\n", tempname, new_filename) | "sh"
                    printf(current_filename "%" maxlen "s\n", new_filename)
                    num_updates++
                }
            }
        }'
