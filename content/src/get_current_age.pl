#!/usr/bin/env perl
# content/src/get_current_age.pl
# =============================================================================
# Usage:
#   $ curl -sO http://rgolubtsov.github.io/srcs/get_current_age.pl && \
#       chmod 700                                 get_current_age.pl && \
#                                               ./get_current_age.pl; echo $?
# =============================================================================
# This is a demo script. It has to be run in the Perl 5 (5.10+) runtime
# environment. Tested and known to run exactly the same way on modern versions
# of Ubuntu Server LTS x86-64 and Arch Linux operating systems.
#
# The script contains a function that calculates the current age
# based on the date of birth, given in args. It then simply returns
# the age calculated - nothing special.
# =============================================================================
# Copyright (C) 2023 Radislav (Radicchio) Golubtsov
#
# (See the LICENSE file at the top of the source tree.)
#

use strict;
use warnings;
use utf8;
use v5.10;

# Calculates the current age based on the date of birth.
sub get_age {
    my $YY_OF_BIRTH = shift();
    my $MM_OF_BIRTH = shift();
    my $DD_OF_BIRTH = shift();

    my $date  = 0;#new Date();
    my $year  = 0;#$date.getFullYear();
    my $month = 0;#$date.getMonth();
    my $day   = 0;#$date.getDate();

    my $age = $year - $YY_OF_BIRTH;

    $month++;

    if ($month < $MM_OF_BIRTH) {
        $age--;
    } elsif ($month == $MM_OF_BIRTH) {
        if ($day < $DD_OF_BIRTH) {
            $age--;
        }
    }

    return $age;
}

say(get_age(1977, 6, 27)); # <== 1977-06-27.

# vim:set nu et ts=4 sw=4:
