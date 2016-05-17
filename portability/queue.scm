
;;;
;;; Very simple queues implemented in terms of lists
;;;
;;; Copyright 2016 Jason K. MacDuffie
;;; License: GPLv3+
;;;

;; All procedures are O(1) except constructors which are linear

(import (scheme base))

(define-record-type <queue>
  (make-queue sz front back)
  queue?
  (sz queue-length set-size!)
  (front get-front set-front!)
  (back get-back set-back!))

(define (queue-front q)
  (if (queue-empty? q)
      (error "queue-front" "Referencing an empty queue")
      (car (get-front q))))

(define (queue-back q)
  (if (queue-empty? q)
      (error "queue-back" "Referencing an empty queue")
      (car (get-back q))))

(define (queue-add! q val)
  (define l (list val))
  (if (queue-empty? q)
      (set-front! q l)
      (set-cdr! (get-back q) l))
  (set-back! q l)
  (set-size! q (+ (queue-length q) 1)))

(define (queue-add-front! q val)
  ;; It is also an O(1) operation to add to the front, so
  ;; we might as well provide this procedure.
  (if (queue-empty? q)
      (queue-add! q val)
      (begin
        (set-front! q (cons val (get-front q)))
        (set-size! q (+ (queue-length q) 1)))))

(define (queue-remove! q)
  (define a (queue-front q))
  (set-front! q (cdr (get-front q)))
  (set-size! q (- (queue-length q) 1))
  a)

(define (list->queue l)
  (define q (make-queue 0 '() '(0)))
  (for-each (lambda (i) (queue-add! q i)) l)
  q)

(define (queue->list q)
  (define l
    (let loop ((l '()))
      (if (not (queue-empty? q))
          (loop (cons (queue-remove! q) l))
          (reverse l))))
  (for-each (lambda (i) (queue-add! q i)) l)
  l)

(define (queue . l)
  (list->queue l))

(define (queue-empty? q)
  (= (queue-length q) 0))

