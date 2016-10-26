(deffacts robot
    (grid 5 4)
    (warehouse 2 3)
	(tunnel 2 3 5 4)
    (robot 1 3 0 lamp 3 4 3 lamp 4 2 2 lamp 5 4 2 level 0)
    (max-level 50)
    (max-bulbs 3)
)

(defrule tunnel
	(robot ?x ?y $?rest level ?l)
	(tunnel ?x ?y ?x2 ?y2)
	(max-level ?ml)
	(test (< ?l ?ml))
=>
	(assert (robot ?x2 ?y2 $?rest level (+ ?l 1)))
)

(defrule up
    (robot ?x ?y ?b $?lamps level ?l)
    (grid ?mx ?my)
    (max-level ?ml)
    (test (< ?y ?my))
    (test (< ?l ?ml))
=>
    (assert (robot ?x (+ ?y 1) ?b $?lamps level (+ ?l 1)))
)

(defrule down
    (robot ?x ?y ?b $?lamps level ?l)
    (grid ?mx ?my)
    (max-level ?ml)
    (test (> ?y 1))
    (test (< ?l ?ml))
=>
    (assert (robot ?x (- ?y 1) ?b $?lamps level (+ ?l 1)))
)

(defrule right
    (robot ?x ?y ?b $?lamps level ?l)
    (grid ?mx ?my)
    (max-level ?ml)
    (test (< ?x ?mx))
    (test (< ?l ?ml))
=>
    (assert (robot (+ ?x 1) ?y ?b $?lamps level (+ ?l 1)))
)

(defrule left
    (robot ?x ?y ?b $?lamps level ?l)
    (grid ?mx ?my)
    (max-level ?ml)
    (test (> ?x 1))
    (test (< ?l ?ml))
=>
    (assert (robot (- ?x 1) ?y ?b $?lamps level (+ ?l 1)))
)

(defrule load
    (robot ?x ?y ?b $?lamps level ?l)
    (warehouse ?x ?y)
    (max-bulbs ?mb)
    (max-level ?ml)
    (test (< ?l ?ml))
    (test (< ?b ?mb))
=>
    (assert (robot ?x ?y ?mb $?lamps level (+ ?l 1)))
)

(defrule fix
    (robot ?x ?y ?b $?lamps1 lamp ?x ?y ?broken $?lamps2 level ?l)
    (max-level ?ml)
    (test (< ?l ?ml))
    (test (<= ?broken ?b))
=>
    (assert (robot ?x ?y (- ?b ?broken) $?lamps1 $?lamps2 level (+ ?l 1)))
)

(defrule goal
    (declare (salience 10))
    (robot ?x ?y ?b level ?l)
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
