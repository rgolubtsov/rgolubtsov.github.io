#!/usr/bin/env elixir
# content/src/get-current-age/get_current_age.exs
# =============================================================================
# Usage:
#   $ SRCS=http://rgolubtsov.github.io/srcs; \
#     curl  -sO ${SRCS}/get-current-age/get_current_age.exs   && \
#     chmod 700 get_current_age.exs;  ./get_current_age.exs;  echo $?
# =============================================================================
# This is a demo script. It has to be run in the Elixir runtime environment.
# Tested and known to run exactly the same way on modern versions
# of OpenBSD/amd64, Ubuntu Server LTS x86-64, Arch Linux operating systems.
#
# The script contains a function that calculates the current age
# based on the date of birth, given in args. It then simply returns
# the age calculated - nothing special.
# =============================================================================
# Copyright (C) 2023-2025 Radislav (Radicchio) Golubtsov
#
# (See the LICENSE file at the top of the source tree.)
#

defmodule Age do
    @doc """
    Calculates the current age based on the date of birth.
    """
    def get_age(yy_OF_BIRTH, mm_OF_BIRTH, dd_OF_BIRTH) do
        date  = elem(:calendar.local_time(), 0)
        year  = elem(date, 0)
        month = elem(date, 1)
        day   = elem(date, 2)

        age = year - yy_OF_BIRTH

        if (month < mm_OF_BIRTH) do
            age - 1
        else
            if (month === mm_OF_BIRTH) do
                if (day < dd_OF_BIRTH) do
                    age - 1
                else
                    age
                end
            else
                age
            end
        end
    end
end

IO.puts(Age.get_age(1977, 6, 27)) # <== 1977-06-27.

# vim:set nu et ts=4 sw=4:
