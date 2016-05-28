
(define-library (macduffie cipher)
  (import (scheme base)
          (scheme case-lambda)
          (scheme char)
          (srfi 1)
          (macduffie queue))
  (export
   ;; cipher-ops.scm
   letter? letter->integer integer->letter letter+ letter-
   sanitize-chars restore-punctuation apply-cipher
   print-letters runkey-encipher runkey-decipher
   
   ;; autokey.scm
   autokey-encipher autokey-decipher
   
   ;; caesar.scm
   caesar-encipher caesar-decipher rot13
   
   ;; monokey.scm
   mono-encipher mono-decipher

   ;; reptkey.scm
   reptkey-encipher reptkey-decipher)
  (include "cipher-ops.scm")
  (include "autokey.scm")
  (include "caesar.scm")
  (include "monokey.scm")
  (include "reptkey.scm"))

