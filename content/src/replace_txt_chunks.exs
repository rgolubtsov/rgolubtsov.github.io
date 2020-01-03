#!/usr/bin/env elixir
# content/src/replace_txt_chunks.exs
# =============================================================================
# Usage:
# $ curl -sO http://rgolubtsov.github.io/srcs/replace_txt_chunks.exs && \
#   chmod 700                                 replace_txt_chunks.exs && \
#                                           ./replace_txt_chunks.exs; echo $?
# =============================================================================
# This is a demo script. It has to be run in the Elixir runtime environment.
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
# Copyright (C) 2018-2020 Radislav (Radicchio) Golubtsov
#
# (See the LICENSE file at the top of the source tree.)
#

defmodule R do
    @moduledoc "The replace function and helpers' container."

    # Helper constants.
    def _EMPTY_STRING, do:     ""
    def _SPACE,        do:    " "
    def _COMMA,        do:    ","
    def _POINT,        do:    "."
    def _NEW_LINE,     do:   "\n"
    def _DBG_PREF,     do: "==> "

    @doc """
    The replace function.
    """
    def replace(text, pos, subst) do
        List.foldl(String.split(text), R._EMPTY_STRING, fn(word, text_) ->
            word_len = String.length(word)

#           IO.puts(R._DBG_PREF <> word)

            text_ <> if ((pos - 1 < word_len)
                and (String.slice(word, pos - 1 .. -1) !== R._COMMA)
                and (String.slice(word, pos - 1 .. -1) !== R._POINT)) do

                word_ = String.replace(word, String.slice(word, pos - 1 .. -1),
                                 subst) <>   String.slice(word, pos     .. -1)

#               IO.puts(R._DBG_PREF <> word_)

                word_
            else
#               IO.puts(R._DBG_PREF <> word )

                word
            end <> R._SPACE
        end)
    end
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

IO.puts(R._DBG_PREF <> to_string(pos)      )
IO.puts(R._DBG_PREF <> subst <> R._NEW_LINE)

text_ = R.replace(text, pos, subst)

IO.puts(R._NEW_LINE <> R._DBG_PREF <> text )
IO.puts(               R._DBG_PREF <> text_)

# vim:set nu et ts=4 sw=4:
