#!/usr/bin/env perl
# content/src/replace_txt_chunks.pl
# =============================================================================
# Usage:
#   $ curl -O http://rgolubtsov.github.io/srcs/replace_txt_chunks.pl && \
#     chmod 700                                replace_txt_chunks.pl && \
#                                            ./replace_txt_chunks.pl; echo $?
# =============================================================================
# This is a demo script. It has to be run in the Perl 5 (5.10+) runtime
# environment. Tested and known to run exactly the same way on modern versions
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
# Copyright (C) 2018 Radislav (Radicchio) Golubtsov
#
# (See the LICENSE file at the top of the source tree.)
#

use strict;
use warnings;
use utf8;
use v5.10;

# Helper constants.
use constant {
    SPACE    => " ",
    COMMA    => ",",
    POINT    => ".",
    NEW_LINE => "\n",
    DBG_PREF => "==> ",
};

# The replace function.
sub replace {
#    text=$1; pos=$2; subst=$3

#    text_ary=(${text})
#    text_ary_ind=${!text_ary[@]}

#    for i in ${text_ary_ind}; do
#        text_ary_i_len=${#text_ary[${i}]}

#       echo ${DBG_PREF}${text_ary[${i}]}

#        if [ $((pos - 1)) -lt ${text_ary_i_len}\
#            -a "${text_ary[${i}]:$((pos - 1))}" != ${COMMA}\
#            -a "${text_ary[${i}]:$((pos - 1))}" != ${POINT} ]; then

#            text__=${text_ary[${i}]/${text_ary[${i}]:$((pos - 1))}/${subst}}\
#${text_ary[${i}]:${pos}}

#           echo ${DBG_PREF}${text__}

#            text_=${text_}${text__}
#        else
#           echo ${DBG_PREF}${text_ary[${i}]}

#            text_=${text_}${text_ary[${i}]}
#        fi

#        text_=${text_}${SPACE}
#    done
    return 0;
}

use constant {
    text  => "\
A guard sequence is either a single guard or a series of guards, \
separated by semicolons (';'). The guard sequence 'G1; G2; ...; Gn' \
is true if at least one of the guards 'G1', 'G2', ..., 'Gn' \
evaluates to 'true'.\
",

    POS   => 3, # <== Can be set to either from 1 to infinity.
#    subst => "callable entity",
#    subst => "AAA",
#    subst => "+-=",
    subst => "|",
};

say(DBG_PREF . POS              );
say(DBG_PREF . subst . NEW_LINE );

my $text_ = replace(text . POS . subst);

say(NEW_LINE . DBG_PREF .  text );
say(           DBG_PREF . $text_);

# vim:set nu et ts=4 sw=4:
