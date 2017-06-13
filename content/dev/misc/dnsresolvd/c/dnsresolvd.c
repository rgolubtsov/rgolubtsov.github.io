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

/* Main callback. Actually serving the request here. */
int _request_handler(       void            *cls,
                     struct MHD_Connection  *connection,
                     const  char            *url,
                     const  char            *method,
                     const  char            *version,
                     const  char            *upload_data,
                            size_t          *upload_data_size,
                            void           **con_cls) {

    int ret = EXIT_SUCCESS;

    /* TODO: Implement serving the request. */

    return ret;
}

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
    unsigned short port_number;

    struct MHD_Daemon *daemon;

    int c; /* <== Needs this for Ctrl+C hitting check only. */

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

    port_number = atoi(argv[1]);

    /* Checking for port correctness. */
    if ((port_number < 1024) || (port_number > 49151)) {
        ret = EXIT_FAILURE;

        fprintf(stderr, _ERR_PORT_MUST_BE_POSITIVE_INT _NEW_LINE _NEW_LINE,
                         daemon_name);

        syslog(LOG_ERR, _ERR_PORT_MUST_BE_POSITIVE_INT _NEW_LINE _NEW_LINE,
                         daemon_name);

        fprintf(stderr, _MSG_USAGE_TEMPLATE _NEW_LINE _NEW_LINE, daemon_name);

        _cleanups_fixate();

        return ret;
    }

    /* Creating, configuring, and starting the server. */
    daemon = MHD_start_daemon(MHD_USE_INTERNAL_POLLING_THREAD,
                              port_number, /*    ^^^^^^^    */
                              NULL,        /*  Thread pool  */
                              NULL,
                              &_request_handler,
                              NULL,
    /* Thread pool >>>>>>> */ MHD_OPTION_THREAD_POOL_SIZE, 4, MHD_OPTION_END);

    if (daemon == NULL) {
        ret = EXIT_FAILURE;

        fprintf(stderr, _ERR_CANNOT_START_SERVER _NEW_LINE _NEW_LINE,
                         daemon_name);

        syslog(LOG_ERR, _ERR_CANNOT_START_SERVER _NEW_LINE _NEW_LINE,
                         daemon_name);

        _cleanups_fixate();

        return ret;
    }

    /* Serving the request. (Hit Ctrl+C to terminate the daemon.) */
    printf(          _MSG_SERVER_STARTED_1 _NEW_LINE _MSG_SERVER_STARTED_2 \
                     _NEW_LINE, port_number);

    syslog(LOG_INFO, _MSG_SERVER_STARTED_1 _NEW_LINE _MSG_SERVER_STARTED_2 \
                     _NEW_LINE, port_number);

    while ((c = getchar()) != EOF) {}

    /* Stopping the server. */
    MHD_stop_daemon(daemon);

    /* Making final cleanups. */
    _cleanups_fixate();

    return ret;
}

/* vim:set nu:et:ts=4:sw=4: */
