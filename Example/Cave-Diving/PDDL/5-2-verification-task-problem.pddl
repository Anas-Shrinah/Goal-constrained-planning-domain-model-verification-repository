;; Goal-constrained planning domain model verification of safety properties.
;; Anas Shrinah and Kerstin Eder.
;; Section 5 - verification task 2.
;; A modified version of the Cave Diving ADL by Nathan Robinson,Christian Muise, and Charles Gretton;;
;; Verification with safety property and incomplete goal (mission target only).
;; The safety property: diver has no full tanks, the dive is not at the entrance, and the location, where the diver is, has no full tanks.
;; The incomplete goal is to only have a photo of the first location.
;; MIPS-XXL returns unreachable counterexample: <prepare-tank, prepare-tank, enter-water, swim(L0 , L1 ), take-photo*/

(define (problem cave-diving-adl-p01)
  (:domain cave-diving-adl)
  (:objects
    l0 l1 l2 - location
    d0  - diver
    t0 t1 t2 t3 t4 dummy - tank
    zero one two three four - quantity
  )

  (:init
    (at-surface d0)

    (capacity d0 four)

    (in-storage t0)
    (next-tank t0 t1)
    (next-tank t1 t2)
    (next-tank t2 t3)
    (next-tank t3 dummy)

    (cave-entrance l0)
    (connected l0 l1)
    (connected l1 l0)
    (connected l1 l2)

    (next-quantity zero one)
    (next-quantity one two)
    (next-quantity two three)
    (next-quantity three four)
  )

  (:goal
    (and
       (have-photo l1)
    )
  )
  (:constraints
    (and
      (sometime  
      (and
      (not (at-diver d0 l0)) (not (at-surface d0)) (not (full t0)) (not (full t1)) (not (full t2)) (not (full t3)) ))


    )
  )


)
