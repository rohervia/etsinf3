-- QUERIES USING 1 RELATION

-- Exercise 1
SELECT COUNT(*)
FROM disco;

-- Exercise 2
SELECT nombre
FROM grupo
WHERE pais <> 'España';

-- Exercise 3
SELECT titulo
FROM cancion
WHERE duracion > 5;

-- Exercise 4
SELECT DISTINCT funcion
FROM pertenece
ORDER BY funcion;

-- Exercise 5
SELECT nombre, num
FROM club
ORDER BY num;

-- Exercise 6
SELECT nombre, sede
FROM club
WHERE num > 500;


-- QUERIES USING MORE THAN 1 RELATION

-- Exercise 7
SELECT c.nombre, c.sede, g.nombre
FROM club c, grupo g
WHERE c.cod_gru = g.cod
AND g.pais = 'España';

-- Exercise 8
SELECT a.nombre
FROM artista a, grupo g, pertenece p
WHERE a.dni = p.dni
AND g.cod = p.cod
AND g.pais = 'España'
ORDER BY a.nombre;

-- Exercise 9
SELECT DISTINCT d.nombre
FROM disco d, esta e, cancion c
WHERE d.cod = e.cod
AND c.cod = e.can
AND c.duracion > 5
ORDER BY d.nombre;

-- Exercise 10
SELECT c.titulo
FROM disco d, esta e, cancion c
WHERE d.cod = e.cod AND e.can = c.cod
AND c.titulo = d.nombre
ORDER BY c.titulo;

-- Exercise 11
SELECT c.nombre, c.dir
FROM disco d, companyia c
WHERE d.cod_comp = c.cod
AND d.nombre LIKE 'A%';

-- Exercise 12
SELECT DISTINCT p1.dni
FROM pertenece p1, pertenece p2
WHERE p1.dni = p2.dni
AND p1.cod <> p2.cod;


-- QUERIES WITH SUBQUERIES

-- Exercise 13
SELECT nombre
FROM disco
WHERE cod_gru IN (
    SELECT cod
    FROM grupo
    WHERE fecha = (
        SELECT MIN(fecha)
        FROM grupo
    )
);

-- Exercise 14
SELECT nombre
FROM disco
WHERE cod_gru IN (
    SELECT cod_gru
    FROM club
    WHERE num > 5000
);

-- Exercise 15
SELECT nombre, num
FROM club
WHERE num = (
    SELECT MAX(num)
    FROM club
);

-- Exercise 16
SELECT titulo, duracion
FROM cancion
WHERE duracion = (
    SELECT MAX(duracion)
    FROM cancion
);


-- QUERIES WITH UNIVERSAL QUANTIFICATION

-- Exercise 17
SELECT nombre
FROM companyia
WHERE cod NOT IN (
    SELECT cod_comp
    FROM disco
    WHERE cod_gru IN (
        SELECT cod
        FROM grupo
        WHERE pais = 'España'
    )
);

-- Exercise 18
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

-- Exercise 19
SELECT nombre, dir
FROM companyia
WHERE cod IN (
    SELECT cod_comp
    FROM disco d1
    WHERE cod_gru IN (
        SELECT cod
        FROM grupo
        WHERE cod IN (
            SELECT cod_gru
            FROM disco d2
            WHERE d1.cod_comp = d2.cod_comp
        )
    )
) ORDER BY nombre;