#!/bin/bash -e
#
# From the GitHub repository:
# https://github.com/openSUSE/doc-ci
#
# License: MIT
#
# Written by Thomas Schraitle

VERSION="v0.9.0"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[33;1m'
BOLD='\033[1m'
NC='\033[0m' # No Color

mkdir -p /root/.config/daps/
DCLIST=$(ls DC-*-all)
if [ -z "$DCLIST" ] ; then
    DCLIST=$(ls DC-*)
fi
for DCFILE in $DCLIST; do 
    echo -e "\n${YELLOW}${BOLD}Validating $DCFILE ... ${NC}\n" 
    daps -vv -d $DCFILE validate || exit 1 
    wait
done
