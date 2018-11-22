#!/usr/bin/env lua5.2
--[[ content/src/replace_txt_chunks.lua
 * ============================================================================
 * Usage:
 *   $ curl -O http://rgolubtsov.github.io/srcs/replace_txt_chunks.lua && \
       chmod 700                                replace_txt_chunks.lua && \
                                              ./replace_txt_chunks.lua; echo $?
 * ============================================================================
 * This is a demo script. It has to be run in the Lua 5.2 runtime environment.
 * Tested and known to run exactly the same way on modern versions
 * of OpenBSD/amd64, Ubuntu Server LTS x86-64, Arch Linux / Arch Linux 32
 * operating systems.
 *
 * Create a function that will take a String value as the first parameter,
 * a Number value as the second parameter, and a String value as the third one.
 * The first parameter should be a sentence or a set of sentences,
 * the second parameter should be a positional number of a letter in each word
 * in the given sentence that should be replaced by the third parameter.
 * That function should return the updated sentence.
 * ============================================================================
 * Copyright (C) 2018 Radislav (Radicchio) Golubtsov
 *
 * (See the LICENSE file at the top of the source tree.)
--]]

-- Helper constants.
local EMPTY_STRING =     ""
local SPACE        =    " "
local COMMA        =    ","
local POINT        =    "."
local NEW_LINE     =   "\n"
local DBG_PREF     = "==> "
local SPACES       =  "%S+"

-- The replace function.
function replace(text, pos, subst)
    local text_        = EMPTY_STRING
    local text__       = EMPTY_STRING
    local text_ary     = {}
    for i in text:gmatch(SPACES) do table.insert(text_ary, i) end
    local text_ary_len = #text_ary

    for i = 1, text_ary_len do
        local text_ary_i_len = #text_ary[i]

--      print(DBG_PREF .. text_ary[i])

        if ((pos <= text_ary_i_len)
            and (text_ary[i]:sub(pos) ~= COMMA)
            and (text_ary[i]:sub(pos) ~= POINT)) then

            text__ = text_ary[i]:sub(1, pos - 1) .. subst
                  .. text_ary[i]:sub(   pos + 1)

--          print(DBG_PREF .. text__     )

            text_ = text_  .. text__
        else
--          print(DBG_PREF .. text_ary[i])

            text_ = text_  .. text_ary[i]
        end

        text_ = text_ .. SPACE
    end

    return text_
end

local text  = EMPTY_STRING
.. "A guard sequence is either a single guard or a series of guards, "
.. "separated by semicolons (';'). The guard sequence 'G1; G2; ...; Gn' "
.. "is true if at least one of the guards 'G1', 'G2', ..., 'Gn' "
.. "evaluates to 'true'."
..            EMPTY_STRING

local pos   = 3 -- <== Can be set to either from 1 to infinity.
--local subst = "callable entity"
--local subst = "AAA"
--local subst = "+-="
local subst = "|"

print(DBG_PREF .. pos              )
print(DBG_PREF .. subst .. NEW_LINE)

local text_ = replace(text, pos, subst)

print(NEW_LINE .. DBG_PREF .. text )
print(            DBG_PREF .. text_)

-- vim:set nu et ts=4 sw=4:
