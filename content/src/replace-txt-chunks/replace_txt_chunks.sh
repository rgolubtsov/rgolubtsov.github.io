#!/usr/bin/env bash
# content/src/replace-txt-chunks/replace_txt_chunks.sh
# =============================================================================
# Usage:
#   $ SRCS=http://rgolubtsov.github.io/srcs; \
#     curl  -sO ${SRCS}/replace-txt-chunks/replace_txt_chunks.sh   && \
#     chmod 700 replace_txt_chunks.sh;   ./replace_txt_chunks.sh;  echo $?
# =============================================================================
# This is a demo script. It has to be run using the Bash 3.1+ shell.
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
# Copyright (C) 2018-2025 Radislav (Radicchio) Golubtsov
#
# (See the LICENSE file at the top of the source tree.)
#

# Helper constants.
declare -r SPACE=" "
declare -r COMMA=","
declare -r POINT="."
declare -r NEW_LINE="\n"
declare -r DBG_PREF="==> "

# The replace function.
replace() {
    text=$1; pos=$2; subst=$3

    text_ary=(${text})
    text_ary_ind=${!text_ary[@]}

    for i in ${text_ary_ind}; do
        text_ary_i_len=${#text_ary[${i}]}

#       echo ${DBG_PREF}${text_ary[${i}]}

        if [ $((pos - 1)) -lt ${text_ary_i_len}\
            -a "${text_ary[${i}]:$((pos - 1))}" != ${COMMA}\
            -a "${text_ary[${i}]:$((pos - 1))}" != ${POINT} ]; then

            text__=${text_ary[${i}]/${text_ary[${i}]:$((pos - 1))}/${subst}}\
${text_ary[${i}]:${pos}}

#           echo ${DBG_PREF}${text__}

            text_=${text_}${text__}
        else
#           echo ${DBG_PREF}${text_ary[${i}]}

            text_=${text_}${text_ary[${i}]}
        fi

        text_=${text_}${SPACE}
    done
}

declare -r TEXT="\
A guard sequence is either a single guard or a series of guards, \
separated by semicolons (';'). The guard sequence 'G1; G2; ...; Gn' \
is true if at least one of the guards 'G1', 'G2', ..., 'Gn' \
evaluates to 'true'.\
"

declare -r POS=3 # <== Can be set to either from 1 to infinity.
#declare -r SUBST="callable entity"
#declare -r SUBST="AAA"
#declare -r SUBST="+-="
declare -r SUBST="|"

echo -e ${DBG_PREF}${POS}
echo -e ${DBG_PREF}${SUBST}${NEW_LINE}

replace "${TEXT}" ${POS} "${SUBST}"

echo -e ${NEW_LINE}${DBG_PREF}${TEXT}
echo -e            ${DBG_PREF}${text_}

# vim:set nu et ts=4 sw=4:
