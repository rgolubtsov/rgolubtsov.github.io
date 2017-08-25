#!/usr/bin/env lua5.3
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
local http = require("http")
local url  = require("url")
local dns  = require("dns")

-- vim:set nu:et:ts=4:sw=4:
