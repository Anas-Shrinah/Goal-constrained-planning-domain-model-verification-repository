; Goal-constrained planning domain model verification of safety properties.
; Anas Shrinah and Kerstin Eder.
; Section 6 - experiments.
; Second experiment - goal constrained verification -  Planning domain model.

; The second experiment investigates the effect of the early
; termination of the verification process, after achieving the
; goal, on the cost of verification tasks while increasing the depth
; of the planning goal. The model used in this experiment has one critical
; and four independent variables, each with a range from 0 to 15.
; Variables have two actions as in the previous model. This time, there is
; no error in the model and the goal condition is varied from critical value
; 1 to 14.



(define (domain SecondExperimentDom)
  (:requirements :typing :adl :fluents)
  (:predicates
    (error)

  )
  (:functions
    (critical-variable)
    (independent-variable-1)
    (independent-variable-2)
    (independent-variable-3)
    (independent-variable-4)
  )


  (:action increase-critical
    :parameters ()
    :precondition (and (< (critical-variable) 15))
    :effect (and (increase (critical-variable) 1))
  )

  (:action increase-independent-1
    :parameters ()
    :precondition (and (< (independent-variable-1) 15))
    :effect (and (increase (independent-variable-1) 1))
  )

  (:action increase-independent-2
    :parameters ()
    :precondition (and (< (independent-variable-2) 15))
    :effect (and (increase (independent-variable-2) 1))
  )

  (:action increase-independent-3
    :parameters ()
    :precondition (and (< (independent-variable-3) 15))
    :effect (and (increase (independent-variable-3) 1))
  )

  (:action increase-independent-4
    :parameters ()
    :precondition (and (< (independent-variable-4) 15))
    :effect (and (increase (independent-variable-4) 1))
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

  (:action decrease-independent-4
    :parameters ()
    :precondition (and (> (independent-variable-4) 0))
    :effect (and (decrease (independent-variable-4) 1))
  )

   

)
