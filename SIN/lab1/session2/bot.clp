(deffacts bot
    (grid 5 4)
    (max-bulbs 3)
    (warehouse 2 3)
    (robot 1 3 0 lamp 3 4 3 lamp 4 2 2 lamp 5 4 2 level 0))


(defrule right
    (robot ?x ?y $?z level ?l)
    (grid ?mx ?my)
    (test (< ?x ?mx))
=>
    (assert (robot (+ 1 ?x) ?y $?z level (+ 1 ?l))))

(defrule left
    (robot ?x ?y $?z level ?l)
    (test (> ?x 1))
=>
    (assert (robot (- ?x 1) ?y $?z level (+ 1 ?l))))

(defrule up
    (robot ?x ?y $?z level ?l)
    (grid ?mx ?my)
    (test (< ?y ?my))
=>
    (assert (robot ?x (+ 1 ?y) $?z level (+ 1 ?l))))

(defrule down
    (robot ?x ?y $?z level ?l)
    (grid ?mx ?my)
    (test (> ?y 1))
=>
    (assert (robot ?x (- ?y 1) $?z level (+ 1 ?l))))


(defrule load
        (declare (salience 10))
    (robot ?x ?y ?b $?z level ?l)
    (warehouse ?x ?y)
    (max-bulbs ?mb)
    (test (< ?b ?mb))
=>
    (assert(robot ?x ?y ?mb $?z level (+ 1 ?l))))

(defrule replace
    (declare (salience 10))
    (robot ?x ?y ?b1 $?rest1 lamp ?x ?y ?b2 $?rest2 level ?l)
    (test (>= ?b1 ?b2))
=>
    (assert (robot ?x ?y (- ?b1 ?b2) $?rest1 $?rest2 level (+ 1 ?l))))

(defrule duplicate
    (declare (salience 50))
    ?f <- (robot $?rest level ?l1)
    ?g <- (robot $?rest level ?l2)
    (test (!= ?l1 ?l2))
=>
    (if (< ?l1 ?l2) then
        (retract ?g)
    else
        (retract ?f)))

(defrule goal
    (declare (salience 99))
    (robot ?x ?y ? level ?l)
=>
    (printout t "All lamps fixed! At level " ?l crlf)
    (halt))
