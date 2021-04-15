#!/usr/bin/env escript
% content/src/replace_txt_chunks.erl
% =============================================================================
% Usage:
% $ curl -sO http://rgolubtsov.github.io/srcs/replace_txt_chunks.erl && \
%   chmod 700                                 replace_txt_chunks.erl && \
%                                           ./replace_txt_chunks.erl; echo $?
% =============================================================================
% This is a demo script. It has to be run in the Erlang/OTP runtime
% environment. Tested and known to run exactly the same way on modern versions
% of OpenBSD/amd64, Ubuntu Server LTS x86-64, Arch Linux / Arch Linux 32
% operating systems.
%
% Create a function that will take a String value as the first parameter,
% a Number value as the second parameter, and a String value as the third one.
% The first parameter should be a sentence or a set of sentences,
% the second parameter should be a positional number of a letter in each word
% in the given sentence that should be replaced by the third parameter.
% That function should return the updated sentence.
% =============================================================================
% Copyright (C) 2018-2021 Radislav (Radicchio) Golubtsov
%
% (See the LICENSE file at the top of the source tree.)
%

% Helper constants.
-define(EMPTY_STRING,     "").
-define(SPACE,           " ").
-define(COMMA,           ",").
-define(POINT,           ".").
-define(NEW_LINE,       "\n").
-define(DBG_PREF,     "==> ").

%% @doc The replace function.
replace(Text, Pos, Subst) ->
    lists:foldl(fun(Word, Text_) ->
        Word_len = length(Word),
        Word_Pos = if (Pos - 1 < Word_len) -> string:substr(Word, Pos);
                      (true) -> ?EMPTY_STRING end,

%       io:put_chars(?DBG_PREF ++ Word ++ ?NEW_LINE),

        Text_ ++ if ((Pos - 1 < Word_len)
            and (Word_Pos =/= ?COMMA)
            and (Word_Pos =/= ?POINT)) ->

            Word_ = string:substr(Word, 1, Pos - 1) ++ Subst
                 ++ string:substr(Word,    Pos + 1),

%           io:put_chars(?DBG_PREF ++ Word_ ++ ?NEW_LINE),

            Word_;
           (true) ->
%           io:put_chars(?DBG_PREF ++ Word  ++ ?NEW_LINE),

            Word
        end ++ ?SPACE
    end, ?EMPTY_STRING, string:tokens(Text, ?SPACE)).

%% @doc The script entry point.
main(_) ->
    Text  = ?EMPTY_STRING
++ "A guard sequence is either a single guard or a series of guards, "
++ "separated by semicolons (';'). The guard sequence 'G1; G2; ...; Gn' "
++ "is true if at least one of the guards 'G1', 'G2', ..., 'Gn' "
++ "evaluates to 'true'."
++          ?EMPTY_STRING,

    Pos   = 3, % <== Can be set to either from 1 to infinity.
%   Subst = "callable entity",
%   Subst = "AAA",
%   Subst = "+-=",
    Subst = "|",

    io:put_chars(?DBG_PREF ++ integer_to_list(Pos) ++ ?NEW_LINE),
    io:put_chars(?DBG_PREF ++ Subst ++ ?NEW_LINE   ++ ?NEW_LINE),

    Text_ = replace(Text, Pos, Subst),

    io:put_chars(?NEW_LINE ++ ?DBG_PREF ++ Text    ++ ?NEW_LINE),
    io:put_chars(             ?DBG_PREF ++ Text_   ++ ?NEW_LINE).

% vim:set nu et ts=4 sw=4:
