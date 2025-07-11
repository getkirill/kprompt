#!/usr/bin/env zsh

function kpmod_pwd {
    print -n "%~"
}

function kpmod_user {
    print -n "%n"
}

function kpmod_machine {
    print -n "%M"
}

function kpmod_superuser {
    print -n "%(!.$([[ -n $2 ]] && print -n "%K{$2}" || print -n "%k")$([[ -n $1 ]] && print -n "%F{$1}" || print -n "%f")#.$)"
    kp_color_peek
}

_KP_COLOR_STACK=()
function kp_color_peek() {
    print -n "${_KP_COLOR_STACK[-1]:-"%f%k"}"
}
function kp_color_push() {
    FG=$([[ -n $1 ]] && print -n "%F{$1}" || print -n "%f")
    [[ $FG == "default" ]] && FG="%f"
    BG=$([[ -n $2 ]] && print -n "%K{$2}" || print -n "%k")
    [[ $BG == "default" ]] && BG="%k"
    _KP_COLOR_STACK+=("$FG$BG")
    kp_color_peek
}
function kp_color_pop() {
    _KP_COLOR_STACK=(${_KP_COLOR_STACK[1,-2]})
    kp_color_peek
}

function kp_color() {
    kp_color_push $1 $2
    "$@[3,-1]"
    kp_color_pop
}

# Default_prompt
function _kprompt_bashlike() {
    kp_color_push green
    kpmod_user
    print -n @
    kpmod_machine
    kp_color_pop
    print -n :
    kp_color blue default kpmod_pwd
    kpmod_superuser
    print -n ' '
}

KPROMPT=_kprompt_bashlike

function kprompt_reconfigure() {
    PROMPT=$($KPROMPT)
}
kprompt_reconfigure
function kprompt() {
    KPROMPT=${1:-_kprompt_bashlike}
    kprompt_reconfigure
}