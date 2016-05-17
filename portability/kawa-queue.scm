
(import (scheme base)
        (class java.util (ArrayDeque queue)))

(define (queue-add! q ::queue i)
  (q:add i))

(define (queue-remove! q ::queue)
  (q:remove))
