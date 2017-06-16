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

var http = require("http");
var url  = require("url");
var dns  = require("dns");

var __DNSRESOLVD_H = require("./dnsresolvd.h");

var aux = new __DNSRESOLVD_H();

/** The daemon entry point. */
var main = function() {
    var ret = aux._EXIT_SUCCESS;

    // Creating the server and serving the request.
    http.createServer(function(req, resp) {
        var query = url.parse(req.url, true).query;

        var hostname = query.h; // <== http://localhost:8765/?h=<hostname>

        if (!hostname) {
            hostname = aux._DEF_HOSTNAME;
        }

        // Performing DNS lookup for the given hostname.
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
    }).listen(aux._DEF_PORT);

    return ret;
};

var ret = main();

if (ret === aux._EXIT_SUCCESS) {
    console.log(aux._MSG_SERVER_STARTED_1 + aux._DEF_PORT + aux._NEW_LINE
              + aux._MSG_SERVER_STARTED_2);
}

// vim:set nu:et:ts=4:sw=4:
