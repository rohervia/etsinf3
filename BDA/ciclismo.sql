-- QUERIES USING 1 RELATION

-- Exercise 1
SELECT codigo, tipo, color, premio
FROM maillot;

-- Exercise 2
SELECT dorsal, nombre
FROM ciclista
WHERE edad <= 25;

-- Exercise 3
SELECT nompuerto, altura
FROM puerto
WHERE categoria = 'E';

-- Exercise 4
SELECT netapa
FROM etapa
WHERE salida = llegada;

-- Exercise 5
SELECT COUNT(*)
FROM ciclista;

-- Exercise 6
SELECT COUNT(*)
FROM ciclista
WHERE edad > 25;

-- Exercise 7
SELECT COUNT(*)
FROM equipo;

-- Exercise 8
SELECT AVG(edad)
FROM ciclista;

-- Exercise 9
SELECT MIN(altura), MAX(altura)
FROM puerto;


-- QUERIES USING MORE THAN 1 RELATION

-- Exercise 10
SELECT nompuerto, categoria C
FROM puerto, ciclista
WHERE puerto.dorsal = ciclista.dorsal
AND nomeq = 'Banesto';

-- Exercise 11
SELECT nompuerto, puerto.netapa, km
FROM puerto, etapa
WHERE puerto.netapa = etapa.netapa;

-- Exercise 12
SELECT DISTINCT equipo.nomeq, director
FROM equipo, ciclista
WHERE equipo.nomeq = ciclista.nomeq
AND edad > 33;

-- Exercise 13
SELECT DISTINCT nombre, color
FROM ciclista c, llevar l, maillot m
WHERE c.dorsal = l.dorsal
AND l.codigo = m.codigo
ORDER BY nombre;

-- Exercise 14
SELECT DISTINCT c.nombre, e.netapa
FROM etapa e, ciclista c, llevar l, maillot m
WHERE e.dorsal = c.dorsal
AND c.dorsal = l.dorsal
AND l.codigo = m.codigo
AND color = 'Amarillo'
ORDER BY c.nombre;

-- Exercise 15
SELECT e.netapa
FROM etapa e, etapa e2
WHERE e2.netapa = e.netapa - 1
AND e2.llegada <> e.salida;


-- QUERIES WITH SUBQUERIES

-- Exercise 16
SELECT netapa, salida
FROM etapa
WHERE netapa NOT IN (
    SELECT netapa
    FROM puerto
);

-- Exercise 17
SELECT AVG(edad)
FROM ciclista
WHERE dorsal IN (
    SELECT dorsal
    FROM etapa
);

-- Exercise 18
SELECT nompuerto
FROM puerto
WHERE altura > (
    SELECT AVG(altura)
    FROM puerto
);

-- Exercise 19
SELECT salida, llegada
FROM etapa
WHERE netapa IN (
    SELECT netapa
    FROM puerto
    WHERE pendiente = (
        SELECT MAX(pendiente)
        FROM puerto
    )
);

-- Exercise 20
SELECT dorsal, nombre
FROM ciclista
WHERE dorsal IN (
    SELECT dorsal
    FROM puerto
    WHERE altura = (
        SELECT MAX(altura)
        FROM puerto
    )
);

-- Exercise 21
SELECT nombre
FROM ciclista
WHERE edad = (
    SELECT MIN(edad)
    FROM ciclista
);

-- Exercise 22
SELECT nombre
FROM ciclista
WHERE dorsal IN (
    SELECT dorsal
    FROM etapa
) AND edad = (
    SELECT MIN(edad)
    FROM ciclista
    WHERE dorsal IN (
        SELECT dorsal
        FROM etapa
    )
);

-- Exercise 23
SELECT nombre
FROM ciclista
WHERE 1 < (
    SELECT COUNT(nompuerto)
    FROM puerto
    WHERE dorsal = ciclista.dorsal
);


-- QUERIES WITH UNIVERSAL QUANTIFICATION

-- Exercise 24
SELECT DISTINCT netapa
FROM etapa
WHERE NOT EXISTS (
    SELECT *
    FROM puerto
    WHERE etapa.netapa = netapa
    AND altura <= 700
) AND EXISTS (
    SELECT *
    FROM puerto
    WHERE etapa.netapa = netapa
) ORDER BY netapa;

-- Exercise 25
-- untested
SELECT nomeq, director
FROM equipo
WHERE NOT EXISTS (
    SELECT *
    FROM ciclista
    WHERE nomeq = equipo.nomeq
    AND edad <= 25
);

-- Exercise 26
-- untested
SELECT dorsal, nombre
FROM ciclista
WHERE NOT EXISTS (
    SELECT *
    FROM etapa
    WHERE dorsal = ciclista.dorsal
    AND km <= 170
);


-- Exercise 27
-- untested
SELECT nombre
FROM ciclista
WHERE dorsal IN (
    SELECT dorsal
    FROM etapa
    WHERE NOT EXISTS (
        SELECT *
        FROM puerto
        WHERE netapa = etapa.netapa
        AND dorsal <> ciclista.dorsal
    )
);

-- Exercise 28
-- untested
SELECT nomeq
FROM equipo
WHERE NOT EXISTS (
    SELECT *
    FROM ciclista
    WHERE dorsal NOT IN (
        SELECT dorsal
        FROM llevar
    ) AND dorsal NOT IN (
        SELECT dorsal
        FROM puerto
    )
);

-- Exercise 29
-- untested
SELECT codigo, color
FROM maillot
WHERE codigo IN (
    SELECT codigo
    FROM llevar
    WHERE dorsal IN (
        SELECT dorsal
        FROM ciclista c
        WHERE NOT EXISTS (
            SELECT *
            FROM ciclista
            WHERE dorsal IN (
                SELECT dorsal
                FROM llevar
                WHERE codigo = maillot.codigo
            ) AND nomeq <> c.nomeq
        )
    )
);

-- Exercise 30
-- untested
SELECT nomeq
FROM equipo
WHERE NOT EXISTS (
    SELECT *
    FROM ciclista
    WHERE nomeq = equipo.nomeq
    AND dorsal IN (
        SELECT dorsal
        FROM puerto
        WHERE categoria <> 1
    )
);


-- QUERIES WITH GROUP BY

-- Exercise 31
-- untested


-- OTHER QUERIES

-- Exercise 40
SELECT dorsal, nombre
FROM ciclista
WHERE EXISTS (
    SELECT *
    FROM llevar
    WHERE dorsal = 20
    AND codigo NOT IN (
        SELECT codigo
        FROM llevar
        WHERE ciclista.dorsal = dorsal
    )
);
