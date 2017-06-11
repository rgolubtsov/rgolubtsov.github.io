/*
 * content/dev/misc/dnsresolvd/c/dnsresolvd.h
 * ============================================================================
 * DNS Resolver Daemon (dnsresolvd). Version 0.1
 * ============================================================================
 * A GNU libmicrohttpd-boosted daemon for performing DNS lookups.
 * ============================================================================
 * Copyright (C) 2017 Radislav (Radicchio) Golubtsov
 *
 * (See the LICENSE file at the top of the source tree.)
 */

#ifndef __DNSRESOLVD_H
#define __DNSRESOLVD_H

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

/* Helper constants. */
#define _EMPTY_STRING       ""
#define _ONE_SPACE_STRING  " "
#define _COLON_SPACE_SEP  ": "
#define _COMMA_SPACE_SEP  ", "
#define _NEW_LINE         "\n"

/* Common error messages. */
#define _ERROR_PREFIX                    "Error"
#define _ERROR_PORT_MUST_BE_INT          "<port number> must be "          \
                                         "an integer value."
#define _ERROR_PORT_MUST_BE_GREATER_1024 "<port number> must be "          \
                                         "greater than 1024."
#define _FATAL_CANNOT_START_SERVER       "FATAL: Cannot start server for " \
                                         "an unknown reason. Exiting..."
#define _ERROR_COULD_NOT_LOOKUP          "Could not lookup hostname."

/* Common notification messages. */
#define _MSG_SERVER_STARTED_1 "Server started on port %i"
#define _MSG_SERVER_STARTED_2 "=== Hit Ctrl+C to terminate it."

/* Daemon name, version, and copyright banners. */
#define _APP_NAME        "DNS Resolver Daemon (dnsresolvd)"
#define _APP_DESCRIPTION "Performs DNS lookups for the given hostname " \
                         "passed in an HTTP request"
#define _APP_VERSION_S__ "Version"
#define _APP_VERSION     "0.1"
#define _APP_COPYRIGHT__ "Copyright (C) 2017"
#define _APP_AUTHOR      "Radislav Golubtsov <ragolubtsov@my.com>"

#endif /* __DNSRESOLVD_H */

/* vim:set nu:et:ts=4:sw=4: */
