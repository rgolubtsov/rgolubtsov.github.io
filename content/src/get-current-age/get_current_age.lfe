#!/usr/bin/env lfescript
#| content/src/get-current-age/get_current_age.lfe
 | ============================================================================
 | Usage:
 |   $ SRCS=http://rgolubtsov.github.io/srcs; \
       curl  -sO ${SRCS}/get-current-age/get_current_age.lfe   && \
       chmod 700 get_current_age.lfe;  ./get_current_age.lfe;  echo $?
 | ============================================================================
 | This is a demo script. It has to be run in the LFE (Lisp Flavoured Erlang)
 | runtime environment. Tested and known to run exactly the same way on modern
 | versions of OpenBSD/amd64, Ubuntu Server LTS x86-64, Arch Linux
 | operating systems.
 |
 | The script contains a function that calculates the current age
 | based on the date of birth, given in args. It then simply returns
 | the age calculated - nothing special.
 | ============================================================================
 | Copyright (C) 2023-2024 Radislav (Radicchio) Golubtsov
 |
 | (See the LICENSE file at the top of the source tree.)
 |#

(defun get-age (YY-OF-BIRTH MM-OF-BIRTH DD-OF-BIRTH)
    "Calculates the current age based on the date of birth."

    (let ((date  (element 1 (calendar:local_time))))
    (let ((year  (element 1 date)))
    (let ((month (element 2 date)))
    (let ((day   (element 3 date)))

    (let ((age (- year YY-OF-BIRTH)))

    (if (< month MM-OF-BIRTH) (- age 1)
        (if (=:= month MM-OF-BIRTH) (if (< day DD-OF-BIRTH) (- age 1) age) age)
    ))))))
)

(defun main (_)
    "The script entry point."

    (io:put_chars (integer_to_list (get-age 1977 6 27))) ; <== 1977-06-27.
    (io:nl)
)

; vim:set nu et ts=4 sw=4:
