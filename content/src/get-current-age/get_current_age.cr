#!/usr/bin/env crystal
# content/src/get-current-age/get_current_age.cr
# =============================================================================
# Usage:
#   $ SRCS=https://rgolubtsov.github.io/srcs; \
#     curl -sOk ${SRCS}/get-current-age/get_current_age.cr   && \
#     chmod 700 get_current_age.cr;   ./get_current_age.cr;  echo $?
# =============================================================================
# This is a demo script. It has to be run as a Crystal script using the Crystal
# tool's runtime facility. Tested and known to run exactly the same way
# on modern versions of OpenBSD/amd64, Ubuntu Server LTS x86-64, and Arch Linux
# operating systems.
#
# The script contains a function that calculates the current age
# based on the date of birth, given in args. It then simply returns
# the age calculated - nothing special.
# =============================================================================
# Copyright (C) 2025 Radislav (Radicchio) Golubtsov
#
# (See the LICENSE file at the top of the source tree.)
#

# Calculates the current age based on the date of birth.
def get_age(yy_of_birth, mm_of_birth, dd_of_birth)
    date  = Time.local().date()
    year  = date[0]
    month = date[1]
    day   = date[2]

    age = year - yy_of_birth

    if (month < mm_of_birth)
        age -= 1
    elsif (month == mm_of_birth)
       if (day   <  dd_of_birth)
           age -= 1
       end
    end
end

puts(get_age(1977, 6, 27)) # <== 1977-06-27.

# vim:set nu et ts=4 sw=4:
