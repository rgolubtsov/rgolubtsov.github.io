#!/usr/bin/env escript
% content/src/get-current-age/get_current_age.erl
% =============================================================================
% Usage:
%   $ SRCS=http://rgolubtsov.github.io/srcs; \
%     curl  -sO ${SRCS}/get-current-age/get_current_age.erl   && \
%     chmod 700 get_current_age.erl;  ./get_current_age.erl;  echo $?
% =============================================================================
% This is a demo script. It has to be run in the Erlang/OTP runtime
% environment. Tested and known to run exactly the same way on modern versions
% of OpenBSD/amd64, Ubuntu Server LTS x86-64, Arch Linux operating systems.
%
% The script contains a function that calculates the current age
% based on the date of birth, given in args. It then simply returns
% the age calculated - nothing special.
% =============================================================================
% Copyright (C) 2023-2024 Radislav (Radicchio) Golubtsov
%
% (See the LICENSE file at the top of the source tree.)
%

%% @doc Calculates the current age based on the date of birth.
get_age(YY_OF_BIRTH, MM_OF_BIRTH, DD_OF_BIRTH) ->
    Date  = element(1, calendar:local_time()),
    Year  = element(1, Date),
    Month = element(2, Date),
    Day   = element(3, Date),

    Age = Year - YY_OF_BIRTH,

    if (Month < MM_OF_BIRTH) ->
        Age - 1;
       (true) ->
        if (Month =:= MM_OF_BIRTH) ->
            if (Day < DD_OF_BIRTH) ->
                Age - 1;
               (true) -> Age
            end;
           (true) -> Age
        end
    end.

%% @doc The script entry point.
main(_) ->
    io:put_chars(integer_to_list(get_age(1977, 6, 27))), % <== 1977-06-27.
    io:nl().

% vim:set nu et ts=4 sw=4:
