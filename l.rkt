#lang racket

(require "l-interpreter.rkt")

; state defined by list of symbols and an index
(struct state (symbols index))

; rule defined by lists of inital symbols and final symbols
(struct rule (initial final))

; production-rule-set finder
(define (find-rules system-states)
  ; get system alphabet from last state
  (define system-alphabet
    (remove-duplicates (state-symbols (last system-states))))
  ; get encoded alphabet from system alphabet (encode system alphabet as integers representing indices in system alphabet)
  (define alphabet
    (range (length system-alphabet)))
  ; get encoded states from system states
  (define states
    ; transform each state
    (map (lambda (state)
           (state
            ; transform symbols
            (map (lambda (symbol)
                         (index-of system-alphabet symbol))
                       (state-symbols state))
            ; index
            (state-index state)))
         system-states))
  ; get valid successors from all possible subsets of last state
  (define valid-successors (combinations (state-symbols (last states))))
  ; solve for valid production rule set
  (define production-rule-set (find-from-states states alphabet valid-successors))
  (define system-production-rule-set (build-list (length production-rule-set) (lambda (position) (cons (list-ref system-alphabet position) (map (lambda (symbol) (list-ref system-alphabet symbol)) (list-ref production-rule-set position)))))) ; transform production rule set to use system alphabet
  system-production-rule-set)

; production-rule-set printer
(define (print-rules rules)
  (for ([rule rules])
    (display (rule-initial rule))
    (display " -> ")
    (display (rule-final rule))
    (newline)))

; test
(define state-1 (list "a" "b"))
;;(define state-2 (list "a" "b" "a"))
(define state-3 (list "a" "b" "a" "a" "b"))
;;(define state-4 (list "a" "b" "a" "a" "b" "a" "b" "a"))

(define production-rule-set (find-production-rule-set (list (cons state-1 0) (cons state-3 2))))

(print-production-rule-set production-rule-set)
