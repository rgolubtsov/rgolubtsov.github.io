//usr/bin/env valac $0 && ./`basename $0 .gs`; exit $?
/* content/src/replace-txt-chunks/replace_txt_chunks.gs
 * ============================================================================
 * Usage:
 *   $ SRCS=https://rgolubtsov.github.io/srcs; \
       curl -sOk ${SRCS}/replace-txt-chunks/replace_txt_chunks.gs   && \
       chmod 700 replace_txt_chunks.gs;   ./replace_txt_chunks.gs;  echo $?
 * ============================================================================
 * This is a demo script. It has to be run as a Genie script using the Vala
 * compiler to compile it and then be directly executed by the executable
 * produced. Tested and known to run exactly the same way on modern versions
 * of Ubuntu Server LTS x86-64 and Arch Linux operating systems.
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
const EMPTY_STRING:string =     ""
const SPACE       :string =    " "
const COMMA       :string =    ","
const POINT       :string =    "."
const NEW_LINE    :string =   "\n"
const DBG_PREF    :string = "==> "

// The replace function.
def replace(text:string, pos:int, subst:string):string
	var text_        = EMPTY_STRING
	var text__       = EMPTY_STRING
	var text_ary     = text.split(SPACE)
	var text_ary_len = text_ary.length

	for var i = 0 to (text_ary_len - 1)
		var text_ary_i_len = text_ary[i].length

//		print(DBG_PREF + text_ary[i])

		if ((pos - 1 < text_ary_i_len)
			&& (text_ary[i].substring(pos - 1) != COMMA)
			&& (text_ary[i].substring(pos - 1) != POINT))

			text__ = (text_ary[i].replace(text_ary[i].substring(pos - 1), subst)
										+ text_ary[i].substring(pos    ))

//			print(DBG_PREF + text__     )

			text_ += text__
		else
//			print(DBG_PREF + text_ary[i])

			text_ += text_ary[i]

		text_ += SPACE

	return text_

// The script entry point.
init
	var text  = (
	  "A guard sequence is either a single guard or a series of guards, "
	+ "separated by semicolons (';'). The guard sequence 'G1; G2; ...; Gn' "
	+ "is true if at least one of the guards 'G1', 'G2', ..., 'Gn' "
	+ "evaluates to 'true'.")

	var pos   = 3 // <== Can be set to either from 1 to infinity.
//	var subst = "callable entity"
//	var subst = "AAA"
//	var subst = "+-="

	var subst = "|"

	print(@"$DBG_PREF$pos"           )
	print(@"$DBG_PREF$subst$NEW_LINE")

	var text_ = replace(text, pos, subst)

	print(@"$NEW_LINE$DBG_PREF$text" )
	print(         @"$DBG_PREF$text_")

// vim:set nu et ts=4 sw=4:
