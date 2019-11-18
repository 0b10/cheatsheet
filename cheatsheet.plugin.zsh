#!/usr/bin/zsh

function __cs_help() {
    echo "help menu"
}

function __cs_display_cheatsheet() {
    # $1 is sheet name
    echo "displaying cheatsheet $1"
}

function __cs_add_cheatsheet() {
    [ -e $1 ] && echo "cs: you must provide a cheatsheet name" && return 1
    # $1 is sheet name
    echo "adding cheatsheet $1"
}

function __cs_edit_cheatsheet() {
    [ -e $1 ] && echo "cs: you must provide a cheatsheet name" && return 1
    # $1 is sheet name
    echo "editing cheatsheet $1"
    
}

case "$1" in
    "help"|"-h"|"--help")
        __cs_help
    ;;
    "add"|"-a"|"--add")
        __cs_add_cheatsheet $2
    ;;
    "edit"|"-e"|"--edit")
        __cs_edit_cheatsheet $2
    ;;
    *)
        __cs_display_cheatsheet $1
    ;;
esac
