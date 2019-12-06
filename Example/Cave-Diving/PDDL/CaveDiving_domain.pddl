;; Goal-constrained planning domain model verification of safety properties.
;; Anas Shrinah and Kerstin Eder.
;; Section 5 - planning domain model.
;; A modified version of the Cave Diving model by Nathan Robinson, Christian Muise, and  Charles Gretton.


(define (domain cave-diving-adl)
  (:requirements :typing :adl);; action-cost removed as the safety verification is not concerned with cost minimisation.
  (:types location diver tank quantity)
  (:predicates
    (at-tank ?t - tank ?l - location)
    (in-storage ?t - tank)
    (full ?t - tank)
    (next-tank ?t1 - tank ?t2 - tank)
    (at-diver ?d - diver ?l - location)
    (available ?d - diver)
    (at-surface ?d - diver)
    (decompressing ?d - diver)
    (precludes ?d1 - diver ?d2 - diver)
    (cave-entrance ?l - location)
    (connected ?l1 - location ?l2 - location)
    (next-quantity ?q1 - quantity ?q2 - quantity)
    (holding ?d - diver ?t - tank)
    (capacity ?d - diver ?q - quantity)
    (have-photo ?l - location)
    (in-water )
  )

;; all cost related functions and predicates are removed as the safety verification is not concerned with cost minimisation.
  ; (:functions
  ;   (hiring-cost ?d - diver) - number
  ;   (other-cost) - number
  ;   (total-cost) - number
  ; )
;; hire-diver action is removed as a consequence of removing  precludes predicate in the simplification of the domain model.
;; in Example 6. Due to the removal of precludes predicate Only one diver can be used. Hence hire-diver is not required.
  ; (:action hire-diver
  ;   :parameters (?d1 - diver)
  ;   :precondition (and      (available ?d1)
  ;                      (not (in-water)) 
  ;                 )
  ;   :effect (and (at-surface ?d1)
  ;                (not (available ?d1))
  ;                (forall (?d2 - diver)
  ;                    (when (precludes ?d1 ?d2) (not (available ?d2))))
  ;                (in-water)
  ;                ; (increase (total-cost) (hiring-cost ?d1))
  ;           )
  ; )

  (:action prepare-tank
    :parameters (?d - diver ?t1 ?t2 - tank ?q1 ?q2 - quantity)
    :precondition (and (at-surface ?d)
                       (in-storage ?t1)
                       (next-quantity ?q1 ?q2)
                       (capacity ?d ?q2)
                       (next-tank ?t1 ?t2)
                  )
    :effect (and (not (in-storage ?t1))
                 (not (capacity ?d ?q2))
                      (in-storage ?t2)
                      (full ?t1)
                      (capacity ?d ?q1)
                      (holding ?d ?t1)
                 ; (increase (total-cost) (other-cost )) ;; cost related effect. Hence commented out.
            )
  )

  (:action enter-water
    :parameters (?d - diver ?l - location)
    :precondition (and (at-surface ?d)
                       (cave-entrance ?l)
                  )
    :effect (and (not (at-surface ?d))
                      (at-diver ?d ?l)
                 ; (increase (total-cost) (other-cost )) ;; cost related effect. Hence commented out.
            )
  )

  (:action pickup-tank
    :parameters (?d - diver ?t - tank ?l - location ?q1 ?q2 - quantity)
    :precondition (and (at-diver ?d ?l)
                       (at-tank ?t ?l)
                       (full ?t) ;; Added in the modified version to prevent picking up empty tanks. Required to reduce the size of the reachable space.
                       (next-quantity ?q1 ?q2)
                       (capacity ?d ?q2)
                  )
    :effect (and (not (at-tank ?t ?l))
                 (not (capacity ?d ?q2))
                      (holding ?d ?t)
                      (capacity ?d ?q1)
                 ; (increase (total-cost) (other-cost )) ;; cost related effect. Hence commented out.
            )
  )

  (:action drop-tank
    :parameters (?d - diver ?t - tank ?l - location ?q1 ?q2 - quantity)
    :precondition (and (at-diver ?d ?l)
                       (holding ?d ?t)
                       (next-quantity ?q1 ?q2)
                       (capacity ?d ?q1)
                  )
    :effect (and (not (holding ?d ?t))
                 (not (capacity ?d ?q1))
                      (at-tank ?t ?l)
                      (capacity ?d ?q2)
                 ; (increase (total-cost) (other-cost )) ;; cost related effect. Hence commented out.
            )
  )

  (:action swim
    :parameters (?d - diver ?t - tank ?l1 ?l2 - location)
    :precondition (and (at-diver ?d ?l1)
                       (holding ?d ?t)
                       (full ?t)
                       (connected ?l1 ?l2)
                  )
    :effect (and (not (at-diver ?d ?l1))
                 (not (full ?t))
                      (at-diver ?d ?l2)
                 (not (decompressing ?d)) ;; Added to force decompress to be scheduled at the end of any plan requires the the diver to decompress.
                 ;; Without this additional effect a goal that requires a photo to be taken and the diver to decompress could be solved by entering the water
                 ;; then decompressing then getting back into the water then swim to the destination then to take a photo without swimming back to the cave-entrance
                 ;; and decompressing. IT IS IMPOIRTANT to highlight that these changes are required only because that we allowed the same diver to go back to the water.
                 ; (increase (total-cost) (other-cost )) ;; cost related effect. Hence commented out.
            )
  )

  (:action photograph
    :parameters (?d - diver ?l - location ?t - tank)
    :precondition (and (at-diver ?d ?l)
                       (holding ?d ?t)
                       (full ?t)
                  )
    :effect (and (not (full ?t))
                      (have-photo ?l)
                      (not (decompressing ?d)) ;; see comment of the same effect in the swim action
                 ; (increase (total-cost) (other-cost )) ;; cost related effect. Hence commented out.
            )
  )

  (:action decompress
    :parameters (?d - diver ?l - location)
    :precondition (and (at-diver ?d ?l)
                       (cave-entrance ?l)
                  )
    :effect (and (not (at-diver ?d ?l))
                      (decompressing ?d)
                 (not (in-water))
                 (at-surface ?d) ;;To enable the same diver to go back into the water we added at-surface as an effect of the decompress action. 
                 ;; look for the additional effects of (not (decompressing ?d)) 
                  ; that I added to swim and take photo to force decompress to be the last action in any plan
                 ; (increase (total-cost) (other-cost )) ;; cost related effect. Hence commented out.
            )
  )

)
