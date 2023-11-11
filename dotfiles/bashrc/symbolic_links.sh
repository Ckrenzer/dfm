#!/usr/bin/bash

mkdir ~/symbolic_links 2> /dev/null
export PATH:$PATH:~/symbolic_links

function shortcut() {
    test "$#" -gt 1 && test -e "$1" && \
    ln -s "$1" "~/symbolic_links/$2" && \
    echo "shortcut '$2' created for '$1'" || echo "could not create shortcut"
}

shortcut "/media/ckrenzer/ck/projects/"                                    "proj"
shortcut "/media/ckrenzer/ck/projects/learning/messing_around/"            "ma"
shortcut "/media/ckrenzer/ck/projects/repos/active/Winter-Livestock-Data/" "wl"
shortcut "/media/ckrenzer/ck/projects/repos/active/advent_of_code/"        "aoc"
shortcut "/media/ckrenzer/ck/projects/repos/active/crypto_arbitrage/"      "crypto"
