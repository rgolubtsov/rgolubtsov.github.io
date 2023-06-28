#!/usr/bin/env bash
# content/src/get_current_age.sh
# =============================================================================
# Usage:
#   $ curl -sO http://rgolubtsov.github.io/srcs/get_current_age.sh && \
#     chmod 700                                 get_current_age.sh && \
#                                             ./get_current_age.sh; echo $?
# =============================================================================
# This is a demo script. It has to be run using the Bash 3.1+ shell.
# Tested and known to run exactly the same way on modern versions
# of Ubuntu Server LTS x86-64 and Arch Linux operating systems.
#
# The script contains a function that calculates the current age
# based on the date of birth, given in args. It then simply returns
# the age calculated - nothing special.
# =============================================================================
# Copyright (C) 2023 Radislav (Radicchio) Golubtsov
#
# (See the LICENSE file at the top of the source tree.)
#

# Calculates the current age based on the date of birth.
get_age() {
    YY_OF_BIRTH=$1; MM_OF_BIRTH=$2; DD_OF_BIRTH=$3

    year=`date  +%Y`
    month=`date +%m`
    day=`date   +%d`

    let "age = year - YY_OF_BIRTH"

    if [ ${month} -lt ${MM_OF_BIRTH} ]; then
        let age--
    elif [ ${month} -eq ${MM_OF_BIRTH} ]; then
        if [ ${day} -lt ${DD_OF_BIRTH} ]; then
            let age--
        fi
    fi

    return ${age}
}

get_age 1977 6 27; echo $? # <== 1977-06-27.

# vim:set nu et ts=4 sw=4:
