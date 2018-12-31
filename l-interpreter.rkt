#lang rosette/safe

(require rosette/lib/angelic)

(provide find-from-states)

; an L-system is defined by a list of successors for corresponding alphabet
; an L-system can be interpreted with an initial state as input

(define (make-symbolic-successors alphabet successors)
  (map (lambda (symbol) (apply choose* successors)) alphabet))

(define (interpret successors state)
  (append-map (lambda (symbol) (list-ref successors symbol)) state))

(define (solve-two-states initial-state successors final-state)
  (solve (assert (equal? (interpret successors initial-state) final-state))))

(define (solve-states states successors)
  (define index 0)
  (for-each (lambda (state)
              (when (not (= index (- (length states) 1)))
                (assert (equal? (interpret successors state) (list-ref states (+ index 1)))))
              (set! index (+ index 1)))
            states)
  (solve (assert #t)))

(define (find-from-states states alphabet successors)
  (define symbolic-successors (make-symbolic-successors alphabet successors))
  (define actual-successors (evaluate symbolic-successors (solve-states states symbolic-successors)))
  actual-successors)

; test

(define alphabet (list 0 1))

(define initial-state (list 0 1))

(define final-state (list 0 1 1 0))

(define states (list (list 0 1)
                     (list 0 1 1 0)
                     (list 0 1 1 0 1 0 0 1)))

(define valid-successors (list (list 0)
                               (list 0 1)
                               (list 0 1 1)
                               (list 0 1 1 0)
                               (list 1)
                               (list 1 1)
                               (list 1 1 0)
                               (list 1 0)))

(define symbolic-successors (make-symbolic-successors alphabet valid-successors))

(define actual-successors (evaluate symbolic-successors (solve-states states symbolic-successors)))