(deffacts bulb_robot
    (grid 5 4)
    (warehouse 2 3)
    (max-level 1000)
    (max-bulb 3)
    (robot 1 3 0 lamp 3 4 3 lamp 4 2 2 lamp 5 6 2 level 0))

(defrule left
    ?f <- (robot ?x $?m level ?l)
    (test (> ?x 1))
    (max-level ?max)
    (test (<= ?l ?max))
=>
    (assert (robot (- ?x 1) $?m level (+ 1 ?l))))

(defrule right
    ?f <- (robot ?x $?m level ?l)
    (grid ?a ?)
    (test (< ?x ?a))
    (max-level ?max)
    (test (<= ?l ?max))
=>
    (assert (robot (+ ?x 1) $?m level (+ 1 ?l))))

(defrule down
    ?f <- (robot ?x ?y $?m level ?l)
    (test (> ?y 1))
    (max-level ?max)
    (test (<= ?l ?max))
=>
    (assert (robot ?x (- ?y 1) $?m level (+ 1 ?l))))

(defrule up
    ?f <- (robot ?x ?y $?m level ?l)
    (grid ? ?b)
    (test (< ?y ?b))
    (max-level ?max)
    (test (<= ?l ?max))
=>
    (assert (robot ?x (+ ?y 1) $?m level (+ 1 ?l))))

(defrule load
    (declare (salience 5))
    ?f <- (robot ?x ?y ?a $?m level ?l)
    (warehouse ?x ?y)
    (max-bulb ?mb)
    (test (< ?a ?mb))
    (max-level ?max)
=>
    (assert (robot ?x ?y ?mb $?m level (+ 1 ?l))))

(defrule replace
    (declare (salience 5))
    ?f <- (robot ?x ?y ?a $?u lamp ?x ?y ?b $?v level ?l)
    (test (>= ?a ?b))
    (max-level ?max)
    (test (<= ?l ?max))
=>
    (assert (robot ?x ?y (- ?a ?b) $?u $?v level (+ 1 ?l))))

(defrule dupl
    (declare (salience 15))
    ?f <- (robot $?data level ?l1)
    ?g <- (robot $?data level ?l2)
    (!= ?l1 ?l2)
=>
    (if (< ?l1 ?l2) then
        (retract ?g)
        else
        (retract ?f)))

(defrule goal
    (declare (salience 10))
    (robot ? ? ?a level ?l)
=>
    (printout t "Number of steps " ?l)
    (halt))

(defrule lost
    (declare (salience -10))
    (robot $? level ?l)
=>
    (printout t "Couldn't reach solution" crlf)
    (halt))
