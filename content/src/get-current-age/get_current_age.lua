#!/usr/bin/env lua5.4
--[[ content/src/get-current-age/get_current_age.lua
 * ============================================================================
 * Usage:
 *   $ SRCS=https://rgolubtsov.github.io/srcs; \
       curl -sOk ${SRCS}/get-current-age/get_current_age.lua   && \
       chmod 700 get_current_age.lua;  ./get_current_age.lua;  echo $?
 * ============================================================================
 * This is a demo script. It has to be run in the Lua 5.4 runtime environment.
 * Tested and known to run exactly the same way on modern versions of
 * OpenBSD/amd64, Ubuntu Server LTS x86-64, and Arch Linux operating systems.
 * Note: On OpenBSD one may need to symlink
 *       `/usr/local/bin/lua54` to `/usr/local/bin/lua5.4` first,
 *       e.g. `$ sudo ln -sfn /usr/local/bin/lua54 /usr/local/bin/lua5.4`
 *       since it is named a little bit differently than on Linux.
 *
 * The script contains a function that calculates the current age
 * based on the date of birth, given in args. It then simply returns
 * the age calculated - nothing special.
 * ============================================================================
 * Copyright (C) 2023-2026 Radislav (Radicchio) Golubtsov
 *
 * (See the LICENSE file at the top of the source tree.)
--]]

-- Calculates the current age based on the date of birth.
function get_age(YY_OF_BIRTH, MM_OF_BIRTH, DD_OF_BIRTH)
    local year  = os.date("%Y")
    local month = os.date("%m")
    local day   = os.date("%d")

    local age = year - YY_OF_BIRTH

    if (tonumber(month) < MM_OF_BIRTH) then
        age = age - 1
    elseif (tonumber(month) == MM_OF_BIRTH) then
        if (tonumber(day  ) <  DD_OF_BIRTH) then
            age = age - 1
        end
    end

    return age
end

print(get_age(1977, 6, 27)) -- <== 1977-06-27.

-- vim:set nu et ts=4 sw=4:
