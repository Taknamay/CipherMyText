#!/usr/bin/env gosh

;; This implements very simple immutable queues

;; It uses the traditional "two stack" algorithm

;; There is no optimization since the key list
;; should never be very large.

(define-record-type type-queue
  (queue-cons inbox outbox)
  queue?
  (inbox queue-inbox)
  (outbox queue-outbox))

(define (null-queue? q)
  (and (null? (queue-inbox q))
       (null? (queue-outbox q))))

(define (queue-insert q val)
  (queue-cons (cons val (queue-inbox q))
              (queue-outbox q)))

(define (queue-remove q)
  (if (null? (queue-outbox q))
      (let ((rev (reverse (queue-inbox q))))
        (values (queue-cons '()
                            (cdr rev))
                (car rev)))
      (values (queue-cons (queue-inbox q)
                          (cdr (queue-outbox q)))
              (car (queue-outbox q)))))

(define (list->queue l)
  (queue-cons '() (reverse l)))

(define (queue->list q)
  (append (queue-inbox q)
          (reverse (queue-outbox q))))

