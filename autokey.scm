
;;;
;;; Autokey encipher and decipher
;;;
;;; Copyright 2016 Jason K. MacDuffie
;;; License: GPLv3+
;;;

(define (autokey-encipher pt-in key-in)
  ;; Simply append the key to the plaintext, and then apply the
  ;; tabula recta
  (define k (append key-in pt-in))
  (runkey-encipher pt-in k))

(define (autokey-decipher ct-in key-in)
  ;; This is a bit more involved. As the plaintext is generated,
  ;; we must add it to the key. This lends itself well to a
  ;; queue, which you would probably need to simulate anyway
  ;; if you used something like a mutable vector.
  (define k (queue))
  (for-each (lambda (i) (queue-add! k i)) key-in)
  (let loop ((ct ct-in)
             (pt '()))
    (if (null? ct)
        (reverse pt)
        (let ((key-next (letter- (car ct)
                                 (queue-remove! k))))
          (queue-add! k key-next)
          (loop (cdr ct)
                (cons key-next pt))))))

