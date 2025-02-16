#!/usr/bin/env v
/* content/src/get-current-age/get_current_age.vsh
 * ============================================================================
 * Usage:
 *   $ SRCS=https://rgolubtsov.github.io/srcs; \
       curl -sOk ${SRCS}/get-current-age/get_current_age.vsh   && \
       chmod 700 get_current_age.vsh;  ./get_current_age.vsh;  echo $?
 * ============================================================================
 * This is a demo script. It has to be run as a V script using the V tool's
 * runtime facility. Tested and known to run exactly the same way on modern
 * versions of Ubuntu Server LTS x86-64 and Arch Linux operating systems.
 *
 * The script contains a function that calculates the current age
 * based on the date of birth, given in args. It then simply returns
 * the age calculated - nothing special.
 * ============================================================================
 * Copyright (C) 2025 Radislav (Radicchio) Golubtsov
 *
 * (See the LICENSE file at the top of the source tree.)
 */

import time

// Calculates the current age based on the date of birth.
fn get_age(_YY_OF_BIRTH int, _MM_OF_BIRTH int, _DD_OF_BIRTH int) int {
    time_ := time.now()
    year  := time_.year
    month := time_.month
    day   := time_.day

    mut age := year - _YY_OF_BIRTH

    if month < _MM_OF_BIRTH {
        age--
    } else if month == _MM_OF_BIRTH {
        if day < _DD_OF_BIRTH {
            age--
        }
    }

    return age
}

println(get_age(1977, 6, 27)) // <== 1977-06-27.

// vim:set nu et ts=4 sw=4:
