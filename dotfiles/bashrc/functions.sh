#!/usr/bin/bash

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

# Eject drive
function driveeject(){
    cd ~
    cat ~/base/.personal | sudo -S eject /dev/sdb
    echo ""
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
