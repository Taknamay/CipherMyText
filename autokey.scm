#!/usr/bin/env gosh

;; An implementation of the autokey cipher in Scheme

#|

  Copyright 2014, 2015 Jason K. MacDuffie

  This file is part of AutoMyText!.

  AutoMyText! is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  AutoMyText! is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with AutoMyText!.  If not, see <http://www.gnu.org/licenses/>.

|#

(import (scheme base)
        (scheme char)
        (scheme process-context)
        (scheme write))

(include "queue.scm")

(define (version)
  (define about-string "AutoMyText! 1.0 (Last change made 2015 July 12)
Copyright 2014, 2015 Jason K. MacDuffie
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
")
  (display about-string)
  (exit))

(define (sanitize s)
  ; Convert s into a list of uppercase alphabetic characters
  (if (not (string? s))
      (error "sanitize" "A string was expected"))
  (let loop ((out-list '())
             (in-list (string->list s)))
    (if (null? in-list)
        (if (null? out-list)
            (error "sanitize" "Sanitized string is null")
            (reverse out-list))
        ; Only process 7-bit ASCII characters
        (let ((v (car in-list)))
          (if (and (char-alphabetic? v)
                   (char<? v #\x80))
              (loop (cons (char-upcase v) out-list)
                    (cdr in-list))
              (loop out-list (cdr in-list)))))))

(define (letter->integer c)
  (- (char->integer c) 65))

(define (integer->letter n)
  (integer->char (+ n 65)))

(define (letter-add a b)
  (integer->letter (modulo (+ (letter->integer a)
                              (letter->integer b))
                           26)))

(define (letter-subtract a b)
  (integer->letter (modulo (- (letter->integer a)
                              (letter->integer b))
                           26)))

(define (encipher pt key)
  (define s (sanitize pt))
  (let loop ((new-pt s)
             (new-key (append (sanitize key) s))
             (ct '()))
    (if (null? new-pt)
        (list->string (reverse ct))
        (loop (cdr new-pt)
              (cdr new-key)
              (cons (letter-add (car new-pt)
                                (car new-key))
                    ct)))))

(define (decipher ct key)
  (let loop ((new-ct (sanitize ct))
             (new-key (list->queue (reverse (sanitize key))))
             (pt '()))
    (if (null? new-ct)
        (list->string (reverse pt))
        (let-values (((q key-next) (queue-remove new-key)))
          (let ((d-char (letter-subtract (car new-ct) key-next)))
            (loop (cdr new-ct)
                  (queue-insert q d-char)
                  (cons d-char pt)))))))

(define (restore-punctuation original modified)
  (let loop ((restored '())
             (orig (string->list original))
             (m (string->list modified)))
    (if (null? orig)
        (list->string (reverse restored))
        (let ((v (car orig)))
          (if (and (char-alphabetic? v)
                   (char<? v #\x80))
              (loop (cons (if (char-upper-case? v)
                              (car m)
                              (char-downcase (car m)))
                          restored)
                    (cdr orig)
                    (cdr m))
              (loop (cons v restored)
                    (cdr orig)
                    m))))))

