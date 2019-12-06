; Goal-constrained planning domain model verification of safety properties.
; Anas Shrinah and Kerstin Eder.
; Section 6 - experiments.
; Second experiment - goal constrained verification -  Planning problem.

; The second experiment investigates the effect of the early
; termination of the verification process, after achieving the
; goal, on the cost of verification tasks while increasing the depth
; of the planning goal. The model used in this experiment has one critical
; and four independent variables, each with a range from 0 to 15.
; Variables have two actions as in the previous model. This time, there is
; no error in the model and the goal condition is varied from critical value
; 1 to 14.

(define (problem SecondExperimentProb)
  (:domain SecondExperimentDom)
  (:objects
    
  )

  (:init
    (= (critical-variable) 0)
    (= (independent-variable-1) 0) 
    (= (independent-variable-2) 0) 
    (= (independent-variable-3) 0) 
    (= (independent-variable-4) 0) 


  )

  (:goal
(and        (= (critical-variable) 2)


    )
  )
  (:constraints
    (and
      (sometime-before (= (critical-variable) 2) (error))


    )
  )


)