#!/usr/bin/env node
/*
 * content/dev/misc/dnsresolvd/js/dnsresolvd.js
 * ============================================================================
 * DNS Resolver Daemon. Version 0.1
 * ============================================================================
 * A Node.js-boosted daemon for performing DNS lookups.
 * ============================================================================
 * Copyright (C) 2017 Radislav (Radicchio) Golubtsov
 *
 * (See the LICENSE file at the top of the source tree.)
 */

"use strict";

var http = require("http");
var url  = require("url");
var dns  = require("dns");

/** The main and only class of the daemon. */
//var DnsResolvD = function() {
    /* Constant: The port number to run the daemon on. */
    var _PORT_NUMBER = 8765;

    /* HTTP header properties. */
    var _HTTP_200_OK      = 200;
    var _CONTENT_TYPE_KEY = "Content-Type";
    var _CONTENT_TYPE_VAL = "text/html; charset=UTF-8";

    /* Constant: The default hostname to look up to. */
    var _HOSTNAME = "archlinux.org";

    /* Helper constants. */
    var _NEW_LINE               = "\n";
    var _COLON_SPACE_SEP        = ": ";
    var _MSG_SERVER_STARTED_1   = "Server started on port ";
    var _MSG_SERVER_STARTED_2   = "=== Hit Ctrl+C to terminate it.";
    var _ERROR_PREFIX           = "Error";
    var _ERROR_COULD_NOT_LOOKUP = "Could not lookup hostname.";

    // Creating the server and serving the request.
    http.createServer(function(req, resp) {
        var query = url.parse(req.url, true).query;

        var hostname = query.h; // <== http://localhost:8765/?h=<hostname>

        if (!hostname) {
            hostname = _HOSTNAME;
        }

        // Performing DNS lookup for the given hostname.
        dns.lookup(hostname, function(e, addr, ver) {
            resp.writeHead(_HTTP_200_OK, {
                _CONTENT_TYPE_KEY : _CONTENT_TYPE_VAL
            });

            resp.write("<!DOCTYPE html>" + _NEW_LINE
+ "<html lang=\"en-US\" dir=\"ltr\">"    + _NEW_LINE + "<head>"                  + _NEW_LINE
+ "<meta http-equiv=\"Content-Type\"    content=\"text/html; charset=UTF-8\" />" + _NEW_LINE
+ "<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge,chrome=1\" />"         + _NEW_LINE
+ "<!-- No caching at all for:                                                                          -->"     + _NEW_LINE
+ "<meta http-equiv=\"Cache-Control\"   content=\"no-cache, no-store, must-revalidate\" /> <!-- * HTTP/1.1. -->" + _NEW_LINE
+ "<meta http-equiv=\"Expires\"         content=\"Thu, 01 Dec 1994 16:00:00 GMT\"       /> <!-- * Proxies.  -->" + _NEW_LINE
+ "<meta http-equiv=\"Pragma\"          content=\"no-cache\"                            /> <!-- * HTTP/1.0. -->" + _NEW_LINE
+ "<meta       name=\"viewport\"        content=\"width=device-width,initial-scale=1\" />"                       + _NEW_LINE
            + "<title>DNS Resolver Daemon (dnsresolvd)</title>"  + _NEW_LINE
            + "</head>" + _NEW_LINE + "<body id=\"dnsresolvd\">" + _NEW_LINE
            + "<p>"     +  hostname + " ==&gt; ");

            if (e) {
                resp.write(_ERROR_PREFIX + _COLON_SPACE_SEP
                         + _ERROR_COULD_NOT_LOOKUP);
            } else {
                resp.write(addr + " (IPv" + ver + ")");
            }

            resp.write("</p>" + _NEW_LINE
                  + "</body>" + _NEW_LINE
                  + "</html>" + _NEW_LINE);

            resp.end();
        });
    }).listen(_PORT_NUMBER);

    console.log(_MSG_SERVER_STARTED_1 + _PORT_NUMBER + _NEW_LINE
              + _MSG_SERVER_STARTED_2);
//};

//module.exports = exports = DnsResolvD;

// vim:set nu:et:ts=4:sw=4:
