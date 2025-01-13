#!/usr/bin/tcc -run
/* content/src/get-current-age/get_current_age.c
 * ============================================================================
 * Usage:
 *   $ SRCS=http://rgolubtsov.github.io/srcs; \
       curl  -sO ${SRCS}/get-current-age/get_current_age.c   && \
       chmod 700 get_current_age.c;    ./get_current_age.c;  echo $?
 * ============================================================================
 * This is a demo script. It has to be run as a C script using TCC
 * (Fabrice Bellard's Tiny C Compiler). Tested and known to run
 * exactly the same way on modern versions of Ubuntu Server LTS x86-64
 * and Arch Linux operating systems.
 *
 * The script contains a function that calculates the current age
 * based on the date of birth, given in args. It then simply returns
 * the age calculated - nothing special.
 * ============================================================================
 * Copyright (C) 2023-2025 Radislav (Radicchio) Golubtsov
 *
 * (See the LICENSE file at the top of the source tree.)
 */

#include <stdio.h>
#include <time.h>

// Calculates the current age based on the date of birth.
int get_age(const int YY_OF_BIRTH,
            const int MM_OF_BIRTH,
            const int DD_OF_BIRTH) {

    time_t date_ = time(NULL); struct tm *date = localtime(&date_);
    int    year  = date->tm_year + 1900;
    int    month = date->tm_mon  + 1;
    int    day   = date->tm_mday;

    int age = year - YY_OF_BIRTH;

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
int main() {
    printf("%d\n", get_age(1977, 6, 27)); // <== 1977-06-27.
}

// vim:set nu et ts=4 sw=4:
