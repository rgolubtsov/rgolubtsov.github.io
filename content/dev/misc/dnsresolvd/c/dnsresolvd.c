/*
 * content/dev/misc/dnsresolvd/c/dnsresolvd.c
 * ============================================================================
 * DNS Resolver Daemon (dnsresolvd). Version 0.1
 * ============================================================================
 * A GNU libmicrohttpd-boosted daemon for performing DNS lookups.
 * ============================================================================
 * Copyright (C) 2017 Radislav (Radicchio) Golubtsov
 *
 * (See the LICENSE file at the top of the source tree.)
 */

#include "dnsresolvd.h"

/* Helper function. Makes final buffer cleanups, closes streams, etc. */
void _cleanups_fixate() {
    /* Closing the system logger. */
    closelog();
}

/* Helper function. Draws a horizontal separator banner. */
void _separator_draw(const char *banner_text) {
    unsigned char i = strlen(banner_text);

    do { putchar('='); i--; } while (i); puts(_EMPTY_STRING);
}

/* The daemon entry point. */
int main(int argc, char *const *argv) {
    int ret = EXIT_SUCCESS;

    char *daemon_name = argv[0];
    unsigned long port_number;

    /* Opening the system logger. */
    openlog(NULL, LOG_CONS | LOG_PID, LOG_DAEMON);

    _separator_draw(_DMN_DESCRIPTION);

    printf(_DMN_NAME        _COMMA_SPACE_SEP                         \
           _DMN_VERSION_S__ _ONE_SPACE_STRING _DMN_VERSION _NEW_LINE \
           _DMN_DESCRIPTION                                _NEW_LINE \
           _DMN_COPYRIGHT__ _ONE_SPACE_STRING _DMN_AUTHOR  _NEW_LINE);

    _separator_draw(_DMN_DESCRIPTION);

    /* Checking for args presence. */
    if (argc != 2) {
        ret = EXIT_FAILURE;

        fprintf(stderr, _ERR_MUST_BE_THE_ONLY_ARG _NEW_LINE _NEW_LINE,
                         daemon_name, (argc - 1));

        syslog(LOG_ERR, _ERR_MUST_BE_THE_ONLY_ARG _NEW_LINE _NEW_LINE,
                         daemon_name, (argc - 1));

        fprintf(stderr, _MSG_USAGE_TEMPLATE _NEW_LINE _NEW_LINE, daemon_name);

        _cleanups_fixate();

        return ret;
    }

    port_number = strtoul(argv[1], NULL, 0);

    if (port_number == 0L) {
        ret = EXIT_FAILURE;

        fprintf(stderr, _ERR_PORT_MUST_BE_INT _NEW_LINE _NEW_LINE,
                         daemon_name);

        syslog(LOG_ERR, _ERR_PORT_MUST_BE_INT _NEW_LINE _NEW_LINE,
                         daemon_name);

        _cleanups_fixate();

        return ret;
    }

    if (port_number <= 1024L) {
        ret = EXIT_FAILURE;

        fprintf(stderr, _ERR_PORT_MUST_BE_GREATER_1024 _NEW_LINE _NEW_LINE,
                         daemon_name);

        syslog(LOG_ERR, _ERR_PORT_MUST_BE_GREATER_1024 _NEW_LINE _NEW_LINE,
                         daemon_name);

        _cleanups_fixate();

        return ret;
    }

    /* Making final cleanups. */
    _cleanups_fixate();

    return ret;
}

/* vim:set nu:et:ts=4:sw=4: */
