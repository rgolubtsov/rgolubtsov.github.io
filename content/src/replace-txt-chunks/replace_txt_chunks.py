#!/usr/bin/env python3
# content/src/replace-txt-chunks/replace_txt_chunks.py
# =============================================================================
# Usage:
#   $ SRCS=http://rgolubtsov.github.io/srcs; \
#     curl  -sO ${SRCS}/replace-txt-chunks/replace_txt_chunks.py   && \
#     chmod 700 replace_txt_chunks.py;   ./replace_txt_chunks.py;  echo $?
# =============================================================================
# This is a demo script. It has to be run in the Python 3 runtime environment.
# Tested and known to run exactly the same way on modern versions
# of OpenBSD/amd64, Ubuntu Server LTS x86-64, Arch Linux / Arch Linux 32
# operating systems.
#
# Create a function that will take a String value as the first parameter,
# a Number value as the second parameter, and a String value as the third one.
# The first parameter should be a sentence or a set of sentences,
# the second parameter should be a positional number of a letter in each word
# in the given sentence that should be replaced by the third parameter.
# That function should return the updated sentence.
# =============================================================================
# Copyright (C) 2018-2024 Radislav (Radicchio) Golubtsov
#
# (See the LICENSE file at the top of the source tree.)
#

# Helper constants.
EMPTY_STRING =     ""
SPACE        =    " "
COMMA        =    ","
POINT        =    "."
NEW_LINE     =   "\n"
DBG_PREF     = "==> "

def replace(text, pos, subst):
    """The replace function."""

    text_        = EMPTY_STRING
    text_ary     = text.split(SPACE)
    text_ary_len = len(text_ary)

    for i in range(0, text_ary_len):
        text_ary_i_len = len(text_ary[i])

#       print(DBG_PREF + text_ary[i])

        if ((pos - 1 < text_ary_i_len)
            and (text_ary[i][pos - 1:] != COMMA)
            and (text_ary[i][pos - 1:] != POINT)):

            text__ = (text_ary[i]
            .replace (text_ary[i][pos - 1:], subst)
            +         text_ary[i][pos    :])

#           print(DBG_PREF + text__     )

            text_ += text__
        else:
#           print(DBG_PREF + text_ary[i])

            text_ += text_ary[i]

        text_ += SPACE

    return text_

if (__name__ == "__main__"):
    text  = "\
A guard sequence is either a single guard or a series of guards, \
separated by semicolons (';'). The guard sequence 'G1; G2; ...; Gn' \
is true if at least one of the guards 'G1', 'G2', ..., 'Gn' \
evaluates to 'true'.\
"

    pos   = 3 # <== Can be set to either from 1 to infinity.
#   subst = "callable entity"
#   subst = "AAA"
#   subst = "+-="
    subst = "|"

    print(DBG_PREF + str(pos)        )
    print(DBG_PREF + subst + NEW_LINE)

    text_ = replace(text, pos, subst)

    print(NEW_LINE + DBG_PREF + text )
    print(           DBG_PREF + text_)

# vim:set nu et ts=4 sw=4:
