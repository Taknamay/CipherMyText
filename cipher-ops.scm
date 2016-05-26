
;;;
;;; This is a small library containing useful procedures for
;;; pen-and-paper mono- and polyalphabetic ciphers.
;;;
;;; NOTICE: sanitize-chars and restore-punctuation work on
;;; lists of chars and not strings. This helps performance
;;; by cutting back on conversions. Simply convert before and
;;; after using the necessary procedure.
;;;
;;; Copyright 2016 Jason K. MacDuffie
;;; License: GPLv3+
;;;

(define (letter? c)
  ;; Is c an ASCII letter?
  (define n (char->integer c))
  (and (< 64 n 123)
       (not (< 90 n 97))))

(define (letter->integer c)
  ;; Encode letters as numbers
  ;; A -> 0,  Z -> 26
  (- (char->integer (char-upcase c))
     65))

(define (integer->letter n)
  ;; Inverse of letter->integer
  (integer->char (+ n 65)))

(define (letter+ a b)
  ;; Add letters according to the tabula recta.
  (integer->letter (modulo (+ (letter->integer a)
                              (letter->integer b))
                           26)))

(define (letter- a b)
  ;; Subtract letters according to the tabula recta.
  (integer->letter (modulo (- (letter->integer a)
                               (letter->integer b))
                            26)))

(define (sanitize-chars s)
  ;; Remove punctuation and upcase a list of characters.
  (let loop ((in s)
             (out '()))
    (if (null? in)
        (reverse out)
        (loop (cdr in)
              (if (letter? (car in))
                  (cons (char-upcase (car in)) out)
                  out)))))

(define (restore-punctuation original modified)
  ;; Add punctuation back to a list of characters.
  (let loop ((in-original original)
             (in-modified modified)
             (out '()))
    (if (null? in-original)
        (reverse out)
        (if (letter? (car in-original))
            (loop (cdr in-original)
                  (cdr in-modified)
                  (cons (if (char-upper-case? (car in-original))
                            (car in-modified)
                            (char-downcase (car in-modified)))
                        out))
            (loop (cdr in-original)
                  in-modified
                  (cons (car in-original) out))))))

(define (apply-cipher ciph restore? s-in . rest-in)
  ;; Higher level procedure that accepts and returns strings
  (define sl (string->list s-in))
  (define s (sanitize-chars sl))
  (define rest (map (lambda (s)
                      (if (string? s)
                          (sanitize-chars (string->list s))
                          s))
                    rest-in))
  (let ((result (apply ciph s rest)))
    (list->string (if restore?
                      (restore-punctuation sl result)
                      result))))

(define print-letters
  (case-lambda
   ((s) (print-letters s #\space))
   ((s pad)
    ;; Space out the letters of s by groups of 5, and
    ;; pad the end by repeating a character.
    (let loop ((l (string->list s))
               (i 0))
      (if (null? l)
          (display (make-string (- 5 i) pad))
          (cond
           ((< i 5)
            (display (car l))
            (loop (cdr l) (+ i 1)))
           (else
            (display " ")
            (loop l 0))))))))

(define (runkey-encipher pt-in key-in)
  ;; Simplest polyalphabetic cipher. Potentially useful
  ;; as the base of other polyalphabetic ciphers.
  (map letter+ pt-in key-in))

(define (runkey-decipher ct-in key-in)
  ;; Inverse of runkey-encipher
  (map letter- ct-in key-in))

