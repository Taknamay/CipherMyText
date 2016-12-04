
;;;
;;; Very simple queues implemented in terms of lists
;;;
;;; Copyright 2016 Jason K. MacDuffie
;;; License: GPLv3+
;;;

;; All procedures are O(1) except constructors which are linear

(define-record-type <queue>
  (make-queue sz front back)
  queue?
  (sz queue-length set-size!)
  (front get-front set-front!)
  (back get-back set-back!))

(define (last-pair l)
  (let loop ((a l)
             (b (cdr l)))
    (if (pair? b)
        (loop b (cdr b))
        a)))

(define (queue-empty? q)
  (= (queue-length q) 0))

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
  (apply queue l))

(define (queue->list q)
  (list-copy (get-front q)))

(define (queue . l)
  (make-queue (length l) l (if (null? l)
                               '(0)
                               (last-pair l))))

