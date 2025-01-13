#!/usr/bin/env node
/* content/src/replace-txt-chunks/replace_txt_chunks.js
 * ============================================================================
 * Usage:
 *   $ SRCS=http://rgolubtsov.github.io/srcs; \
       curl  -sO ${SRCS}/replace-txt-chunks/replace_txt_chunks.js   && \
       chmod 700 replace_txt_chunks.js;   ./replace_txt_chunks.js;  echo $?
 * ============================================================================
 * This is a demo script. It has to be run in the Node.js runtime environment.
 * Tested and known to run exactly the same way on modern versions
 * of OpenBSD/amd64, Ubuntu Server LTS x86-64, Arch Linux / Arch Linux 32
 * operating systems.
 *
 * Create a function that will take a String value as the first parameter,
 * a Number value as the second parameter, and a String value as the third one.
 * The first parameter should be a sentence or a set of sentences,
 * the second parameter should be a positional number of a letter in each word
 * in the given sentence that should be replaced by the third parameter.
 * That function should return the updated sentence.
 * ============================================================================
 * Copyright (C) 2018-2025 Radislav (Radicchio) Golubtsov
 *
 * (See the LICENSE file at the top of the source tree.)
 */

"use strict";

// Helper constants.
var EMPTY_STRING =     "";
var SPACE        =    " ";
var COMMA        =    ",";
var POINT        =    ".";
var NEW_LINE     =   "\n";
var DBG_PREF     = "==> ";

// The replace function.
function replace(text, pos, subst) {
    var text_        = EMPTY_STRING;
    var text__       = EMPTY_STRING;
    var text_ary     = text.split(SPACE);
    var text_ary_len = text_ary.length;

    for (var i = 0; i < text_ary_len; i++) {
        var text_ary_i_len = text_ary[i].length;

//      console.log(DBG_PREF + text_ary[i]);

        if ((pos - 1 < text_ary_i_len)
            && (text_ary[i].substring(pos - 1) !== COMMA)
            && (text_ary[i].substring(pos - 1) !== POINT)) {

            text__ = text_ary[i]
            .replace(text_ary[i].substring(pos - 1), subst)
            +        text_ary[i].substring(pos    );

//          console.log(DBG_PREF + text__     );

            text_ += text__;
        } else {
//          console.log(DBG_PREF + text_ary[i]);

            text_ += text_ary[i];
        }

        text_ += SPACE;
    }

    return text_;
}

var text  = "\
A guard sequence is either a single guard or a series of guards, \
separated by semicolons (';'). The guard sequence 'G1; G2; ...; Gn' \
is true if at least one of the guards 'G1', 'G2', ..., 'Gn' \
evaluates to 'true'.\
";

var pos   = 3; // <== Can be set to either from 1 to infinity.
//var subst = "callable entity";
//var subst = "AAA";
//var subst = "+-=";
var subst = "|";

console.log(DBG_PREF + pos             );
console.log(DBG_PREF + subst + NEW_LINE);

var text_ = replace(text, pos, subst);

console.log(NEW_LINE + DBG_PREF + text );
console.log(           DBG_PREF + text_);

// vim:set nu et ts=4 sw=4:
