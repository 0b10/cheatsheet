#!/usr/bin/zsh

__CS_LOCAL_DIR="$(dirname $0)/";
__CS_TEMPLATE="${__CS_LOCAL_DIR}/cheatsheet.template.txt";
__CS_SHEETS="${HOME}/.config/cs-omzsh/sheets/";
__CS_EDITOR=$EDITOR;

if [[ ! -e $EDITOR ]]; then
    __CS_EDITOR="vim";
fi

if [[ ! -e "$__CS_SHEETS" ]]; then
    # make a storage location for sheets
    mkdir -p ${__CS_SHEETS};
fi

function __cs_help() {
    echo "help menu"
}

function __cs_display_cheatsheet() {
    # $1 is sheet name
    echo "displaying cheatsheet $1"
}

function __cs_add_cheatsheet() {
    # $1 is sheet name
    local sheet="${__CS_SHEETS}/${1}"
    
    [ -e $1 ] && echo "cs: you must provide a cheatsheet name" && return 1;
    [ -e $sheet ] && echo "cs: cheatsheet already exists -- '${1}'" && return 1;
    
    cp $__CS_TEMPLATE $sheet;
    $__CS_EDITOR $sheet;
}

function __cs_edit_cheatsheet() {
    [ -e $1 ] && echo "cs: you must provide a cheatsheet name" && return 1
    # $1 is sheet name
    echo "editing cheatsheet $1"
}

function __cs_list_cheatsheets() {
    ls $__CS_SHEETS | sort
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
    "list"|"show"|"ls"|"-l"|"--list")
        __cs_list_cheatsheets
    ;;
    *)
        __cs_display_cheatsheet $1
    ;;
esac
