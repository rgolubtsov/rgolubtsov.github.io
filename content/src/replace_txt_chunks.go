//usr/bin/env go run $0; exit $?
/* content/src/replace_txt_chunks.go
 * ============================================================================
 * Usage:
 * $ curl -sO http://rgolubtsov.github.io/srcs/replace_txt_chunks.go && \
     chmod 700                                 replace_txt_chunks.go && \
                                             ./replace_txt_chunks.go; echo $?
 * ============================================================================
 * This is a demo script. It has to be run as a Go script using the Go tool's
 * runtime facility. Tested and known to run exactly the same way
 * on modern versions of OpenBSD/amd64, Ubuntu Server LTS x86-64, Arch Linux /
 * Arch Linux 32 operating systems.
 *
 * Create a function that will take a String value as the first parameter,
 * a Number value as the second parameter, and a String value as the third one.
 * The first parameter should be a sentence or a set of sentences,
 * the second parameter should be a positional number of a letter in each word
 * in the given sentence that should be replaced by the third parameter.
 * That function should return the updated sentence.
 * ============================================================================
 * Copyright (C) 2018-2021 Radislav (Radicchio) Golubtsov
 *
 * (See the LICENSE file at the top of the source tree.)
 */

package main

import (
    "fmt"
    "strings"
)

// Helper constants.
const (
    EMPTY_STRING string =     ""
    SPACE        string =    " "
    COMMA        string =    ","
    POINT        string =    "."
    NEW_LINE     string =   "\n"
    DBG_PREF     string = "==> "
)

// The replace function.
func replace(text string, pos int, subst string) string {
    text_        := EMPTY_STRING
    text__       := EMPTY_STRING
    text_ary     := strings.Split(text, SPACE)
    text_ary_len := len(text_ary)

    for i := 0; i < text_ary_len; i++ {
        text_ary_i_len := len(text_ary[i])

//      fmt.Printf(DBG_PREF + text_ary[i] + NEW_LINE)

        if ((pos - 1 < text_ary_i_len)       &&
            (text_ary[i][pos - 1:] != COMMA) &&
            (text_ary[i][pos - 1:] != POINT)) {

            text__ = strings.Replace(text_ary[i],
                                     text_ary[i][pos - 1:], subst, -1) +
                                     text_ary[i][pos    :]

//          fmt.Printf(DBG_PREF + text__      + NEW_LINE)

            text_ += text__
        } else {
//          fmt.Printf(DBG_PREF + text_ary[i] + NEW_LINE)

            text_ += text_ary[i]
        }

        text_ += SPACE
    }

    return text_
}

// The script entry point.
func main() {
    text  := EMPTY_STRING                                              +
"A guard sequence is either a single guard or a series of guards, "    +
"separated by semicolons (';'). The guard sequence 'G1; G2; ...; Gn' " +
"is true if at least one of the guards 'G1', 'G2', ..., 'Gn' "         +
"evaluates to 'true'."                                                 +
             EMPTY_STRING

    const pos int = 3 // <== Can be set to either from 1 to infinity.
//  subst := "callable entity"
//  subst := "AAA"
//  subst := "+-="
    subst := "|"

    fmt.Printf(DBG_PREF + "%d"  + NEW_LINE,  pos     )
    fmt.Printf(DBG_PREF + subst + NEW_LINE + NEW_LINE)

    text_ := replace(text, pos, subst)

    fmt.Printf(NEW_LINE + DBG_PREF + text  + NEW_LINE)
    fmt.Printf(           DBG_PREF + text_ + NEW_LINE)
}

// vim:set nu et ts=4 sw=4:
