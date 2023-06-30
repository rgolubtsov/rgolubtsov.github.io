#!/usr/bin/env julia
#= content/src/get-current-age/get_current_age.jl
 * ============================================================================
 * Usage:
 *   $ SRCS=http://rgolubtsov.github.io/srcs; \
       curl  -sO ${SRCS}/get-current-age/get_current_age.jl   && \
       chmod 700 get_current_age.jl;   ./get_current_age.jl;  echo $?
 * ============================================================================
 * This is a demo script. It has to be run as a **script** in the Julia runtime
 * environment. Tested and known to run exactly the same way on modern versions
 * of Ubuntu Server LTS x86-64 and Arch Linux operating systems.
 *
 * The script contains a function that calculates the current age
 * based on the date of birth, given in args. It then simply returns
 * the age calculated - nothing special.
 * ============================================================================
 * Copyright (C) 2023 Radislav (Radicchio) Golubtsov
 *
 * (See the LICENSE file at the top of the source tree.)
 =#

import Dates

"Calculates the current age based on the date of birth."
function get_age(YY_OF_BIRTH, MM_OF_BIRTH, DD_OF_BIRTH)
    date  = Dates.today()
    year  = Dates.year(date)
    month = Dates.month(date)
    day   = Dates.day(date)

    age = year - YY_OF_BIRTH

    if (month < MM_OF_BIRTH)
        age -= 1
    elseif (month == MM_OF_BIRTH)
        if (day < DD_OF_BIRTH)
            age -= 1
        end
    end

    return age
end

println(get_age(1977, 6, 27)) # <== 1977-06-27.

# vim:set nu et ts=4 sw=4:
