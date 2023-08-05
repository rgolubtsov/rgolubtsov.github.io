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
% of Ubuntu Server LTS x86-64 and Arch Linux operating systems.
%
% The script contains a function that calculates the current age
% based on the date of birth, given in args. It then simply returns
% the age calculated - nothing special.
% =============================================================================
% Copyright (C) 2023 Radislav (Radicchio) Golubtsov
%
% (See the LICENSE file at the top of the source tree.)
%

%% @doc Calculates the current age based on the date of birth.
get_age(YY_OF_BIRTH, MM_OF_BIRTH, DD_OF_BIRTH) ->
    date  = 0,%Dates.today(),
    year  = 0,%Dates.year(date),
    month = 0,%Dates.month(date),
    day   = 0,%Dates.day(date),

    age = year - YY_OF_BIRTH,

    if (month < MM_OF_BIRTH) ->
        age = age - 1;
       (true) ->
        if (month =:= MM_OF_BIRTH) ->
            if (day < DD_OF_BIRTH) ->
                age = age - 1;
               (true) -> false
            end;
           (true) -> false
        end
    end.

%% @doc The script entry point.
main(_) ->
    io:put_chars(get_age(1977, 6, 27)). % <== 1977-06-27.

% vim:set nu et ts=4 sw=4:
