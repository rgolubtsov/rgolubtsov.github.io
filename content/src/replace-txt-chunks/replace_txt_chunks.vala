#!/usr/bin/env vala
/* content/src/replace-txt-chunks/replace_txt_chunks.vala
 * ============================================================================
 * Usage:
 *   $ SRCS=https://rgolubtsov.github.io/srcs; \
       curl -sOk ${SRCS}/replace-txt-chunks/replace_txt_chunks.vala   && \
       chmod 700 replace_txt_chunks.vala; ./replace_txt_chunks.vala;  echo $?
 * ============================================================================
 * This is a demo script. It has to be run as a Vala script using the Vala
 * tool's runtime facility. Tested and known to run exactly the same way
 * on modern versions of Ubuntu Server LTS x86-64 and Arch Linux
 * operating systems.
 *
 * Create a function that will take a String value as the first parameter,
 * a Number value as the second parameter, and a String value as the third one.
 * The first parameter should be a sentence or a set of sentences,
 * the second parameter should be a positional number of a letter in each word
 * in the given sentence that should be replaced by the third parameter.
 * That function should return the updated sentence.
 * ============================================================================
 * Copyright (C) 2026 Radislav (Radicchio) Golubtsov
 *
 * (See the LICENSE file at the top of the source tree.)
 */

// Helper constants.
const string EMPTY_STRING =     "";
const string SPACE        =    " ";
const string COMMA        =    ",";
const string POINT        =    ".";
const string NEW_LINE     =   "\n";
const string DBG_PREF     = "==> ";

// The replace function.
string replace(string text, int pos, string subst) {
    var text_        = EMPTY_STRING;
    var text__       = EMPTY_STRING;
    var text_ary     = text.split(SPACE);
    var text_ary_len = text_ary.length;

    for (var i = 0; i < text_ary_len; i++) {
        var text_ary_i_len = text_ary[i].length;

//      print(DBG_PREF + text_ary[i] + NEW_LINE);

        if ((pos - 1 < text_ary_i_len)
            && (text_ary[i].substring(pos - 1) != COMMA)
            && (text_ary[i].substring(pos - 1) != POINT)) {

            text__ = text_ary[i]
            .replace(text_ary[i].substring(pos - 1), subst)
            +        text_ary[i].substring(pos    );

//          print(DBG_PREF + text__      + NEW_LINE);

            text_ += text__;
        } else {
//          print(DBG_PREF + text_ary[i] + NEW_LINE);

            text_ += text_ary[i];
        }

        text_ += SPACE;
    }

    return text_;
}

// The script entry point.
void main() {
    var text
    = "A guard sequence is either a single guard or a series of guards, "
    + "separated by semicolons (';'). The guard sequence 'G1; G2; ...; Gn' "
    + "is true if at least one of the guards 'G1', 'G2', ..., 'Gn' "
    + "evaluates to 'true'.";

    var pos   = 3; // <== Can be set to either from 1 to infinity.
//  var subst = "callable entity";
//  var subst = "AAA";
//  var subst = "+-=";
    var subst = "|";

    print(@"$DBG_PREF$pos$NEW_LINE"           );
    print(@"$DBG_PREF$subst$NEW_LINE$NEW_LINE");

    var text_ = replace(text, pos, subst);

    print(@"$NEW_LINE$DBG_PREF$text$NEW_LINE" );
    print(         @"$DBG_PREF$text_$NEW_LINE");
}

// vim:set nu et ts=4 sw=4:
