
;;;
;;; Monoalphabetic encipher and decipher
;;;
;;; Copyright 2016 Jason K. MacDuffie
;;; License: GPLv3+
;;;

(define (mono-encipher pt-in key-in)
  ;; Encipher pt-in with a monoalphabetic cipher, where
  ;; key-in is a list of the letters with which to replace
  ;; the plaintext letters.
  (define vector-key (list->vector key-in))
  (map (lambda (c) (vector-ref vector-key
                               (letter->integer c)))
       pt-in))

(define (mono-decipher ct-in key-in)
  ;; Inverse of mono-encipher
  (define vector-key (make-vector 26))
  (let loop ((i 0)
             (in key-in))
    ;; We need to build the inverse key
    (when (< i 26)
      (vector-set! vector-key
                   (letter->integer (car in))
                   (integer->letter i))
      (loop (+ i 1) (cdr in))))
  (map (lambda (c) (vector-ref vector-key
                               (letter->integer c)))
       ct-in))

