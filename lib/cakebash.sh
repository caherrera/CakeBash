#!/bin/bash

pecho() {
  [ "$quiet" == "" ] && echo "$@"
}

pprintf() {
  [ "$quiet" == "" ] && printf "%s" "$@"
}

dd() {
  local t="$1"
  if [ $# -eq 2 ]; then
    local v="$2"
    local p=""
  else
    local v="$3"
    local p="$2"
  fi
  ddout=$(printf "%-20s: %-15s %s \n" "$t" "$v" "$p")
  out "" $ddout
}

do_log() {
  if [ "$log_file" != "" ]; then
    echo "$@" >>$log_file
  fi
}

out() {
  local p="$1"
  local d=$(date '+%FT%T')
  shift
  if [ "$quiet" == "" ]; then

    nc='\033[0m'
    if [ "$color" == "yes" ]; then
      printf "$p"
      pecho "[$d] $@"
      printf "$nc"
      #      printf "\n"
    else

      pecho "[$d] $@"
    fi
  fi
  do_log "[$d] $@"
}

do_cat() {
  if [ "$quiet" == "" ]; then
    local p='\033[40;38;5;255m'
    nc='\033[0m'
    if [ "$color" == "yes" ]; then
      printf "$p"
      comm "cat $1"
      cat "$1"
      printf "$nc"
      #      printf "\n"
    else
      pecho "$@"
    fi
  fi
}

title() {
  local p='\033[1;33m'
  out $p $DEFAULT_PREFIX_TITLE "$@"

}

comm() {
  local p='\033[40m'
  out $p $DEFAULT_PREFIX_COMM "$@"

}

info() {
  local p='\033[1;34m'
  out $p $DEFAULT_PREFIX_INFO "$@"

}
warning() {
  local p='\033[1;91m'
  out $p $DEFAULT_PREFIX_WARNING "$@"

}

echoe() {
  local p="\033[0;31m"
  out $p $DEFAULT_PREFIX_ERROR "$@"
  
}

error() {
  echoe "$@"
}

do_run() {
  comm "$@"
  local p='\033[40m'
  [ "$color" != "" ] && printf "$p"
  if [ "$dry" == "" ]; then
    if [ "$quiet" == "" ]; then
      $@
    else
      $@ >/dev/null
    fi
  local nc='\033[0m'
  [ "$color" != "" ] && printf "$nc"
  fi
}