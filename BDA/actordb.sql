-- Exercise 7
SELECT COUNT(DISTINCT CS_PELICULA.COD_PELI) CUANTAS_PELIS
FROM CS_PELICULA, CS_CLASIFICACION
WHERE CS_PELICULA.COD_PELI = CS_CLASIFICACION.COD_PELI
AND (
    COD_GEN = 'BB5'
    OR COD_GEN = 'GG4'
    OR COD_GEN = 'JH6'
);

-- Exercise 14
SELECT DISTINCT CS_PAIS.COD_PAIS, CS_PAIS.NOMBRE
FROM CS_PELICULA, CS_PAIS, CS_ACTUA, CS_ACTOR, CS_CLASIFICACION, CS_GENERO
WHERE CS_PELICULA.COD_PELI = CS_ACTUA.COD_PELI
AND CS_ACTUA.COD_ACT = CS_ACTOR.COD_ACT
AND CS_ACTOR.COD_PAIS = CS_PAIS.COD_PAIS
AND CS_PELICULA.COD_PELI = CS_CLASIFICACION.COD_PELI
AND CS_CLASIFICACION.COD_GEN = CS_GENERO.COD_GEN
AND CS_GENERO.NOMBRE = 'Comedia'
ORDER BY CS_PAIS.NOMBRE;

-- Exercise 15
SELECT P.COD_PELI, P.TITULO
FROM CS_PELICULA P
WHERE P.COD_PELI IN (
    SELECT AT.COD_PELI
    FROM CS_ACTUA AC
    WHERE AT.COD_ACT IN (
        SELECT A.COD_ACT
        FROM CS_ACTOR A
        WHERE A.NOMBRE = P.DIRECTOR
    )
);

-- Exercise 21
SELECT COUNT(p.cod_peli)
FROM cs_pelicula p
WHERE p.cod_peli IN (
    SELECT c.cod_peli
    FROM cs_clasificacion c
    WHERE c.cod_gen IN (SELECT g.cod_gen FROM cs_genero g WHERE g.nombre = 'Comedia')
) AND 1 = (
    SELECT COUNT(*)
    FROM cs_actua x
    WHERE x.papel = 'Secundario' AND x.cod_peli = p.cod_peli
);

-- Exercise 22
SELECT p.anyo
FROM cs_pelicula p
WHERE p.anyo <= ALL (
    SELECT p2.anyo
    FROM cs_pelicula p2
    WHERE p2.cod_peli IN (
        SELECT ac.cod_peli
        FROM cs_actua ac
        WHERE ac.papel = 'Principal'
        AND ac.cod_act IN (
            SELECT a.cod_act
            FROM cs_actor a
            WHERE a.nombre = 'Jude Law'
        )
    )
);

-- Exercise 24 (doesn't work properly)
SELECT cod_act, nombre, FECHA_NAC
FROM cs_actor
WHERE fecha_nac <= ALL (
    SELECT fecha_nac
    FROM cs_actor
    WHERE fecha_nac >= '01/01/1940'
    AND fecha_nac <= '31/12/1940'
);

-- Exercise 24
SELECT a.cod_act, a.nombre, a.fecha_nac
FROM cs_actor a
WHERE a.fecha_nac <= ALL (
    SELECT fecha_nac
    FROM cs_actor
    WHERE fecha_nac >= '01/01/1940'
    AND fecha_nac < '01/01/1941' -- check if this can be removed!

) AND fecha_nac >= '01/01/1940';


-- Exercise 25
SELECT g.nombre
FROM cs_genero g
WHERE g.cod_gen IN (
    SELECT c.cod_gen
    FROM cs_clasificacion c
    WHERE c.cod_peli IN (
        SELECT p.cod_peli
        FROM cs_pelicula p
        WHERE p.duracion >= ALL (
            SELECT duracion
            FROM cs_pelicula
        )
    )
);

-- Exercise 26
SELECT l.cod_lib, l.titulo
FROM cs_libro l
WHERE l.cod_lib IN (
    SELECT p.cod_lib
    FROM cs_pelicula p
    WHERE p.cod_lib IS NOT NULL
    AND p.cod_peli IN (
        SELECT x.cod_peli
        FROM cs_actua x
        WHERE x.cod_act IN (
            SELECT a.cod_act
            FROM cs_actor a
            WHERE a.cod_pais IN (
                SELECT p.cod_pais
                FROM cs_pais p
                WHERE p.nombre = 'España'
            )
        )
    )
) ORDER BY l.titulo;

-- Exercise 27
SELECT p.titulo
FROM cs_pelicula p
WHERE p.anyo < 1950
AND 1 < (
    SELECT COUNT(c.cod_gen)
    FROM cs_clasificacion c
    WHERE p.cod_peli = c.cod_peli

);

-- Exercise 28
SELECT COUNT(*)
FROM cs_pelicula p
WHERE 4 > (
    SELECT COUNT(DISTINCT x.cod_act)
    FROM cs_actua x
    WHERE p.cod_peli = x.cod_peli
);

-- Exercise 29
SELECT DISTINCT p.director
FROM cs_pelicula p
WHERE 250 < (
    SELECT SUM(p2.duracion)
    FROM cs_pelicula p2
    WHERE p2.director = p.director
);

-- Exercise 30
SELECT DISTINCT EXTRACT(YEAR FROM a.fecha_nac)
FROM cs_actor a
WHERE 3 < (
    SELECT COUNT(a2.cod_act)
    FROM cs_actor a2
    WHERE EXTRACT(YEAR FROM a.fecha_nac) = EXTRACT (YEAR FROM a2.fecha_nac)

);

-- Exercise 31
SELECT a.cod_act, a.nombre
FROM cs_actor a
WHERE a.fecha_nac IN (
    SELECT MAX(a.fecha_nac)
    FROM cs_actor a
    WHERE a.cod_act IN (
        SELECT x.cod_act
        FROM cs_actua x
        WHERE x.cod_peli IN (
            SELECT c.cod_peli
            FROM cs_clasificacion c
            WHERE c.cod_gen = 'DD8'
        )
    )
);

-- Exercise 32
SELECT *
FROM cs_pais p
WHERE NOT EXISTS (
    SELECT *
    FROM cs_actor a
    WHERE a.cod_pais = p.cod_pais
    AND (a.fecha_nac >= '01/01/2000' OR a.fecha_nac < '01/01/1900')
) AND EXISTS (
    SELECT *
    FROM cs_actor a
    WHERE a.cod_pais = p.cod_pais
) ORDER BY p.nombre;

-- Exercise 33
SELECT a.cod_act, a.nombre
FROM cs_actor a
WHERE NOT EXISTS (
    SELECT *
    FROM cs_actua x
    WHERE x.cod_act = a.cod_act
    AND x.papel <> 'Secundario'
) AND EXISTS (
    SELECT *
    FROM cs_actua x
    WHERE x.cod_act = a.cod_act
) ORDER BY a.nombre;

