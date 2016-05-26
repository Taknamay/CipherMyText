
;;;
;;; Caesar encipher and decipher, including ROT13
;;;
;;; Copyright 2016 Jason K. MacDuffie
;;; License: GPLv3+
;;;

;; This is easy to implement with our tabula recta

(define (caesar-encipher pt-in key-in)
  ;; The key should be an integer 0 to 25
  (define l (integer->letter key-in))
  (map (lambda (c) (letter+ c l))
       pt-in))

(define (caesar-decipher ct-in key-in)
  ;; Inverse of caesar-encipher
  (define l (integer->letter key-in))
  (map (lambda (c) (letter- c l))
       ct-in))

(define (rot13 t)
  ;; For rot13, encipher and decipher is the same
  (caesar-encipher t 13))

