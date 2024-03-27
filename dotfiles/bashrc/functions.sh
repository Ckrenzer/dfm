#!/usr/bin/bash

# cd to a directory in the shortcuts file
function _nav(){
    shortcuts_file="$HOME/bashrc/autocomplete/_nav.txt"
    local cur="${COMP_WORDS[COMP_CWORD]}"

    if test -f "$shortcuts_file" && test -r "$shortcuts_file"; then
        COMPREPLY=($(cut "$shortcuts_file" -d ";" -f2 | grep "^${cur}"))
    else
        COMPREPLY=()
    fi
}
function nav(){
    shortcuts_file="$HOME/bashrc/autocomplete/_nav.txt"
    if test "$#" -eq 0
    then
        echo "Shortcut Name:"
        cut "$shortcuts_file" -d";" -f2 | sort
        return 0
    fi
    cd $(awk -v shortcut="$1" 'BEGIN{FS=";"} $2 == shortcut{print $1}' "$shortcuts_file")
}
complete -F _nav nav

function notes(){
    nav proj && nvim notes/to-do.txt && cd -
}

# Moves the working directory up 'n' times
function up(){
    n=$1
    rgx="^[1-9]$"
    errormsg="You must provide a positive integer indicating the number of directories to traverse!"

    # Do nothing if no arguments were provided
    if [ "$#" -lt 1 ]
    then
      echo $errormsg
      return 1
    # Do nothing if a positive integer was not provided
    elif ! [[ $n =~ $rgx ]] ; then
      echo $errormsg
      return 1
    fi

    for (( i=0; i < n; i++ ))
    do
        cd ..
    done
}

# Eject all drives mounted on /media/$(whoami)/
function driveeject(){
    lsblk -o NAME,TYPE,MOUNTPOINT | \
        # start at position 3 to get rid of file tree 'links' of lsblk
        # strip the drive partition numbers, leaving us with the drive names.
        awk -v usr=$(whoami) \
        'BEGIN{
            external_drive_pattern = "/media/" usr "/"
        }

        $2 == "disk" {
            current_disk = $1
            next
        }

        $3 ~ external_drive_pattern {
            external_drives[current_disk]
        }

        # this will likely never do anything meaningful, but NEVER eject the boot drive
        $3 == "/" {
            delete external_drives[current_disk]
        }

        END{
            for(external_drive in external_drives){
                print external_drive
            }
        }' | \
        sort | uniq | xargs -r -n1 sudo eject
}

# Casts the screen of my phone in developer mode
function screencast(){
    adb kill-server
    adb start-server
    # start screencast when exactly one device is found.
    adb devices | \
        awk 'NR > 1 && length($0) > 0{valid_rows++} END{if(valid_rows != 1) exit 1}' && \
        scrcpy && adb kill-server || adb kill-server
}
