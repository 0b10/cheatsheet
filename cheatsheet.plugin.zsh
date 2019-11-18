#!/usr/bin/zsh

__CS_LOCAL_DIR="$(dirname $0)/";
__CS_TEMPLATE="${__CS_LOCAL_DIR}/cheatsheet.template.txt";
__CS_SHEETS="${HOME}/.config/cs-omzsh/sheets";
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
    local sheet="${__CS_SHEETS}/${1}"
    
    cat $sheet | grep -vE '^#'; # ignore comments
}

function __cs_add_cheatsheet() {
    # $1 is sheet name
    local sheet="${__CS_SHEETS}/${1}"
    
    [ -e $1 ] && echo "cs: you must provide a cheatsheet name" && return 1;
    [ -e $sheet ] && echo "cs: cheatsheet already exists -- '${1}'" && return 1;
    
    cp $__CS_TEMPLATE $sheet;
    $__CS_EDITOR $sheet;
}

function __cs_remove_cheatsheet() {
    # $1 is sheet name
    [ -z $1 ] && echo "cs: you must provide a cheatsheet name" && return 1;
    
    local sheet="${__CS_SHEETS}/${1}";
    
    if [ ! -f $sheet ]; then
        echo "cs: cheatsheet does not exist -- '${1}'";
        echo "Try 'cs list' to get a list of existing cheatsheets.";
        return 1;
    fi
    
    read "answer?cs: are you sure you want to remove the '${1}' cheatsheet? [y/N]: ";
    
    if [[ "${answer:u}" == "Y" || "${answer:u}" == "YES" ]]; then
        shred -un 10 $sheet && echo "cs: cheatsheet removed -- '${1}'";
        return 0;
    fi
    echo "cs: no cheatsheets were removed";
}

function __cs_edit_cheatsheet() {
    # $1 is sheet name
    [ -e $1 ] && echo "cs: you must provide a cheatsheet name" && return 1;
    
    local sheet="${__CS_SHEETS}/${1}"
    
    if [ ! -e $sheet ]; then
        echo "cs: cheatsheet does not exist -- '${1}'";
        echo "Try 'cs list' to get a list of existing cheatsheets.";
        return 1;
    fi
    
    $__CS_EDITOR $sheet
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
    "remove"|"-r"|"--remove"|"del"|"delete"|"-d"|"--delete"|"--del")
        __cs_remove_cheatsheet $2
    ;;
    "list"|"show"|"ls"|"-l"|"--list")
        __cs_list_cheatsheets
    ;;
    *)
        __cs_display_cheatsheet $1
    ;;
esac
