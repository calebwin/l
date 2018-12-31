# l

l is a simple [Rosette](http://emina.github.io/rosette/index.html)-based solver for L-system grammars. Given a specification of consecutive states, the production rule set for a valid L-system will be generated.

```racket
(define state-1 (list "a" "b" "c"))
(define state-2 (list "a" "b" "a" "c" "a"))
(define state-3 (list "a" "b" "a" "a" "b" "c" "a" "a" "b"))

; find production rule-set
(define production-rule-set (find-production-rule-set (list state-1 state-2 state-3)))

; print production rule-set
(print-production-rule-set production-rule-set)
```
