#lang rosette/safe

(require rosette/lib/angelic)

(provide solve-production-rule-set)

; production rule sets

(define (make-symbolic-production-rule-set alphabet valid-successors)
  (list->vector (map (lambda (symbol) (apply choose* valid-successors)) alphabet)))

; production rule set checker

(define (valid-production-rule-set? production-rule-set initial-state final-state)
  ; appends successors of symbols of given initial state from given production rule set and compares to final state
  (equal? (append-map (lambda (symbol) (vector-ref production-rule-set symbol)) initial-state) final-state))

; production rule set solver

(define (solve-production-rule-set alphabet states valid-successors)
  (define symbolic-production-rule-set (make-symbolic-production-rule-set alphabet valid-successors)) ; makes a symbolic production rule set for the given alphabet using the given valid successors
  (for-each (lambda (state)
              (when (! (equal? state (last states)))
                (assert (valid-production-rule-set? symbolic-production-rule-set state (second (member state states)))))) 
            states)
  (define valid-production-rule-set (solve (assert #t))) ; solves for valid production rule set
  (evaluate symbolic-production-rule-set valid-production-rule-set))