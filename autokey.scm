
;;;
;;; Autokey encipher and decipher
;;;
;;; Copyright 2016 Jason K. MacDuffie
;;; License: GPLv3+
;;;

(import (scheme base)
        (scheme load)
        (class java.util (ArrayDeque queue)))

(load "./cipher-ops.scm")

(define (autokey-encipher pt-in key-in)
  ;; Simply append the key to the plaintext, and then apply the
  ;; tabula recta
  (define s (sanitize-chars pt-in))
  (define k (append (sanitize-chars key-in) s))
  (runkey-encipher s k))

(define (autokey-decipher ct-in key-in)
  ;; This is a bit more involved. As the plaintext is generated,
  ;; we must add it to the key. This lends itself well to a
  ;; queue, which you would probably need to simulate anyway
  ;; if you used something like a mutable vector.
  (define s (sanitize-chars ct-in))
  (define k ::queue (queue))
  (for-each k:add (sanitize-chars key-in))
  (let loop ((ct s)
             (pt '()))
    (if (null? ct)
        (reverse pt)
        (let ((key-next (letter- (car ct)
                                 (k:remove))))
          (k:add key-next)
          (loop (cdr ct)
                (cons key-next pt))))))

