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

/* Helper function. Draws a horizontal separator banner. */
void _separator_draw(const char *banner_text) {
    unsigned char i = strlen(banner_text);

    do { putchar('='); i--; } while (i); puts(_EMPTY_STRING);
}

/* The application entry point. */
int main(int argc, char **argv) {
    int ret = EXIT_SUCCESS;

    _separator_draw(_APP_DESCRIPTION);

    printf(_APP_NAME        _COMMA_SPACE_SEP                         \
           _APP_VERSION_S__ _ONE_SPACE_STRING _APP_VERSION _NEW_LINE \
           _APP_DESCRIPTION                                _NEW_LINE \
           _APP_COPYRIGHT__ _ONE_SPACE_STRING _APP_AUTHOR  _NEW_LINE);

    _separator_draw(_APP_DESCRIPTION);

    return ret;
}

/* vim:set nu:et:ts=4:sw=4: */
