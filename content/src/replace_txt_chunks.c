#!/usr/bin/tcc -run
/* content/src/replace_txt_chunks.c
 * ============================================================================
 * Usage:
 * $ curl -sO http://rgolubtsov.github.io/srcs/replace_txt_chunks.c && \
     chmod 700                                 replace_txt_chunks.c && \
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
 * Copyright (C) 2018-2022 Radislav (Radicchio) Golubtsov
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
#define S_FMT          "%s"
#define D_FMT          "%d"

/* The replace helper function. */
char *_replace(const char *word,
               const int   pos,
               const char *subst,
               const int   subst_len) {

    char *word_;
    int   word_len;

    word_len = strlen(word);

/*  printf(DBG_PREF S_FMT NEW_LINE, word);*/

    word_ = malloc((word_len - 1) + subst_len + sizeof(SPACE));
    word_ = strcpy(word_, EMPTY_STRING);

    if ((pos - 1 < word_len)
        && (strcmp(&word[pos - 1], COMMA) != 0)
        && (strcmp(&word[pos - 1], POINT) != 0)) {

        word_ = strncat(word_, word, pos - 1);
        word_ =  strcat(word_, subst);
        word_ =  strcat(word_, &word[pos]);
    } else {
        word_ =  strcat(word_, word);
    }

/*  printf(DBG_PREF S_FMT NEW_LINE, word_);*/

    word_ = strcat(word_, SPACE);

    return word_;
}

/* The replace function. */
char *replace(const char *text, const int pos, const char *subst) {
    char *text_, *text0, *text1, *word, *word_;
    int   subst_len, word_len_;

    subst_len = strlen(subst);
    word_len_ = sizeof(EMPTY_STRING);

    text_ = malloc(word_len_);
    text_ = strcpy(text_, EMPTY_STRING);

    text1 = text0 = strdup(text);

    while (word = strsep(&text0, SPACE)) {
        word_ = _replace(word, pos, subst, subst_len);

        text_ = realloc(text_, word_len_ += strlen(word_));
        text_ =  strcat(text_, word_);

        free(word_);
    }

    free(text1);

    return text_;
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

    printf(DBG_PREF D_FMT NEW_LINE,            pos);
    printf(DBG_PREF S_FMT NEW_LINE NEW_LINE, subst);

    char *text_ = replace(text, pos, subst);

    printf(NEW_LINE DBG_PREF S_FMT NEW_LINE, text );
    printf(         DBG_PREF S_FMT NEW_LINE, text_);

    free(text_);

    return EXIT_SUCCESS;
}

/* vim:set nu et ts=4 sw=4: */
