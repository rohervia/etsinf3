-- QUERIES USING 1 RELATION

-- Exercise 1
-- untested
SELECT COUNT(*)
FROM disco;

-- Exercise 2
-- untested
SELECT nombre
FROM grupo
WHERE pais <> 'España';

-- Exercise 3
-- untested
SELECT titulo
FROM cancion
WHERE duracion > 5;

-- Exercise 4
-- untested
SELECT DISTINCT funcion
FROM pertenece;

-- Exercise 5
-- untested
SELECT nombre, num
FROM club
ORDER BY num;

-- Exercise 6
-- untested
SELECT nombre, sede
FROM club
WHERE num > 500


-- QUERIES USING MORE THAN 1 RELATION

-- Exercise 7
-- untested
SELECT c.nombre, c.sede, g.nombre
FROM club c, grupo g
WHERE c.cod_gru = g.cod_gru;

-- Exercise 8
-- untested
SELECT a.nombre
FROM artista a, grupo g, pertenece p
WHERE a.dni = p.dni
AND g.cod_gru = p.cod_gru
AND g.pais = 'España';

-- Exercise 9
-- untested
SELECT d.nombre
FROM disco d, esta e, cancion c
WHERE d.cod = e.cod
AND c.can = e.can
AND c.duracion > 5
ORDER BY d.nombre;

-- Exercise 10
-- untested
SELECT c.titulo
FROM disco d, esta e, cancion c
WHERE d.cod = e.cod AND e.can = c.can
AND e.titulo = d.nombre;

-- Exercise 11
-- untested
SELECT c.nombre, c.direccion
FROM disco d, companyia c
WHERE d.cod_comp = c.cod
AND d.nombre LIKE 'A%';

-- Exercise 12
-- untested
SELECT p1.dni
FROM pertenece p1, pertenece p2
WHERE p1.dni = p2.dni
AND p1.cod <> p2.cod;


-- QUERIES WITH SUBQUERIES

-- Exercise 13
-- untested
SELECT nombre
FROM disco
WHERE cod_gru IN (
    SELECT cod
    FROM grupo
    WHERE fecha = (
        SELECT MAX(fecha)
        FROM grupo
    )
);

-- Exercise 14
-- untested
SELECT nombre
FROM disco
WHERE cod_gru IN (
    SELECT cod_gru
    FROM club
    WHERE num > 5000
);

-- Exercise 15
-- untested
SELECT nombre, num
FROM club
WHERE num = (
    SELECT MAX(num)
    FROM club
);

-- Exercise 16
-- untested
SELECT titulo, duracion
FROM cancion
WHERE duracion = (
    SELECT MAX(duracion)
    FROM cancion
);


-- QUERIES WITH UNIVERSAL QUANTIFICATION

-- Exercise 17
-- untested
SELECT nombre
FROM companyia
WHERE cod IN (
    SELECT cod_comp
    FROM disco
    WHERE cod_gru NOT IN (
        SELECT cod
        FROM grupo
        WHERE pais <> 'España'
    )
);

-- Exercise 18
-- untested
SELECT nombre
FROM companyia
WHERE cod IN (
    SELECT cod_comp
    FROM disco
    WHERE cod_gru IN (
        SELECT cod
        FROM grupo
        WHERE pais = 'España'
    )
) AND cod NOT IN (
    SELECT cod_comp
    FROM disco
    WHERE cod_gru IN (
        SELECT cod
        FROM grupo
        WHERE pais <> 'España'
    )
);

