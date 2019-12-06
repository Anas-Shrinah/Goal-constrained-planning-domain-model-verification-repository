; Goal-constrained planning domain model verification of safety properties.
; Anas Shrinah and Kerstin Eder.
; Section 6 - experiments.
; First experiment - Constrained verification - planning problem.

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

(define (problem FirstExperimentProb)
  (:domain FirstExperimentDom)
  (:objects
    
  )

  (:init
    (= (critical-variable) 0)
    (= (independent-variable-1) 0) 
    (= (independent-variable-2) 0) 
    (= (independent-variable-3) 0) 

  )

  (:goal
    (and
        (= (critical-variable) 14)

    )
  )
  (:constraints
    (and
      (sometime-before (= (critical-variable) 14)  (error))


    )
  )


)