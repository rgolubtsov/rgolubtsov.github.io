#!/usr/bin/tcc -run
/* content/src/replace_txt_chunks.c
 * ============================================================================
 * Usage:
 *   $ curl -O http://rgolubtsov.github.io/srcs/replace_txt_chunks.c && \
       chmod 700                                replace_txt_chunks.c && \
                                              ./replace_txt_chunks.c; echo $?
 * ============================================================================
 * This is a demo script. It has to be run as a C script using TCC
 * (Fabrice Bellard's Tiny C Compiler). Tested and known to run
 * exactly the same way on modern versions of Ubuntu Server LTS x86-64,
 * Arch Linux / Arch Linux 32 operating systems.
 *
 * Create a function that will take a String value as the first parameter,
 * a Number value as the second parameter, and a String value as the third one.
 * The first parameter should be a sentence or a set of sentences,
 * the second parameter should be a positional number of a letter in each word
 * in the given sentence that should be replaced by the third parameter.
 * That function should return the updated sentence.
 * ============================================================================
 * Copyright (C) 2018 Radislav (Radicchio) Golubtsov
 *
 * (See the LICENSE file at the top of the source tree.)
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/* Helper constants. */
#define EMPTY_STRING     ""
#define SPACE           " "
#define COMMA           ","
#define POINT           "."
#define NEW_LINE       "\n"
#define DBG_PREF     "==> "

/* The helper function. */
char *_replace(const char *text, const int pos, const char *subst) {
    char *text_, *text__;
    int   text_len;

    text_len = strlen(text);

    printf(DBG_PREF "%s %d" NEW_LINE, text, text_len);

    text_ = malloc(strlen(text) + strlen(subst) + sizeof(SPACE));

    text_ = strcpy(text_, EMPTY_STRING);

    if ((pos - 1 < text_len)
/*      && (strcmp(text[pos - 1], COMMA) != 0)
        && (strcmp(text[pos - 1], POINT) != 0)*/) {

/*      text__ = strings.Replace(text,
                                 text[pos - 1], subst, -1) +
                                 text[pos    ];
*/

        text__ = strdup(text);

        printf(DBG_PREF "%s" NEW_LINE, text__);

        text_ = strcat(text_, text__);

        free(text__);
    } else {
        printf(DBG_PREF "%s" NEW_LINE, text  );

        text_ = strcat(text_, text  );
    }

    text_ = strcat(text_, SPACE);

    return text_;
}

/* The replace function. */
char *replace(const char *text, const int pos, const char *subst) {
    char *text_, *text__, *text___, *text____;

    text___ = text__ = strdup(text);

    while (text_ = strsep(&text__, SPACE)) {
        text____ = _replace(text_, pos, subst);

        printf(DBG_PREF "%s.o.oo..ooo...oo....o." NEW_LINE, text____);

        free(text____);
    }

    free(text___);
}

/* The script entry point. */
int main() {
    const char *text  = "\
A guard sequence is either a single guard or a series of guards, \
separated by semicolons (';'). The guard sequence 'G1; G2; ...; Gn' \
is true if at least one of the guards 'G1', 'G2', ..., 'Gn' \
evaluates to 'true'.\
";

    const int   pos   = 3; /* <== Can be set to either from 1 to infinity. */
/*  const char *subst = "callable entity";
    const char *subst = "AAA";
    const char *subst = "+-=";
*/  const char *subst = "|";

    printf(DBG_PREF "%d" NEW_LINE,            pos);
    printf(DBG_PREF "%s" NEW_LINE NEW_LINE, subst);

    replace(text, pos, subst);

    printf(NEW_LINE DBG_PREF "%s" NEW_LINE, text );
/*  printf(         DBG_PREF "%s" NEW_LINE, text_);
*/

    return EXIT_SUCCESS;
}

/* vim:set nu et ts=4 sw=4: */
