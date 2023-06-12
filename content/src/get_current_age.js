#!/usr/bin/env node
/* content/src/get_current_age.js
 * ============================================================================
 * Usage:
 *   $ curl -sO http://rgolubtsov.github.io/srcs/get_current_age.js && \
       chmod 700                                 get_current_age.js && \
                                               ./get_current_age.js; echo $?
 * ============================================================================
 * This is a demo script. It has to be run in the Node.js runtime environment.
 * Tested and known to run exactly the same way on modern versions
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

"use strict";

// === 1977-06-27 ===
var YY_OF_BIRTH = 1977;
var MM_OF_BIRTH = 6;
var DD_OF_BIRTH = 27;

// Calculates the current age based on the date of birth.
var get_age   = function() {
    var date  = new Date();
    var year  = date.getFullYear();
    var month = date.getMonth();
    var day   = date.getDate();

    var age = year - YY_OF_BIRTH;

    month++;

    if (month < MM_OF_BIRTH) {
        age--;
    } else if (month === MM_OF_BIRTH) {
        if (day < DD_OF_BIRTH) {
            age--;
        }
    }

    return age;
};

console.log(get_age());

// vim:set nu et ts=4 sw=4:
