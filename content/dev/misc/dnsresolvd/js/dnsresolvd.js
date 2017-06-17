#!/usr/bin/env node
/* content/dev/misc/dnsresolvd/js/dnsresolvd.js
 * ============================================================================
 * DNS Resolver Daemon (dnsresolvd). Version 0.1
 * ============================================================================
 * A Node.js-boosted daemon for performing DNS lookups.
 * ============================================================================
 * Copyright (C) 2017 Radislav (Radicchio) Golubtsov
 *
 * (See the LICENSE file at the top of the source tree.)
 */

"use strict";

var path = require("path");
var http = require("http");
var url  = require("url");
var dns  = require("dns");

var __DNSRESOLVD_H = require("./dnsresolvd.h");

var aux = new __DNSRESOLVD_H();

var dns_lookup = function(port_number, _ret) {
    var ret = _ret;

    http.createServer(function(req, resp) {
        var query = url.parse(req.url, true).query;

        var hostname = query.h; // <== http://localhost:8765/?h=<hostname>

        if (!hostname) {
            hostname = aux._DEF_HOSTNAME;
        }

        dns.lookup(hostname, function(e, addr, ver) {
            resp.writeHead(200, {
                "Content-Type" : aux._HDR_CONTENT_TYPE
            });

            resp.write("<!DOCTYPE html>" + aux._NEW_LINE
+ "<html lang=\"en-US\" dir=\"ltr\">"    + aux._NEW_LINE + "<head>"              + aux._NEW_LINE
+ "<meta http-equiv=\"Content-Type\"    content=\"text/html; charset=UTF-8\" />" + aux._NEW_LINE
+ "<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge,chrome=1\" />"         + aux._NEW_LINE
+ "<!-- No caching at all for:                                                                          -->"     + aux._NEW_LINE
+ "<meta http-equiv=\"Cache-Control\"   content=\"no-cache, no-store, must-revalidate\" /> <!-- * HTTP/1.1. -->" + aux._NEW_LINE
+ "<meta http-equiv=\"Expires\"         content=\"Thu, 01 Dec 1994 16:00:00 GMT\"       /> <!-- * Proxies.  -->" + aux._NEW_LINE
+ "<meta http-equiv=\"Pragma\"          content=\"no-cache\"                            /> <!-- * HTTP/1.0. -->" + aux._NEW_LINE
+ "<meta       name=\"viewport\"        content=\"width=device-width,initial-scale=1\" />"                       + aux._NEW_LINE
            + "<title>DNS Resolver Daemon (dnsresolvd)</title>"      + aux._NEW_LINE
            + "</head>" + aux._NEW_LINE + "<body id=\"dnsresolvd\">" + aux._NEW_LINE
            + "<p>"     +      hostname + " ==&gt; ");

            if (e) {
                resp.write(aux._ERR_PREFIX + aux._COLON_SPACE_SEP
                         + aux._ERR_COULD_NOT_LOOKUP);
            } else {
                resp.write(addr + " (IPv" + ver + ")");
            }

            resp.write("</p>" + aux._NEW_LINE
                  + "</body>" + aux._NEW_LINE
                  + "</html>" + aux._NEW_LINE);

            resp.end();
        });
    }).listen(port_number);

    return ret;
};

/* Helper function. Draws a horizontal separator banner. */
var _separator_draw = function(banner_text) {
    var i = banner_text.length;

    do { process.stdout.write('='); i--; } while (i); console.log();
};

/** The daemon entry point. */
var main = function(argc, argv) {
    var ret = aux._EXIT_SUCCESS;

    var daemon_name = path.basename(argv[1]);
    var port_number = parseInt(argv[2], 10);

    _separator_draw(aux._DMN_DESCRIPTION);

    console.log(aux._DMN_NAME + aux._COMMA_SPACE_SEP  + aux._DMN_VERSION_S__
      + aux._ONE_SPACE_STRING + aux._DMN_VERSION      + aux._NEW_LINE
      + aux._DMN_DESCRIPTION                          + aux._NEW_LINE
      + aux._DMN_COPYRIGHT__  + aux._ONE_SPACE_STRING + aux._DMN_AUTHOR);

    _separator_draw(aux._DMN_DESCRIPTION);

    // Checking for args presence.
    if (argc !== 3) {
        ret = aux._EXIT_FAILURE;

        console.error(daemon_name + aux._ERR_MUST_BE_THE_ONLY_ARG_1
                     + (argc - 2) + aux._ERR_MUST_BE_THE_ONLY_ARG_2
                     + aux._NEW_LINE);

        console.error(aux._MSG_USAGE_TEMPLATE_1 + daemon_name
                    + aux._MSG_USAGE_TEMPLATE_2 + aux._NEW_LINE);

        return ret;
    }

    // Checking for port correctness.
    if (isNaN(port_number) || (port_number < aux._MIN_PORT)
                           || (port_number > aux._MAX_PORT)) {

        ret = aux._EXIT_FAILURE;

        console.error(daemon_name + aux._ERR_PORT_MUST_BE_POSITIVE_INT
                    + aux._NEW_LINE);

        console.error(aux._MSG_USAGE_TEMPLATE_1 + daemon_name
                    + aux._MSG_USAGE_TEMPLATE_2 + aux._NEW_LINE);

        return ret;
    }

    ret = dns_lookup(port_number, ret);

    console.log(aux._MSG_SERVER_STARTED_1 + port_number + aux._NEW_LINE
              + aux._MSG_SERVER_STARTED_2);

    return ret;
};

var argv = process.argv;
var argc = argv.length;

// Starting up the daemon.
var ret = main(argc, argv);

process.exitCode = ret;

// vim:set nu:et:ts=4:sw=4:
