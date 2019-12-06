; Goal-constrained planning domain model verification of safety properties.
; Anas Shrinah and Kerstin Eder.
; Section 6 - experiments.
; First experiment - Constrained verification - planning domain model.

; The first experiment focuses on comparing the cost of both
; unconstrained and goal-constrained verification tasks while
; varying the safety property violation depth in order to explore 
; situations with and without a valid planning counterexample.

; The safety property violation depth is hereafter termed “error depth”.
; We synthesised a fully reachable model that consists of one critical and three
; independent variables, each with a range from 0 to 31. 
; Each variable has two actions, one to increase and one to decrease its value
; by one. The goal is achieved when the critical variable value
; reaches 14. The error condition is changed from the value of
; the critical variable being 1 to 31.


(define (domain FirstExperimentDom)
  (:requirements :typing :adl :fluents)
  (:predicates
    (error)

  )
  (:functions
    (critical-variable)
    (independent-variable-1)
    (independent-variable-2)
    (independent-variable-3)
  )


  (:action increase-critical
    :parameters ()
    :precondition (and (< (critical-variable) 31))
    :effect (and (increase (critical-variable) 1))
  )

  (:action increase-independent-1
    :parameters ()
    :precondition (and (< (independent-variable-1) 31))
    :effect (and (increase (independent-variable-1) 1))
  )

  (:action increase-independent-2
    :parameters ()
    :precondition (and (< (independent-variable-2) 31))
    :effect (and (increase (independent-variable-2) 1))
  )

  (:action increase-independent-3
    :parameters ()
    :precondition (and (< (independent-variable-3) 31))
    :effect (and (increase (independent-variable-3) 1))
  )

    (:action decrease-critical
    :parameters ()
    :precondition (and (> (critical-variable) 0))
    :effect (and (decrease (critical-variable) 1))
  )

  (:action decrease-independent-1
    :parameters ()
    :precondition (and (> (independent-variable-1) 0))
    :effect (and (decrease (independent-variable-1) 1))
  )

  (:action decrease-independent-2
    :parameters ()
    :precondition (and (> (independent-variable-2) 0))
    :effect (and (decrease (independent-variable-2) 1))
  )

  (:action decrease-independent-3
    :parameters ()
    :precondition (and (> (independent-variable-3) 0))
    :effect (and (decrease (independent-variable-3) 1))
  )

(:action make-error
    :parameters ()
    :precondition (and (= (critical-variable) 14) )
    :effect (and (error))
  )


)
