#!/usr/bin/env v
/* content/src/replace-txt-chunks/replace_txt_chunks.vsh
 * ============================================================================
 * Usage:
 *   $ SRCS=https://rgolubtsov.github.io/srcs; \
       curl -sOk ${SRCS}/replace-txt-chunks/replace_txt_chunks.vsh   && \
       chmod 700 replace_txt_chunks.vsh;  ./replace_txt_chunks.vsh;  echo $?
 * ============================================================================
 * This is a demo script. It has to be run as a V script using the V tool's
 * runtime facility. Tested and known to run exactly the same way on modern
 * versions of OpenBSD/amd64, Ubuntu Server LTS x86-64, and Arch Linux
 * operating systems.
 *
 * Create a function that will take a String value as the first parameter,
 * a Number value as the second parameter, and a String value as the third one.
 * The first parameter should be a sentence or a set of sentences,
 * the second parameter should be a positional number of a letter in each word
 * in the given sentence that should be replaced by the third parameter.
 * That function should return the updated sentence.
 * ============================================================================
 * Copyright (C) 2025-2026 Radislav (Radicchio) Golubtsov
 *
 * (See the LICENSE file at the top of the source tree.)
 */

// Helper constants.
const empty_string =     ""
const space        =    " "
const comma        =    ","
const point        =    "."
const new_line     =   "\n"
const dbg_pref     = "==> "

// The replace function.
fn replace(text string, pos int, subst string) string {
    mut text_        := empty_string
    mut text__       := empty_string
        text_ary     := text.split(space)
        text_ary_len := text_ary.len

    for i := 0; i < text_ary_len; i++ {
        text_ary_i_len := text_ary[i].len

//      println(dbg_pref + text_ary[i])

        if (pos - 1 < text_ary_i_len)
            && (text_ary[i].substr(pos - 1, text_ary_i_len) != comma)
            && (text_ary[i].substr(pos - 1, text_ary_i_len) != point) {

            text__ = text_ary[i]
            .replace(text_ary[i].substr(pos - 1, text_ary_i_len), subst)
            +        text_ary[i].substr(pos,     text_ary_i_len)

//          println(dbg_pref + text__)

            text_ += text__
        } else {
//          println(dbg_pref + text_ary[i])

            text_ += text_ary[i]
        }

        text_ += space
    }

    return text_
}

const text  = empty_string
+ "A guard sequence is either a single guard or a series of guards, "
+ "separated by semicolons (';'). The guard sequence 'G1; G2; ...; Gn' "
+ "is true if at least one of the guards 'G1', 'G2', ..., 'Gn' "
+ "evaluates to 'true'."
+             empty_string

const pos   = 3 // <== Can be set to either from 1 to infinity.
//const subst = "callable entity"
//const subst = "AAA"
//const subst = "+-="
const subst = "|"

println(dbg_pref + "${pos}"        )
println(dbg_pref + subst + new_line)

text_ := replace(text, pos, subst)

println(new_line + dbg_pref + text )
println(           dbg_pref + text_)

// vim:set nu et ts=4 sw=4:
