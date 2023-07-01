//usr/bin/env go run $0; exit $?
/* content/src/get-current-age/get_current_age.go
 * ============================================================================
 * Usage:
 *   $ SRCS=http://rgolubtsov.github.io/srcs; \
       curl  -sO ${SRCS}/get-current-age/get_current_age.go   && \
       chmod 700 get_current_age.go;   ./get_current_age.go;  echo $?
 * ============================================================================
 * This is a demo script. It has to be run as a Go script using the Go tool's
 * runtime facility. Tested and known to run exactly the same way on modern
 * versions of OpenBSD/amd64, Ubuntu Server LTS x86-64, Arch Linux
 * operating systems.
 *
 * The script contains a function that calculates the current age
 * based on the date of birth, given in args. It then simply returns
 * the age calculated - nothing special.
 * ============================================================================
 * Copyright (C) 2023 Radislav (Radicchio) Golubtsov
 *
 * (See the LICENSE file at the top of the source tree.)
 */

package main

import (
    "fmt"
    "time"
)

// Calculates the current age based on the date of birth.
func get_age(YY_OF_BIRTH int, MM_OF_BIRTH int, DD_OF_BIRTH int) int {
    year, month_, day := time.Now().Date()

    month := int(month_)

    age := year - YY_OF_BIRTH

    if (month < MM_OF_BIRTH) {
        age--
    } else if (month == MM_OF_BIRTH) {
        if (day < DD_OF_BIRTH) {
            age--
        }
    }

    return age
}

// The script entry point.
func main() {
    fmt.Println(get_age(1977, 6, 27)) // <== 1977-06-27.
}

// vim:set nu et ts=4 sw=4:
