
;; This implements immutable queues using the traditional "two stack" algorithm

;;  (export make-queue queue queue-length queue-insert
;;          queue-remove queue-empty? list->queue
;;          queue->list queue?)


(define-record-type type-queue
  (queue-cons inbox outbox)
  queue?
  (inbox queue-inbox)
  (outbox queue-outbox))

(define (make-queue k . el)
  (if (null? el)
      (queue-cons '() (make-list k))
      (queue-cons '() (make-list k (car el)))))

(define (queue . els)
  (list->queue els))

(define (queue-length q)
  (+ (length (queue-inbox q))
     (length (queue-outbox q))))

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

(define (queue-empty? q)
  (and (null? (queue-inbox q))
       (null? (queue-outbox q))))

(define (list->queue l)
  (queue-cons '() (reverse l)))

(define (queue->list q)
  (append (queue-inbox q)
	  (reverse (queue-outbox q))))



