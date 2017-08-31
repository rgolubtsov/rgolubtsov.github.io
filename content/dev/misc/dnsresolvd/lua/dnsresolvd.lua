#!/usr/bin/env lua
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

--local path = require("path")
--local http = require("http")
--local url  = require("url")
--local dns  = require("dns")

local __dh = require("dnsresolvd_h")

-- The daemon entry point.
function main(argc, argv)
    local ret = __dh._EXIT_SUCCESS

    local daemon_name = ""--path.basename(argv[1])
    local port_number = tonumber(argv, 10)--tonumber(argv[2], 10)

    print("ret: " .. ret)

    return ret
end

local argv = ""--process.argv
local argc = argv.length

-- Starting up the daemon.
local ret = main(argc, argv)

--process.exitCode = ret

-- vim:set nu:et:ts=4:sw=4:
