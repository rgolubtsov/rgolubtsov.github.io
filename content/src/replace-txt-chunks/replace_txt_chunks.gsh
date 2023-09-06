#!/usr/bin/env groovy
/* content/src/replace-txt-chunks/replace_txt_chunks.gsh
 * ============================================================================
 * Usage:
 *   $ SRCS=http://rgolubtsov.github.io/srcs; \
       curl  -sO ${SRCS}/replace-txt-chunks/replace_txt_chunks.gsh   && \
       chmod 700 replace_txt_chunks.gsh;  ./replace_txt_chunks.gsh 2>&1 \
     | sed '/OPTIONS/d'; echo $?
 * ============================================================================
 * This is a demo script. It has to be run in the Groovy (JVM) runtime
 * environment. Tested and known to run exactly the same way on modern versions
 * of Ubuntu Server LTS x86-64, Arch Linux / Arch Linux 32 operating systems.
 *
 * Create a function that will take a String value as the first parameter,
 * a Number value as the second parameter, and a String value as the third one.
 * The first parameter should be a sentence or a set of sentences,
 * the second parameter should be a positional number of a letter in each word
 * in the given sentence that should be replaced by the third parameter.
 * That function should return the updated sentence.
 * ============================================================================
 * Copyright (C) 2018-2023 Radislav (Radicchio) Golubtsov
 *
 * (See the LICENSE file at the top of the source tree.)
 */

// Helper constants.
      EMPTY_STRING =     ""
      SPACE        =    " "
      COMMA        =    ","
      POINT        =    "."
      DBG_PREF     = "==> "
final NEW_LINE     =   "\n"

// The replace function.
def replace(text, pos, subst) {
    def text_        = EMPTY_STRING
    def text__       = EMPTY_STRING
    def text_ary     = text.split(SPACE)
    def text_ary_len = text_ary.size()

    for (i in 0 .. (text_ary_len - 1)) {
        def text_ary_i_len = text_ary[i].size()

//      println("$DBG_PREF${text_ary[i]}")

        if ((pos - 1 < text_ary_i_len)
            && (text_ary[i].substring(pos - 1) != COMMA)
            && (text_ary[i].substring(pos - 1) != POINT)) {

            text__ = text_ary[i]
            .replace(text_ary[i].substring(pos - 1), subst) +
                     text_ary[i].substring(pos    )

//          println("$DBG_PREF$text__"       )

            text_ += text__
        } else {
//          println("$DBG_PREF${text_ary[i]}")

            text_ += text_ary[i]
        }

        text_ += SPACE
    }

    return text_
}

final text  = "\
A guard sequence is either a single guard or a series of guards, \
separated by semicolons (';'). The guard sequence 'G1; G2; ...; Gn' \
is true if at least one of the guards 'G1', 'G2', ..., 'Gn' \
evaluates to 'true'.\
"

final pos   = 3 // <== Can be set to either from 1 to infinity.
//final subst = "callable entity"
//final subst = "AAA"
//final subst = "+-="
final subst = "|"

println("$DBG_PREF$pos"           )
println("$DBG_PREF$subst$NEW_LINE")

def text_ = replace(text, pos, subst)

println("$NEW_LINE$DBG_PREF$text" )
println(         "$DBG_PREF$text_")

// vim:set nu et ts=4 sw=4:
