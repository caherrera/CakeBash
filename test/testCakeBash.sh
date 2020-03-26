#!/bin/bash
DIR="$(cd "$(dirname $(realpath ${BASH_SOURCE[0]}))" && pwd)"

source $DIR/../lib/cakebash.sh


color=
quiet=
while [ "$1" != "" ]; do
  case $1 in
  --color) color="yes" ;;
  -q|--quiet) quiet="1";;
  esac
  shift
done



pecho "Showing simple message with echo"
title "Showing title message"
info "Showing info message"
warning "Showing warning message"
error "Showing error message"

dd "Key" "Value"
dd "Key" "Description" "Value"

comm "This format is for commands like this"


do_run "uptime"

do_cat $DIR/../docs/lorem.txt