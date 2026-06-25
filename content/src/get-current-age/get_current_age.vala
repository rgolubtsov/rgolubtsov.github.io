#!/usr/bin/env vala
/* content/src/get-current-age/get_current_age.vala
 * ============================================================================
 * Usage:
 *   $ SRCS=https://rgolubtsov.github.io/srcs; \
       curl -sOk ${SRCS}/get-current-age/get_current_age.vala   && \
       chmod 700 get_current_age.vala; ./get_current_age.vala;  echo $?
 * ============================================================================
 * This is a demo script. It has to be run as a Vala script using the Vala
 * tool's runtime facility. Tested and known to run exactly the same way
 * on modern versions of Ubuntu Server LTS x86-64 and Arch Linux
 * operating systems.
 *
 * The script contains a method that calculates the current age
 * based on the date of birth, given in args. It then simply returns
 * the age calculated - nothing special.
 * ============================================================================
 * Copyright (C) 2026 Radislav (Radicchio) Golubtsov
 *
 * (See the LICENSE file at the top of the source tree.)
 */

const string NEW_LINE = "\n";

// Calculates the current age based on the date of birth.
int get_age(int YY_OF_BIRTH, int MM_OF_BIRTH, int DD_OF_BIRTH) {
    var date  = new DateTime.now_local();
    var year  = date.get_year();
    var month = date.get_month();
    var day   = date.get_day_of_month();

    var age = year - YY_OF_BIRTH;

    if (month < MM_OF_BIRTH) {
        age--;
    } else if (month == MM_OF_BIRTH) {
        if (day < DD_OF_BIRTH) {
            age--;
        }
    }

    return age;
}

// The script entry point.
void main() {
    print(get_age(1977, 6, 27).to_string() + NEW_LINE); // <== 1977-06-27.
}

// vim:set nu et ts=4 sw=4:
