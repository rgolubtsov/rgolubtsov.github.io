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
#include <syslog.h>

#include <microhttpd.h>

/* Helper constants. */
#define _EMPTY_STRING       ""
#define _ONE_SPACE_STRING  " "
#define _COLON_SPACE_SEP  ": "
#define _COMMA_SPACE_SEP  ", "
#define _NEW_LINE         "\n"

/* Common error messages. */
#define _ERR_PREFIX                    "Error"
#define _ERR_PORT_MUST_BE_INT          "%s: <port_number> must be "      \
                                       "an integer value."
#define _ERR_PORT_MUST_BE_GREATER_1024 "%s: <port_number> must be "      \
                                       "greater than 1024."
#define _ERR_CANNOT_START_SERVER       "%s: FATAL: Cannot start server " \
                                       "for an unknown reason. Exiting..."
#define _ERR_COULD_NOT_LOOKUP          "Could not lookup hostname."

/** Constant: Print this when there are no any args passed. */
#define _ERR_MUST_BE_THE_ONLY_ARG "%s: There must be exactly one arg " \
                                  "passed: %d args found"

/**
 * Constant: Print this usage info just after
 *           the <code>_ERR_MUST_BE_THE_ONLY_ARG</code> error message.
 */
#define _MSG_USAGE_TEMPLATE "Usage: %s <port_number>"

/* Common notification messages. */
#define _MSG_SERVER_STARTED_1 "Server started on port %lu"
#define _MSG_SERVER_STARTED_2 "=== Hit Ctrl+C to terminate it."

/* Daemon name, version, and copyright banners. */
#define _DMN_NAME        "DNS Resolver Daemon (dnsresolvd)"
#define _DMN_DESCRIPTION "Performs DNS lookups for the given hostname " \
                         "passed in an HTTP request"
#define _DMN_VERSION_S__ "Version"
#define _DMN_VERSION     "0.1"
#define _DMN_COPYRIGHT__ "Copyright (C) 2017"
#define _DMN_AUTHOR      "Radislav Golubtsov <ragolubtsov@my.com>"

#endif /* __DNSRESOLVD_H */

/* vim:set nu:et:ts=4:sw=4: */
