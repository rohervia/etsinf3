-- QUERIES USING 1 RELATION

-- Exercise 1
SELECT DISTINCT cod_pais
FROM cs_actor
ORDER BY cod_pais;

-- Exercise 2
SELECT cod_peli, titulo
FROM cs_pelicula
WHERE cod_lib IS NULL
AND anyo < 1970
ORDER BY titulo;

-- Exercise 3
SELECT cod_act, nombre
FROM cs_actor
WHERE nombre LIKE '%John%';

-- Exercise 4
SELECT cod_peli, titulo
FROM cs_pelicula
WHERE duracion > 120
AND anyo >= 1980
AND anyo < 1990;

-- Exercise 5
SELECT cod_peli, titulo
FROM cs_pelicula
WHERE director LIKE '% Pakula'
AND cod_lib IS NOT NULL;

-- Exercise 6
SELECT COUNT(*)
FROM cs_pelicula
WHERE duracion > 120
AND anyo >= 1980
AND anyo < 1990;

-- Exercise 7
SELECT COUNT(DISTINCT cod_peli) CUÁNTAS_PELIS
FROM cs_clasificacion
WHERE cod_gen = 'BB5'
OR cod_gen = 'GG4'
OR cod_gen = 'JH6';

-- Exercise 8
SELECT MIN(anyo)
FROM cs_libro;

-- Exercise 9
SELECT AVG(duracion) DURACIÓN_MEDIA
FROM cs_pelicula
WHERE anyo = 1987;

-- Exercise 10
SELECT MIN(duracion) DURAN_MIN
FROM cs_pelicula
WHERE director = 'Steven Spielberg';


-- QUERIES USING MORE THAN 1 RELATION

-- Exercise 11
SELECT p.cod_peli, p.titulo
FROM cs_pelicula p, cs_actua x, cs_actor a
WHERE p.director = a.nombre
AND x.cod_peli = p.cod_peli
AND a.cod_act = x.cod_act
ORDER BY p.titulo;

-- Exercise 12
SELECT p.cod_peli, p.titulo
FROM cs_pelicula p, cs_clasificacion c, cs_genero g
WHERE g.nombre = 'Comedia'
AND g.cod_gen = c.cod_gen
AND c.cod_peli = p.cod_peli
ORDER BY p.titulo;

-- Exercise 13
SELECT p.cod_peli, p.titulo
FROM cs_pelicula p, cs_libro l
WHERE l.cod_lib = p.cod_lib
AND l.anyo < 1950
ORDER BY p.titulo;

-- Exercise 14
SELECT DISTINCT p.cod_pais, p.nombre
FROM cs_pais p, cs_actor a, cs_actua x, cs_clasificacion c, cs_genero g
WHERE g.nombre = 'Comedia'
AND g.cod_gen = c.cod_gen
AND c.cod_peli = x.cod_peli
AND x.cod_act = a.cod_act
AND a.cod_pais = p.cod_pais
ORDER BY p.nombre;


-- QUERIES WITH SUBQUERIES

-- Exercise 15 (reformulate 11 through 14)
SELECT p.cod_peli, p.titulo
FROM cs_pelicula p
WHERE p.director IN (
    SELECT a.nombre
    FROM cs_actor a
    WHERE a.cod_act IN (
        SELECT x.cod_act
        FROM cs_actua x
        WHERE x.cod_peli = p.cod_peli
    )
) ORDER BY p.titulo;

SELECT p.cod_peli, p.titulo
FROM cs_pelicula p
WHERE p.cod_peli IN (
    SELECT c.cod_peli
    FROM cs_clasificacion c
    WHERE c.cod_gen IN (
        SELECT g.cod_gen
        FROM cs_genero g
        WHERE g.nombre = 'Comedia'
    )
) ORDER BY p.titulo;

SELECT DISTINCT p.cod_peli, p.titulo
FROM cs_pelicula p
WHERE p.cod_lib IN (
    SELECT cod_lib
    FROM cs_libro
    WHERE anyo < 1950
) ORDER BY p.titulo;

SELECT cod_pais, nombre
FROM cs_pais
WHERE cod_pais IN (
    SELECT cod_pais
    FROM cs_actor
    WHERE cod_act IN (
        SELECT cod_act
        FROM cs_actua
        WHERE cod_peli IN (
            SELECT cod_peli
            FROM cs_clasificacion
            WHERE cod_gen IN (
                SELECT cod_gen
                FROM cs_genero
                WHERE nombre = 'Comedia'
            )
        )
    )
) ORDER BY nombre;

-- Exercise 16
SELECT DISTINCT cod_act, nombre
FROM cs_actor
WHERE fecha_nac < '01/01/1950'
AND cod_act IN (
    SELECT cod_act
    FROM cs_actua
    WHERE papel = 'Principal'
) ORDER BY nombre;

-- Exercise 17
SELECT cod_lib, titulo, autor
FROM cs_libro
WHERE cod_lib IN (
    SELECT cod_lib
    FROM cs_pelicula
    WHERE anyo >= 1990
    AND anyo < 2000
) ORDER BY titulo;

-- Exercise 18
SELECT cod_lib, titulo, autor
FROM cs_libro
WHERE cod_lib NOT IN (
    SELECT cod_lib
    FROM cs_pelicula
    WHERE cod_lib IS NOT NULL
);

-- Exercise 19
SELECT nombre
FROM cs_genero
WHERE cod_gen IN (
    SELECT cod_gen
    FROM cs_clasificacion
    WHERE cod_peli NOT IN ( -- reask myself why
        SELECT cod_peli
        FROM cs_actua
    )
) ORDER BY nombre;

-- Exercise 20
SELECT titulo
FROM cs_libro
WHERE cod_lib IN (
    SELECT cod_lib
    FROM cs_pelicula
    WHERE cod_lib IS NOT NULL
    AND cod_peli NOT IN (
        SELECT cod_peli
        FROM cs_actua
        WHERE cod_act IN (
            SELECT cod_act
            FROM cs_actor
            WHERE cod_pais IN (
                SELECT cod_pais
                FROM cs_pais
                WHERE nombre = 'USA'
            )
        )
    )
) ORDER BY titulo;

-- Exercise 21
SELECT COUNT(cod_peli)
FROM cs_pelicula
WHERE cod_peli IN (
    SELECT cod_peli
    FROM cs_clasificacion
    WHERE cod_gen IN (
        SELECT cod_gen
        FROM cs_genero
        WHERE nombre = 'Comedia'
    )
) AND 1 = (
    SELECT COUNT(cod_act)
    FROM cs_actua
    WHERE cs_actua.cod_peli = cs_pelicula.cod_peli
    AND papel = 'Secundario'
);

-- Exercise 22
SELECT MIN(anyo)
FROM cs_pelicula
WHERE cod_peli IN (
    SELECT cod_peli
    FROM cs_actua
    WHERE papel = 'Principal'
    AND cod_act IN (
        SELECT cod_act
        FROM cs_actor
        WHERE nombre = 'Jude Law'
    )
);

-- Exercise 23
SELECT cod_act, nombre
FROM cs_actor
WHERE fecha_nac <= ALL (
    SELECT fecha_nac
    FROM cs_actor
);

-- Exercise 24
SELECT cod_act, nombre, fecha_nac
FROM cs_actor
WHERE fecha_nac <= ALL (
    SELECT fecha_nac
    FROM cs_actor
    WHERE fecha_nac >= '01/01/1940'
) AND fecha_nac >= '01/01/1940';

-- Exercise 25
SELECT nombre
FROM cs_genero
WHERE cod_gen IN (
    SELECT cod_gen
    FROM cs_clasificacion
    WHERE cod_peli IN (
        SELECT cod_peli
        FROM cs_pelicula
        WHERE duracion >= ALL (
            SELECT duracion
            FROM cs_pelicula
        )
    )
) ORDER BY nombre;

-- Exercise 26
SELECT cod_lib, titulo
FROM cs_libro
WHERE cod_lib IN (
    SELECT cod_lib
    FROM cs_pelicula
    WHERE cod_peli IN (
        SELECT cod_peli
        FROM cs_actua
        WHERE cod_act IN (
            SELECT cod_act
            FROM cs_actor
            WHERE cod_pais IN (
                SELECT cod_pais
                FROM cs_pais
                WHERE nombre = 'España'
            )
        )
    )
) ORDER BY titulo;

-- Exercise 27
SELECT titulo
FROM cs_pelicula
WHERE anyo < 1950
AND 1 < (
    SELECT COUNT(cod_gen)
    FROM cs_clasificacion
    WHERE cs_clasificacion.cod_peli = cs_pelicula.cod_peli
) ORDER BY titulo;

-- Exercise 28
SELECT COUNT(*)
FROM cs_pelicula p
WHERE 4 > (
    SELECT COUNT(DISTINCT cod_act)
    FROM cs_actua
    WHERE p.cod_peli = cs_actua.cod_peli
);

-- Exercise 29
SELECT DISTINCT director
FROM cs_pelicula
WHERE 250 < (
    SELECT SUM(duracion)
    FROM cs_pelicula p2
    WHERE cs_pelicula.director = p2.director
);

-- Exercise 30
SELECT DISTINCT EXTRACT(YEAR FROM a.fecha_nac)
FROM cs_actor a
WHERE 3 < (
    SELECT COUNT(a2.cod_act)
    FROM cs_actor a2
    WHERE EXTRACT(YEAR FROM a.fecha_nac) = EXTRACT(YEAR FROM a2.fecha_nac)
);

-- Exercise 30 - advanced version with grouping
SELECT DISTINCT EXTRACT(YEAR FROM fecha_nac) y
FROM cs_actor
GROUP BY EXTRACT(YEAR FROM fecha_nac)
HAVING COUNT(EXTRACT(YEAR FROM fecha_nac)) > 3;

-- Exercise 31
SELECT cod_act, nombre
FROM cs_actor
WHERE fecha_nac = (
    SELECT MAX(fecha_nac)
    FROM cs_actor
    WHERE cod_act IN (
        SELECT cod_act
        FROM cs_actua
        WHERE cod_peli IN (
            SELECT cod_peli
            FROM cs_clasificacion
            WHERE cod_gen = 'DD8'
        )
    )
);


-- QUERIES WITH UNIVERSAL QUANTIFICACION

-- Exercise 32 (century in this exercise means 1900-1999, not 1901-2000)
SELECT cod_pais, nombre
FROM cs_pais
WHERE NOT EXISTS (
    SELECT *
    FROM cs_actor
    WHERE (fecha_nac < '01/01/1900' OR fecha_nac >= '01/01/2000')
    AND cs_actor.cod_pais = cs_pais.cod_pais
) AND EXISTS ( -- check if there is at least 1 actor from that place
    SELECT *
    FROM cs_actor
    WHERE cs_actor.cod_pais = cs_pais.cod_pais
) ORDER BY nombre;

-- Exercise 33
-- for all actua, actua actor Secundario peli
-- there doesn't exist a movie they have acted in which they were another role
-- and they have acted in some movie
SELECT a.cod_act, a.nombre
FROM cs_actor a
WHERE EXISTS (
    SELECT *
    FROM cs_actua x2
    WHERE x2.cod_act = a.cod_act
) AND NOT EXISTS (
    SELECT *
    FROM cs_actua x
    WHERE x.cod_act = a.cod_act
    AND x.papel <> 'Secundario'
) ORDER BY a.nombre;

-- Exercise 34
-- for all movies directed by guy ritchie, actor in movie
-- There is no movie directed by guy in which this actor hasn't appeared
-- and guy has directed at least one movie...
SELECT a.cod_act, a.nombre
FROM cs_actor a
WHERE EXISTS (
    SELECT *
    FROM cs_pelicula
    WHERE director = 'Guy Ritchie'
    AND cod_peli IN (
        SELECT cod_peli
        FROM cs_actua x2
        WHERE x2.cod_act = a.cod_act
    )
) AND NOT EXISTS (
    SELECT *
    FROM cs_pelicula p
    WHERE cod_peli NOT IN (
        SELECT cod_peli
        FROM cs_actua x
        WHERE x.cod_act = a.cod_act
    ) AND p.director = 'Guy Ritchie'
);

-- Exercise 35
SELECT a.cod_act, a.nombre
FROM cs_actor a
WHERE EXISTS (
    SELECT *
    FROM cs_pelicula
    WHERE director = 'John Steel'
    AND cod_peli IN (
        SELECT cod_peli
        FROM cs_actua x2
        WHERE x2.cod_act = a.cod_act
    )
) AND NOT EXISTS (
    SELECT *
    FROM cs_pelicula p
    WHERE cod_peli NOT IN (
        SELECT cod_peli
        FROM cs_actua x
        WHERE x.cod_act = a.cod_act
    ) AND p.director = 'John Steel'
);

-- Exercise 36
-- For all the actors, the country is the same
-- There is no actor whose country is different
SELECT p.cod_peli, p.titulo
FROM cs_pelicula p
WHERE p.duracion < 100
AND p.cod_peli IN (
    SELECT x.cod_peli
    FROM cs_actua x
    WHERE x.cod_act IN (
        SELECT a1.cod_act
        FROM cs_actor a1
        WHERE NOT EXISTS (
            SELECT *
            FROM cs_actor a2
            WHERE a2.cod_pais <> a1.cod_pais
            AND a2.cod_act IN (
                SELECT x2.cod_act
                FROM cs_actua x2
                WHERE x2.cod_peli = p.cod_peli
            )
        )
    )
);

-- Exercise 37
-- all actors in a movie must be born before 1943
-- no actor must be acting and be born before 1943
SELECT cod_peli, titulo, anyo
FROM cs_pelicula
WHERE EXISTS (
    SELECT *
    FROM cs_actua
    WHERE cs_actua.cod_peli = cs_pelicula.cod_peli
) AND NOT EXISTS (
    SELECT *
    FROM cs_actua
    WHERE cs_actua.cod_peli = cs_pelicula.cod_peli
    AND cod_act IN (
        SELECT cod_act
        FROM cs_actor
        WHERE fecha_nac >= '01/01/1943'
    )
) ORDER BY titulo;

-- Exercise 38
-- country so that all actors from there have acted in 1 film >120min
-- country so that no one hasn't acted in a film with duration >120min
SELECT cod_pais, nombre
FROM cs_pais
WHERE NOT EXISTS (
    SELECT *
    FROM cs_actor
    WHERE cs_actor.cod_pais = cs_pais.cod_pais
    AND cod_act NOT IN (
        SELECT cod_act
        FROM cs_actua
        WHERE cod_peli IN (
            SELECT cod_peli
            FROM cs_pelicula
            WHERE duracion > 120
        )
    )
) AND EXISTS (
    SELECT *
    FROM cs_actor
    WHERE cs_actor.cod_pais = cs_pais.cod_pais
    AND cod_act IN (
        SELECT cod_act
        FROM cs_actua
    )
) ORDER BY nombre;


-- QUERIES WITH GROUP BY

-- Exercise 39
SELECT l.cod_lib, l.titulo, COUNT(p.cod_lib) CUÁNTAS
FROM cs_libro l, cs_pelicula p
WHERE l.cod_lib = p.cod_lib
GROUP BY l.cod_lib, l.titulo
HAVING COUNT(p.cod_lib) > 1;

-- Exercise 40
SELECT g.cod_gen, g.nombre, COUNT(c.cod_gen) CUÁNTAS, ROUND(AVG(p.duracion)) DUR_MEDI
FROM cs_genero g, cs_clasificacion c, cs_pelicula p
WHERE g.cod_gen = c.cod_gen
AND c.cod_peli = p.cod_peli
GROUP BY g.cod_gen, g.nombre
HAVING COUNT(c.cod_peli) > 5
ORDER BY g.nombre;

-- Exercise 41
SELECT p.cod_peli, p.titulo, COUNT(c.cod_gen)
FROM cs_clasificacion c, cs_pelicula p
WHERE p.anyo > 2000
AND p.cod_peli = c.cod_peli
GROUP BY p.cod_peli, p.titulo
HAVING COUNT(c.cod_gen) > 0
ORDER BY p.titulo;

-- Exercise 42
SELECT director
FROM cs_pelicula
WHERE director LIKE '%George%'
GROUP BY director
HAVING COUNT(cod_peli) = 2;

-- Exercise 43
SELECT p.cod_peli, p.titulo, COUNT(x.cod_act) CUÁNTOS
FROM cs_pelicula p, cs_clasificacion c, cs_actua x
WHERE p.cod_peli = c.cod_peli
AND p.cod_peli = x.cod_peli
GROUP BY p.cod_peli, p.titulo
HAVING COUNT(DISTINCT c.cod_gen) = 1 -- why do I need here distinct? because multiple actors
AND COUNT(x.cod_act) > 0
ORDER BY p.titulo;

-- Exercise 44
SELECT p.cod_pais, p.nombre, COUNT(DISTINCT a.cod_act) CUANTOS
FROM cs_pais p, cs_actor a, cs_actua x, cs_pelicula pe
WHERE p.cod_pais = a.cod_pais
AND a.cod_act = x.cod_act
AND pe.cod_peli = x.cod_peli
AND pe.anyo >= 1960
AND pe.anyo <  1970
GROUP BY p.cod_pais, p.nombre
HAVING COUNT(DISTINCT a.cod_act) > 0
ORDER BY p.nombre;

-- Exercise 45
SELECT g.cod_gen, g.nombre
FROM cs_genero g, cs_clasificacion c
WHERE g.cod_gen = c.cod_gen
GROUP BY g.cod_gen, g.nombre
HAVING COUNT(DISTINCT c.cod_peli) >= ALL (
    SELECT COUNT(DISTINCT cod_peli)
    FROM cs_clasificacion
    GROUP BY cod_gen
);

-- Exercise 46
SELECT l.cod_lib, l.titulo, l.autor
FROM cs_libro l, cs_pelicula p
WHERE l.cod_lib = p.cod_lib
GROUP BY l.cod_lib, l.titulo, l.autor
HAVING COUNT(p.cod_peli) >= ALL (
    SELECT COUNT(cod_peli)
    FROM cs_pelicula
    WHERE cod_lib IS NOT NULL
    GROUP BY cod_lib
);

-- Exercise 47
-- not working
SELECT p.cod_pais, p.nombre
FROM cs_pais p, cs_actor a, cs_actua x, cs_pelicula pe
WHERE p.cod_pais = a.cod_pais
AND a.cod_act = x.cod_act
AND pe.cod_peli = x.cod_peli
GROUP BY p.cod_pais, p.nombre
HAVING MAX(DISTINCT a.cod_act)
AND COUNT(x.cod_peli) = 2;

-- Exercise 48
SELECT EXTRACT(YEAR FROM fecha_nac) AÑO, COUNT(cod_act) NUM_ACTORES
FROM cs_actor
GROUP BY EXTRACT(YEAR FROM fecha_nac)
HAVING COUNT(cod_act) > 3;

-- Exercise 49 - redo 36
SELECT p.cod_peli, p.titulo
FROM cs_pelicula p, cs_actua x, cs_actor a
WHERE p.cod_peli = x.cod_peli
AND x.cod_act = a.cod_act
AND p.duracion < 100
GROUP BY p.cod_peli, p.titulo
HAVING COUNT(DISTINCT a.cod_pais) = 1;


-- QUERIES WITH DIFFERENT JOINS

-- Exercise 50
-- untested
SELECT cod_pais, nombre, COUNT(cod_act)
FROM cs_pais LEFT JOIN cs_actor USING (cod_pais)
GROUP BY cod_pais, nombre
ORDER BY nombre;

-- Exercise 51
-- untested
SELECT cod_lib, titulo, COUNT(cod_peli)
FROM cs_libro LEFT JOIN cs_pelicula USING (cod_lib)
GROUP BY cod_lib, titulo;

-- Exercise 52
-- untested
SELECT cod_pais, nombre, COUNT(cod_act)
FROM (cs_pais LEFT JOIN cs_actor USING (cod_pais)) NATURAL JOIN cs_actua
WHERE papel = 'Secundario'
GROUP BY cod_pais, nombre
ORDER BY nombre;

-- Exercise 53
-- untested
SELECT cod_peli, titulo, COUNT(cod_gen) GEN, COUNT(cod_act)
FROM (cs_pelicula NATURAL JOIN cs_clasificacion) NATURAL JOIN cs_actua
WHERE duracion > 140
GROUP BY cod_peli, titulo
ORDER BY titulo;


-- QUERIES WITH SET OPERATIONS

-- Exercise 54
-- not begun


-- OTHER QUERIES

-- Exercise 55
-- not begun

-- Exercise 56
-- not begun
