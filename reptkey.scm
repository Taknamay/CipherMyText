
;;;
;;; Repeating key encipher and decipher
;;;
;;; Copyright 2016 Jason K. MacDuffie
;;; License: GPLv3+
;;;

(define (reptkey-xcipher pt-in key-in direction)
  ;; A repeating key cipher, commonly known as "Vigenere"
  ;; I reject that name because it has little to do with
  ;; Vigenere at all. Anyway, this just involves taking
  ;; a key and repeating it until the end of the plain
  ;; text, then applying tabula recta.
  ;;
  ;; Encipherment and decipherment are similar, so I
  ;; am sharing the code body for both.
  (define l (apply circular-list key-in))
  (direction pt-in l))

(define (reptkey-encipher pt-in key-in)
  (reptkey-xcipher pt-in key-in runkey-encipher))

(define (reptkey-decipher pt-in key-in)
  (reptkey-xcipher pt-in key-in runkey-decipher))

