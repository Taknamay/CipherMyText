
(define-library (macduffie queue)
  (import (scheme base))
  (export queue list->queue queue->list queue-add! queue-remove!
          queue? queue-empty? queue-length queue-add-front!
          queue-front queue-back <queue>)
  (include "queue.body.scm"))

