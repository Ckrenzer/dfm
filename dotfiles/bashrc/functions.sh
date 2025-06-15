#!/usr/bin/bash

# Casts the screen of my phone in developer mode
function screencast(){
    adb kill-server
    adb start-server
    # start screencast when exactly one device is found.
    adb devices | \
        awk 'NR > 1 && length($0) > 0{valid_rows++} END{if(valid_rows != 1) exit 1}' && \
        scrcpy && adb kill-server || adb kill-server
}

# the here doc requires there be no indentation
function generate_password(){
read -d '\n' r_program << EndOfText
n <- as.integer(commandArgs(trailingOnly = TRUE))
# excluding backticks since they are too easily confused
chars <- c("a", "b",  "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
           "A", "B",  "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
           "n", "o",  "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
           "N", "O",  "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
                "1",  "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=",
           "~", "!",  "@", "#", "$", "%", "^", "&", "*", "(", ")", "_", "+",
           "[", "]", "\\", ";", ",", ".", "/", "'",
           "{", "}",  "|", ":", "<", ">", "?"
       )
secret <- sample(x = chars, size = n, replace = TRUE)
secret <- paste(secret, collapse = "")
cat(secret)
EndOfText
Rscript -e "$r_program" "$1"
echo ""
}
