#!/usr/bin/env crystal
# content/src/replace-txt-chunks/replace_txt_chunks.cr
# =============================================================================
# Usage:
#   $ SRCS=https://rgolubtsov.github.io/srcs; \
#     curl -sOk ${SRCS}/replace-txt-chunks/replace_txt_chunks.cr   && \
#     chmod 700 replace_txt_chunks.cr;   ./replace_txt_chunks.cr;  echo $?
# =============================================================================
# This is a demo script. It has to be run as a Crystal script using the Crystal
# tool's runtime facility. Tested and known to run exactly the same way
# on modern versions of OpenBSD/amd64, Ubuntu Server LTS x86-64, and Arch Linux
# operating systems.
#
# Create a function that will take a String value as the first parameter,
# a Number value as the second parameter, and a String value as the third one.
# The first parameter should be a sentence or a set of sentences,
# the second parameter should be a positional number of a letter in each word
# in the given sentence that should be replaced by the third parameter.
# That function should return the updated sentence.
# =============================================================================
# Copyright (C) 2025 Radislav (Radicchio) Golubtsov
#
# (See the LICENSE file at the top of the source tree.)
#

# Helper constants.
EMPTY_STRING =     ""
COMMA        =    ","
POINT        =    "."
SPACE        =    " "
NEW_LINE     =   "\n"
DBG_PREF     = "==> "

# The replace function.
def replace(text, pos, subst)
    text_        = EMPTY_STRING
    text__       = EMPTY_STRING
    text_ary     = text.split()
    text_ary_len = text_ary.size()

    (0 .. (text_ary_len - 1)).each() do |i|
        text_ary_i_len = text_ary[i].size()

#       puts("#{DBG_PREF}#{text_ary[i]}")

        if ((pos - 1 < text_ary_i_len) &&
            (text_ary[i][(pos - 1) .. -1] != COMMA) &&
            (text_ary[i][(pos - 1) .. -1] != POINT))

            text__ = text_ary[i]
                .sub(text_ary[i][(pos - 1) .. -1], subst) +
                     text_ary[i][ pos      .. -1]

#           puts("#{DBG_PREF}#{text__     }")

            text_ += text__
        else
#           puts("#{DBG_PREF}#{text_ary[i]}")

            text_ += text_ary[i]
        end

        text_ += SPACE
    end

    return text_
end

text  = "\
A guard sequence is either a single guard or a series of guards, \
separated by semicolons (';'). The guard sequence 'G1; G2; ...; Gn' \
is true if at least one of the guards 'G1', 'G2', ..., 'Gn' \
evaluates to 'true'.\
"

pos   = 3 # <== Can be set to either from 1 to infinity.
#subst = "callable entity"
#subst = "AAA"
#subst = "+-="
subst = "|"

puts("#{DBG_PREF}#{pos  }"           )
puts("#{DBG_PREF}#{subst}#{NEW_LINE}")

text_ = replace(text, pos, subst)

puts("#{NEW_LINE}#{DBG_PREF}#{text }")
puts(           "#{DBG_PREF}#{text_}")

# vim:set nu et ts=4 sw=4:
