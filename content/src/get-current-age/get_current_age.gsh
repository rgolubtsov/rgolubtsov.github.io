#!/usr/bin/env groovy
/* content/src/get-current-age/get_current_age.gsh
 * ============================================================================
 * Usage:
 *   $ SRCS=http://rgolubtsov.github.io/srcs; \
       curl  -sO ${SRCS}/get-current-age/get_current_age.gsh   && \
       chmod 700 get_current_age.gsh;  ./get_current_age.gsh;  echo $?
 * ============================================================================
 * This is a demo script. It has to be run in the Groovy (JVM) runtime
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
 */

import java.time.LocalDate

// Calculates the current age based on the date of birth.
def get_age(YY_OF_BIRTH, MM_OF_BIRTH, DD_OF_BIRTH) {
    def date  = LocalDate.now()
    def year  = date.getYear()
    def month = date.getMonthValue()
    def day   = date.getDayOfMonth()

    def age = year - YY_OF_BIRTH

    if (month < MM_OF_BIRTH) {
        age--
    } else if (month == MM_OF_BIRTH) {
        if (day < DD_OF_BIRTH) {
            age--
        }
    }

    return age
}

println(get_age(1977, 6, 27)) // <== 1977-06-27.

// vim:set nu et ts=4 sw=4:
