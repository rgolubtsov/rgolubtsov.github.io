#!/usr/bin/env luvit
--[[ content/dev/misc/dnsresolvd/lua/dnsresolvd.lua
 * ============================================================================
 * DNS Resolver Daemon (dnsresolvd). Version 0.1
 * ============================================================================
 * A Luvit (Lua)-boosted daemon for performing DNS lookups.
 * ============================================================================
 * Copyright (C) 2017 Radislav (Radicchio) Golubtsov
 *
 * (See the LICENSE file at the top of the source tree.)
--]]

local path = require("path")
--local http = require("http")
--local url  = require("url")
--local dns  = require("dns")

local aux = require("dnsresolvd_h")

-- Helper function. Draws a horizontal separator banner.
local _separator_draw = function(banner_text)
    local i = banner_text:len()

    while (i > 0) do
        process.stdout:write('='); i = i - 1
    end

    print()
end

-- The daemon entry point.
local main = function(argc, argv)
    local ret = aux._EXIT_SUCCESS

    local daemon_name = path.basename(argv[1])
    local port_number = tonumber(argv[2], 10)

    _separator_draw(aux._DMN_DESCRIPTION)

    print(aux._DMN_NAME         .. aux._COMMA_SPACE_SEP .. aux._DMN_VERSION_S__
       .. aux._ONE_SPACE_STRING .. aux._DMN_VERSION      .. aux._NEW_LINE
       .. aux._DMN_DESCRIPTION                           .. aux._NEW_LINE
       .. aux._DMN_COPYRIGHT__  .. aux._ONE_SPACE_STRING .. aux._DMN_AUTHOR)

    _separator_draw(aux._DMN_DESCRIPTION)

    return ret
end

local argv = process.argv
local argc = #argv

-- Starting up the daemon.
local ret = main(argc, argv)

process.exitCode = ret

-- vim:set nu:et:ts=4:sw=4:
