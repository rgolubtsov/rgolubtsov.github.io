#!/usr/bin/env julia
#= content/src/replace_txt_chunks.jl
 * ============================================================================
 * Usage:
 * $ curl -sO http://rgolubtsov.github.io/srcs/replace_txt_chunks.jl && \
     chmod 700                                 replace_txt_chunks.jl && \
                                             ./replace_txt_chunks.jl; echo $?
 * ============================================================================
 * This is a demo script. It has to be run as a **script** in the Julia runtime
 * environment. Tested and known to run exactly the same way on modern versions
 * of Ubuntu Server LTS x86-64 and Arch Linux operating systems.
 *
 * Create a function that will take a String value as the first parameter,
 * a Number value as the second parameter, and a String value as the third one.
 * The first parameter should be a sentence or a set of sentences,
 * the second parameter should be a positional number of a letter in each word
 * in the given sentence that should be replaced by the third parameter.
 * That function should return the updated sentence.
 * ============================================================================
 * Copyright (C) 2023 Radislav (Radicchio) Golubtsov
 *
 * (See the LICENSE file at the top of the source tree.)
=#

# Helper constants.
EMPTY_STRING =     ""
NEW_LINE     =   "\n"
DBG_PREF     = "==> "

"The replace function."
function replace(text, pos, subst)
end

text  = "\
A guard sequence is either a single guard or a series of guards, \
separated by semicolons (';'). The guard sequence 'G1; G2; ...; Gn' \
is true if at least one of the guards 'G1', 'G2', ..., 'Gn' \
evaluates to 'true'.\
"

pos   = 3 # <== Can be set to either from 1 to infinity.
#subst = "callable entity"
#subst = "AAA"
#subst = "+-="
subst = "|"

println("$DBG_PREF$pos"           )
println("$DBG_PREF$subst$NEW_LINE")

text_ = replace(text, pos, subst)

println("$NEW_LINE$DBG_PREF$text" )
println(         "$DBG_PREF$text_")

# vim:set nu et ts=4 sw=4:
