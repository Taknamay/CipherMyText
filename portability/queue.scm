
;;; Very simple queues implemented in terms of lists

(import (scheme base)
        (scheme cxr)
        (scheme write))

;; All procedures are O(1) except queue? which is O(n)
;; as well as the constructors:
;;
;; queue, list->queue, queue->list
;;
;; which are also all O(n)
;;
;; Example structure of a queue
;; (#0=(3) 0 1 2 . #0#)

(define (last-pair l)
  ;; Same as SRFI-1 last-pair
  (let loop ((a l)
             (b (cdr l)))
    (if (pair? b)
        (loop b (cdr b))
        a)))

(define (make-queue)
  ;; Any mutable list containing one element which is also
  ;; a list is considered an empty queue.
  (cons (cons #f '()) '()))

(define (list->queue l)
  (define q (make-queue))
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

(define (queue? q)
  (and (list? q)
       (list? (car q))
       (or (null? (cdr q)) ;; In the case of the empty queue
           (eq? (car q) (last-pair q)))))

(define (queue-empty? q)
  (null? (cdr q)))

(define (queue-front q)
  (if (queue-empty? q)
      (error "queue-front" "Referencing an empty queue")
      (cadr q)))

(define (queue-back q)
  (if (queue-empty? q)
      (error "queue-back" "Referencing an empty queue")
      (caar q)))

(define (queue-add! q val)
  (if (queue-empty? q)
      (begin
        (set-cdr! q (cons val '()))
        (set-car! q (cdr q)))
      (begin
        (set-cdr! (car q) (list val))
        (set-car! q (cdar q)))))

(define (queue-add-front! q val)
  ;; It is also an O(1) operation to add to the front, so
  ;; we might as well provide this procedure.
  (if (queue-empty? q)
      (queue-add! q val)
      (set-cdr! q (cons val (cdr q)))))

(define (queue-remove! q)
  (define a (queue-front q))
  (if (queue-empty? q)
      (error "queue-remove!" "Referencing an empty queue")
      (begin
        (set-cdr! q (cddr q))
        a)))

