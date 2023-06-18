#!/usr/bin/env python3
# content/src/get_current_age.py
# =============================================================================
# Usage:
#   $ curl -sO http://rgolubtsov.github.io/srcs/get_current_age.py && \
#     chmod 700                                 get_current_age.py && \
#                                             ./get_current_age.py; echo $?
# =============================================================================
# This is a demo script. It has to be run in the Python 3 runtime environment.
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

def get_age(YY_OF_BIRTH, MM_OF_BIRTH, DD_OF_BIRTH):
    """Calculates the current age based on the date of birth."""

    date  = 0#localtime
    year  = 0#date->year
    month = 0#date->mon
    day   = 0#date->mday

    age = year - YY_OF_BIRTH

    if (month < MM_OF_BIRTH):
        age -= 1
    elif (month == MM_OF_BIRTH):
        if (day < DD_OF_BIRTH):
            age -= 1

    return age

if (__name__ == "__main__"):
    print(get_age(1977, 6, 27)) # <== 1977-06-27.

# vim:set nu et ts=4 sw=4:
