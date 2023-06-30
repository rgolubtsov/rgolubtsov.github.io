#!/usr/bin/env perl
# content/src/replace-txt-chunks/replace_txt_chunks.pl
# =============================================================================
# Usage:
#   $ SRCS=http://rgolubtsov.github.io/srcs; \
#     curl  -sO ${SRCS}/replace-txt-chunks/replace_txt_chunks.pl   && \
#     chmod 700 replace_txt_chunks.pl;   ./replace_txt_chunks.pl;  echo $?
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
# Copyright (C) 2018-2023 Radislav (Radicchio) Golubtsov
#
# (See the LICENSE file at the top of the source tree.)
#

use strict;
use warnings;
use utf8;
use v5.10;

# Helper constants.
use constant {
    EMPTY_STRING =>     "",
    SPACE        =>    " ",
    COMMA        =>    ",",
    POINT        =>    ".",
    NEW_LINE     =>   "\n",
    DBG_PREF     => "==> ",
    SPACES       =>  qr/ /,
};

# The replace function.
sub replace {
    my $text  = shift();
    my $pos_  = shift();
    my $subst = shift();

    my $text_;
    my $text__;
    my @text_ary     = split(SPACES, $text);
    my $text_ary_len = scalar(@text_ary);

    for (my $i = 0; $i < $text_ary_len; $i++) {
        my $text_ary_i_len = length($text_ary[$i]);

#       say(DBG_PREF . $text_ary[$i]);

        if (($pos_ - 1 < $text_ary_i_len)
            && (substr($text_ary[$i], $pos_ - 1) ne COMMA)
            && (substr($text_ary[$i], $pos_ - 1) ne POINT)) {

            $text__ = substr($text_ary[$i], 0, $pos_ - 1) . $subst
                    . substr($text_ary[$i],    $pos_    );

#           say(DBG_PREF . $text__      );

            $text_ .= $text__;
        } else {
#           say(DBG_PREF . $text_ary[$i]);

            $text_ .= $text_ary[$i];
        }

        $text_ .= SPACE;
    }

    return $text_;
}

use constant {
    text  => EMPTY_STRING
. "A guard sequence is either a single guard or a series of guards, "
. "separated by semicolons (';'). The guard sequence 'G1; G2; ...; Gn' "
. "is true if at least one of the guards 'G1', 'G2', ..., 'Gn' "
. "evaluates to 'true'."
.            EMPTY_STRING,

    pos_  => 3, # <== Can be set to either from 1 to infinity.
#   subst => "callable entity",
#   subst => "AAA",
#   subst => "+-=",
    subst => "|",
};

say(DBG_PREF . pos_             );
say(DBG_PREF . subst . NEW_LINE );

my $text_ = replace(text, pos_, subst);

say(NEW_LINE . DBG_PREF .  text );
say(           DBG_PREF . $text_);

# vim:set nu et ts=4 sw=4:
