#!/usr/bin/env clojure
; content/src/get-current-age/get_current_age.clj
; =============================================================================
; Usage:
;   $ SRCS=https://rgolubtsov.github.io/srcs; \
;     curl -sOk ${SRCS}/get-current-age/get_current_age.clj   && \
;     chmod 700 get_current_age.clj;  ./get_current_age.clj 2>&1 \
;   | sed '/WARNING/d'; echo $?
; =============================================================================
; This is a demo script. It has to be run in the Clojure (JVM) runtime
; environment. Tested and known to run exactly the same way on modern versions
; of OpenBSD/amd64, Ubuntu Server LTS x86-64, Arch Linux operating systems.
;
; The script contains a function that calculates the current age
; based on the date of birth, given in args. It then simply returns
; the age calculated - nothing special.
; =============================================================================
; Copyright (C) 2023-2025 Radislav (Radicchio) Golubtsov
;
; (See the LICENSE file at the top of the source tree.)
;

(defn get-age
    "Calculates the current age based on the date of birth."
    [YY-OF-BIRTH MM-OF-BIRTH DD-OF-BIRTH]

    (let [date  (java.time.LocalDate/now)]
    (let [year  (.getYear       date)]
    (let [month (.getMonthValue date)]
    (let [day   (.getDayOfMonth date)]

    (let [age (- year YY-OF-BIRTH)]

    (if (< month MM-OF-BIRTH) (- age 1)
        (if (== month MM-OF-BIRTH) (if (< day DD-OF-BIRTH) (- age 1) age) age)
    ))))))
)

(println (get-age 1977 6 27)) ; <== 1977-06-27.

; vim:set nu et ts=4 sw=4:
