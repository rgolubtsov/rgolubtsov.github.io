#!/usr/bin/env clojure
; content/src/replace_txt_chunks.clj
; =============================================================================
; Usage:
; $ curl -sO http://rgolubtsov.github.io/srcs/replace_txt_chunks.clj && \
;   chmod 700                                 replace_txt_chunks.clj && \
;                                           ./replace_txt_chunks.clj; echo $?
; =============================================================================
; This is a demo script. It has to be run in the Clojure (JVM) runtime
; environment. Tested and known to run exactly the same way on modern versions
; of Arch Linux / Arch Linux 32 operating systems.
;
; Create a function that will take a String value as the first parameter,
; a Number value as the second parameter, and a String value as the third one.
; The first parameter should be a sentence or a set of sentences,
; the second parameter should be a positional number of a letter in each word
; in the given sentence that should be replaced by the third parameter.
; That function should return the updated sentence.
; =============================================================================
; Copyright (C) 2018-2019 Radislav (Radicchio) Golubtsov
;
; (See the LICENSE file at the top of the source tree.)
;

; Helper constants.
(defmacro EMPTY-STRING []     "")
(defmacro NEW-LINE     []   "\n")
(defmacro DBG-PREF     [] "==> ")
(defmacro SPACE-       []  #"\ ")

(defn replace-
    "The replace function."
    [text pos subst]

    (try
        (loop [words (clojure.string/split text (SPACE-)) text- (EMPTY-STRING)]
        (when (seq words)
            (let [word     (first words)]
            (let [word-len (count word )]
            (let [word-pos (if (< (- pos 1) word-len) (subs word pos)
                                                      (EMPTY-STRING))]

            (println (str (DBG-PREF) word))

            (if (= word (last words)) (throw (Exception.  (str text- word)))
                                      (recur (rest words) (str text- word)))
        )))))
    (catch
        Exception e (.getMessage e)
    )))

(defn main
    "The script entry point."
    []

    (let [text  (str (EMPTY-STRING)
"A guard sequence is either a single guard or a series of guards, "
"separated by semicolons (';'). The guard sequence 'G1; G2; ...; Gn' "
"is true if at least one of the guards 'G1', 'G2', ..., 'Gn' "
"evaluates to 'true'."
                     (EMPTY-STRING))]

    (let [pos   3] ; <== Can be set to either from 1 to infinity.
;   (let [subst "callable entity"]
;   (let [subst "AAA"]
;   (let [subst "+-="]
    (let [subst "|"]

    (println (str (DBG-PREF)            pos  ))
    (println (str (DBG-PREF)            subst))
    (newline)

    (let [text- (replace- text pos subst)]

    (println (str (NEW-LINE) (DBG-PREF) text ))
    (println (str            (DBG-PREF) text-))
    )        )               )               ))

(main)

; vim:set nu et ts=4 sw=4:
