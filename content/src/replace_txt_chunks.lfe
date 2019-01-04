#!/usr/bin/env lfescript
#| content/src/replace_txt_chunks.lfe
 | ============================================================================
 | Usage:
 | $ curl -sO http://rgolubtsov.github.io/srcs/replace_txt_chunks.lfe && \
     chmod 700                                 replace_txt_chunks.lfe && \
                                             ./replace_txt_chunks.lfe; echo $?
 | ============================================================================
 | This is a demo script. It has to be run in the LFE (Lisp Flavoured Erlang)
 | runtime environment. Tested and known to run exactly the same way on modern
 | versions of OpenBSD/amd64, Ubuntu Server LTS x86-64, Arch Linux /
 | Arch Linux 32 operating systems.
 |
 | Create a function that will take a String value as the first parameter,
 | a Number value as the second parameter, and a String value as the third one.
 | The first parameter should be a sentence or a set of sentences,
 | the second parameter should be a positional number of a letter in each word
 | in the given sentence that should be replaced by the third parameter.
 | That function should return the updated sentence.
 | ============================================================================
 | Copyright (C) 2018-2019 Radislav (Radicchio) Golubtsov
 |
 | (See the LICENSE file at the top of the source tree.)
 |#

(defun replace (text pos subst)
    "The replace function."

    ; Helper constants.
    (macrolet ((EMPTY-STRING ()     ""))
    (macrolet ((SPACE        ()    " "))
    (macrolet ((COMMA        ()    ","))
    (macrolet ((POINT        ()    "."))
    (macrolet ((NEW-LINE     ()   "\n"))
    (macrolet ((DBG-PREF     () "==> "))

    (: lists foldl (lambda (word text-)
        (let ((word-len (length word)))
        (let ((word-pos (if (< (- pos 1) word-len) (: string substr word pos)
                                                   (EMPTY-STRING))))

;       (: io put_chars (++ (DBG-PREF) word (NEW-LINE)))

        (++ text- (cond ((and (< (- pos 1) word-len)
            (=/= word-pos (COMMA))
            (=/= word-pos (POINT)))

            (let ((word- (++ (: string substr word 1 (- pos 1)) subst
                             (: string substr word   (+ pos 1)))))

;           (: io put_chars (++ (DBG-PREF) word- (NEW-LINE)))

            word-))
          ('true
;           (: io put_chars (++ (DBG-PREF) word  (NEW-LINE)))

            word ))
        (SPACE))
    ))) (EMPTY-STRING) (: string tokens text (SPACE))))))))))

(defun main (_)
    "The script entry point."

    ; Helper constants.
    (macrolet ((EMPTY-STRING ()     ""))
    (macrolet ((NEW-LINE     ()   "\n"))
    (macrolet ((DBG-PREF     () "==> "))

    (let ((text  (++ (EMPTY-STRING)
"A guard sequence is either a single guard or a series of guards, "
"separated by semicolons (';'). The guard sequence 'G1; G2; ...; Gn' "
"is true if at least one of the guards 'G1', 'G2', ..., 'Gn' "
"evaluates to 'true'."
                     (EMPTY-STRING))))

    (let ((pos   3)) ; <== Can be set to either from 1 to infinity.
;   (let ((subst "callable entity"))
;   (let ((subst "AAA"))
;   (let ((subst "+-="))
    (let ((subst "|"))

    (: io put_chars (++ (DBG-PREF) (integer_to_list pos) (NEW-LINE)))
    (: io put_chars (++ (DBG-PREF) subst (NEW-LINE)      (NEW-LINE)))

    (let ((text- (replace text pos subst)))

    (: io put_chars (++ (NEW-LINE) (DBG-PREF) text       (NEW-LINE)))
    (: io put_chars (++            (DBG-PREF) text-      (NEW-LINE)))
    )               )              )        )            )        )))

; vim:set nu et ts=4 sw=4:
