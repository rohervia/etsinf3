(deffacts bot
    (grid 5 4)
    (max-bulbs 3)
    (warehouse 2 3)
    (robot 1 3 0 lamp 3 4 3 lamp 4 2 2 lamp 5 4 2))


(defrule right
    (robot ?x ?y $?z)
    (grid ?mx ?my)
    (test (< ?x ?mx))
=>
    (assert (robot (+ 1 ?x) ?y $?z)))

(defrule left
    (robot ?x ?y $?z)
    (test (> ?x 1))
=>
    (assert (robot (- 1 ?x) ?y $?z)))

(defrule up
    (robot ?x ?y $?z)
    (grid ?mx ?my)
    (test (< ?y ?my))
=>
    (assert (robot ?x (+ 1 ?y) $?z)))

(defrule down
    (robot ?x ?y $?z)
    (grid ?mx ?my)
    (test (> ?y 1))
=>
    (assert (robot ?x (- 1 ?y) $?z)))


(defrule load
    (robot ?x ?y ?b $?z)
    (warehouse ?x ?y)
    (max-bulbs ?mb)
    (test (< ?b ?mb))
=>
    (assert(robot ?x ?y ?mb $?z)))

(defrule replace
    (robot ?x ?y ?b1 $?rest1 lamp ?x ?y ?b2 $?rest2)
    (test (>= ?b1 ?b2))
=>
    (assert (robot ?x ?y (- ?b1 ?b2) $?rest1 $?rest2)))

(defrule goal
    (robot ?x ?y ?)
=>
    (printout t "All lamps fixed!" crlf)
    (halt))
