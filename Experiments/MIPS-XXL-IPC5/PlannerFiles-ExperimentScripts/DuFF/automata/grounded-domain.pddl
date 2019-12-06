(define (domain grounded-FIRSTEXPERIMENTDOM)
(:requirements
:typing
:fluents
)
(:predicates
(ERROR)
)
(:functions
(INDEPENDENT_VARIABLE_3 )
(INDEPENDENT_VARIABLE_2 )
(INDEPENDENT_VARIABLE_1 )
(CRITICAL_VARIABLE )
)
(:action MAKE-ERROR
:parameters ()
:precondition
(and
(=  (CRITICAL_VARIABLE) 30.00)
)
:effect
(and
(ERROR)
)
)
(:action DECREASE-INDEPENDENT-3
:parameters ()
:precondition
(and
(>  (INDEPENDENT_VARIABLE_3) 0.00)
)
:effect
(and
(decrease (INDEPENDENT_VARIABLE_3) 1.00) 
)
)
(:action DECREASE-INDEPENDENT-2
:parameters ()
:precondition
(and
(>  (INDEPENDENT_VARIABLE_2) 0.00)
)
:effect
(and
(decrease (INDEPENDENT_VARIABLE_2) 1.00) 
)
)
(:action DECREASE-INDEPENDENT-1
:parameters ()
:precondition
(and
(>  (INDEPENDENT_VARIABLE_1) 0.00)
)
:effect
(and
(decrease (INDEPENDENT_VARIABLE_1) 1.00) 
)
)
(:action DECREASE-CRITICAL
:parameters ()
:precondition
(and
(>  (CRITICAL_VARIABLE) 0.00)
)
:effect
(and
(decrease (CRITICAL_VARIABLE) 1.00) 
)
)
(:action INCREASE-INDEPENDENT-3
:parameters ()
:precondition
(and
(<  (INDEPENDENT_VARIABLE_3) 31.00)
)
:effect
(and
(increase (INDEPENDENT_VARIABLE_3) 1.00) 
)
)
(:action INCREASE-INDEPENDENT-2
:parameters ()
:precondition
(and
(<  (INDEPENDENT_VARIABLE_2) 31.00)
)
:effect
(and
(increase (INDEPENDENT_VARIABLE_2) 1.00) 
)
)
(:action INCREASE-INDEPENDENT-1
:parameters ()
:precondition
(and
(<  (INDEPENDENT_VARIABLE_1) 31.00)
)
:effect
(and
(increase (INDEPENDENT_VARIABLE_1) 1.00) 
)
)
(:action INCREASE-CRITICAL
:parameters ()
:precondition
(and
(<  (CRITICAL_VARIABLE) 31.00)
)
:effect
(and
(increase (CRITICAL_VARIABLE) 1.00) 
)
)
)
