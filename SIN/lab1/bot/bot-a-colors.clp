(deffacts robot
    (grid 5 4)
    (warehouse blue 2 3)
    (warehouse red  4 1)
    (robot 1 3 blue 0 lamp 3 4 blue 3 lamp 4 2 red 2 lamp 5 4 blue 2 level 0)
    (max-level 50)
    (max-bulbs 3)
)

(defrule up
    (robot ?x ?y $?rest level ?l)
    (grid ?mx ?my)
    (max-level ?ml)
    (test (< ?y ?my))
    (test (< ?l ?ml))
=>
    (assert (robot ?x (+ ?y 1) $?rest level (+ ?l 1)))
)

(defrule down
    (robot ?x ?y $?rest level ?l)
    (grid ?mx ?my)
    (max-level ?ml)
    (test (> ?y 1))
    (test (< ?l ?ml))
=>
    (assert (robot ?x (- ?y 1) $?rest level (+ ?l 1)))
)

(defrule right
    (robot ?x ?y $?rest level ?l)
    (grid ?mx ?my)
    (max-level ?ml)
    (test (< ?x ?mx))
    (test (< ?l ?ml))
=>
    (assert (robot (+ ?x 1) ?y $?rest level (+ ?l 1)))
)

(defrule left
    (robot ?x ?y $?rest level ?l)
    (grid ?mx ?my)
    (max-level ?ml)
    (test (> ?x 1))
    (test (< ?l ?ml))
=>
    (assert (robot (- ?x 1) ?y $?rest level (+ ?l 1)))
)

(defrule load
    (robot ?x ?y ?oldcolor ?b $?lamps level ?l)
    (warehouse ?color ?x ?y)
    (max-bulbs ?mb)
    (max-level ?ml)
    (test (< ?l ?ml))
    (test (< ?b ?mb))
=>
    (assert (robot ?x ?y ?color ?mb $?lamps level (+ ?l 1)))
)

(defrule fix
    (robot ?x ?y ?color ?b $?lamps1 lamp ?x ?y ?color ?broken $?lamps2 level ?l)
    (max-level ?ml)
    (test (< ?l ?ml))
    (test (<= ?broken ?b))
=>
    (assert (robot ?x ?y ?color (- ?b ?broken) $?lamps1 $?lamps2 level (+ ?l 1)))
)

(defrule goal
    (declare (salience 10))
    (robot ?x ?y ?color ?b level ?l)
=>
    (printout t "Solution at level " ?l crlf)
    (halt)
)

(defrule lost
    (declare (salience -10))
=>
    (printout t "No solution" crlf)
    (halt)
)
