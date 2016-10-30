-- QUERIES USING 1 RELATION

-- Exercise 1
SELECT nombre
FROM autor
WHERE nacionalidad = 'Argentina';

-- Exercise 2
SELECT titulo
FROM obra
WHERE titulo LIKE '%mundo%';

-- Exercise 3
SELECT id_lib, num_obras
FROM libro
WHERE "AÑO" < 1990
AND num_obras > 1;

-- Exercise 4
SELECT COUNT(*) LIB_AÑO
FROM libro
WHERE "AÑO" IS NOT NULL;

-- Exercise 5
SELECT COUNT(*) MÁS_1_OB
FROM libro
WHERE num_obras > 1;

-- Exercise 6
SELECT id_lib
FROM libro
WHERE "AÑO" = 1997
AND titulo IS NULL;

-- Exercise 7
SELECT titulo
FROM libro
WHERE titulo IS NOT NULL
ORDER BY titulo DESC;

-- Exercise 8
SELECT SUM(num_obras) OBRAS
FROM libro
WHERE "AÑO" BETWEEN 1990 AND 1999;


-- QUERIES USING MORE THAN 1 RELATION

-- Exercise 9
SELECT COUNT(DISTINCT autor_id)
FROM escribir
WHERE cod_ob IN (
    SELECT cod_ob
    FROM obra
    WHERE titulo LIKE '%ciudad%'
);

-- Exercise 10
SELECT titulo
FROM obra
WHERE cod_ob IN (
    SELECT cod_ob
    FROM escribir
    WHERE autor_id IN (
        SELECT autor_id
        FROM autor
        WHERE nombre = 'Camús, Albert'
    )
);

-- Exercise 11
SELECT nombre
FROM autor
WHERE autor_id IN (
    SELECT autor_id
    FROM escribir
    WHERE cod_ob IN (
        SELECT cod_ob
        FROM obra
        WHERE titulo = 'La tata'
    )
);

-- Exercise 12
SELECT nombre
FROM amigo
WHERE num IN (
    SELECT num
    FROM leer
    WHERE cod_ob IN (
        SELECT cod_ob
        FROM escribir
        WHERE autor_id = 'RUKI'
    )
);

-- Exercise 13
SELECT id_lib, titulo
FROM libro
WHERE titulo IS NOT NULL
AND 1 < (
    SELECT COUNT(cod_ob)
    FROM esta_en
    WHERE libro.id_lib = id_lib
);


-- QUERIES WITH SUBQUERIES

-- Exercise 14
SELECT titulo, nombre
FROM autor, obra
WHERE nacionalidad = 'Francesa'
AND cod_ob IN (
    SELECT cod_ob
    FROM escribir
    WHERE autor_id = autor.autor_id
    AND cod_ob NOT IN (
        SELECT cod_ob
        FROM escribir
        WHERE autor_id <> autor.autor_id
    )
);

-- Exercise 15
SELECT COUNT(autor_id) SIN_OBRA
FROM autor
WHERE autor_id NOT IN (
    SELECT autor_id
    FROM escribir
);

-- Exercise 16
-- untested
SELECT nombre
FROM autor
WHERE autor_id NOT IN (
    SELECT autor_id
    FROM escribir
);

-- Exercise 17
-- untested
SELECT nombre
FROM autor
WHERE nacionalidad = 'Española'
AND 2 <= (
    SELECT COUNT(cod_ob)
    FROM escribir
    WHERE autor_id = autor.autor_id
);

-- Exercise 18
-- untested
SELECT nombre
FROM autor
WHERE nacionalidad = 'Española'
AND autor_id IN (
    SELECT autor_id
    FROM escribir
    WHERE 2 <= (
        SELECT COUNT(id_lib)
        FROM esta_en
        WHERE escribir.cod_ob = cod_ob
    )
);

-- Exercise 19
-- untested
SELECT titulo, cod_ob
FROM obra
WHERE 1 < (
    SELECT COUNT(autor_id)
    FROM escribe
    WHERE obra.cod_ob = cod_ob
);


-- QUERIES WITH UNIVERSAL QUANTIFICATION

-- Exercise 20
-- given a friend, there is no work by RUKI they haven't read
-- untested
SELECT nombre
FROM amigo
WHERE NOT EXISTS (
    SELECT *
    FROM leer
    WHERE amigo.num = num
    AND cod_ob NOT IN (
        SELECT cod_ob
        FROM escribir
        WHERE autor_id = 'RUKI'
    )
) AND EXISTS (
    SELECT *
    FROM leer
    WHERE amigo.num = num
    AND cod_ob IN (
        SELECT cod_ob
        FROM escribir
        WHERE autor_id = 'RUKI'
    )
);

-- Exercise 21
-- untested
SELECT nombre
FROM amigo
WHERE NOT EXISTS (
    SELECT *
    FROM leer
    WHERE amigo.num = num
    AND cod_ob NOT IN (
        SELECT cod_ob
        FROM escribir
        WHERE autor_id = 'GUAP'
    )
) AND EXISTS (
    SELECT *
    FROM leer
    WHERE amigo.num = num
    AND cod_ob IN (
        SELECT cod_ob
        FROM escribir
        WHERE autor_id = 'GUAP'
    )
);

-- Exercise 22
-- untested
SELECT nombre
FROM amigo
WHERE NOT EXISTS (
    SELECT *
    FROM leer
    WHERE amigo.num = num
    AND cod_ob NOT IN (
        SELECT cod_ob
        FROM escribir e1
    )
) AND EXISTS (
    SELECT *
    FROM leer
    WHERE amigo.num = num
    AND cod_ob IN (
        SELECT cod_ob
        FROM escribir
        WHERE autor_id = e1.autor_id
    )
);

-- Exercise 23
-- untested
SELECT amigo.nombre, autor.nombre
FROM amigo, autor
WHERE NOT EXISTS (
    SELECT *
    FROM leer
    WHERE amigo.num = num
    AND cod_ob NOT IN (
        SELECT cod_ob
        FROM escribir
        WHERE autor_id = autor.autor_id
    )
) AND EXISTS (
    SELECT *
    FROM leer
    WHERE amigo.num = num
    AND cod_ob IN (
        SELECT cod_ob
        FROM escribir
        WHERE autor_id = autor.autor_id
    )
);

-- Exercise 24
-- untested
SELECT nombre
FROM amigo
WHERE num IN (
    SELECT num
    FROM leer
    WHERE NOT EXISTS (
        SELECT *
        FROM escribir
        WHERE leer.cod_ob = cod_ob
        AND autor_id <> 'CAMA'
    ) AND EXISTS (
        SELECT *
        FROM escribir
        WHERE leer.cod_ob = cod_ob
        AND autor_id = 'CAMA'
    )
);

-- Exercise 25
-- untested
SELECT nombre
FROM amigo
WHERE num IN (
    SELECT num
    FROM leer
    WHERE NOT EXISTS (
        SELECT *
        FROM escribir
        WHERE leer.cod_ob = cod_ob
        AND autor_id <> 'CAMA'
    ) AND EXISTS (
        SELECT *
        FROM escribir
        WHERE leer.cod_ob = cod_ob
        AND autor_id = 'CAMA'
    )
);

-- Exercise 26
-- untested
SELECT nombre
FROM amigo
WHERE num IN (
    SELECT num
    FROM leer
    WHERE cod_ob IN (
        SELECT cod_ob
        FROM escribir e
        WHERE NOT EXISTS (
            SELECT *
            FROM escribir
            WHERE e.autor_id <> autor_id
            AND cod_ob IN (
                SELECT cod_ob
                FROM leer
                WHERE num = amigo.num
            )
        )
    )
);

-- Exercise 27
-- untested
SELECT amigo.nombre, autor.nombre
FROM amigo, autor
WHERE num IN (
    SELECt num
    FROM leer
    WHERE cod_ob IN (
        SELECT cod_ob
        FROM escribir e
        WHERE NOT EXISTS (
            SELECT *
            FROM escribir
            WHERE e.autor_id <> autor_id
            AND cod_ob IN (
                SELECT cod_ob
                FROM leer
                WHERE num = amigo.num
            )
        ) AND autor.autor_id = autor_id
    )
);

-- Exercise 28
-- untested
SELECT  amigo.nombre, autor.nombre
FROM amigo, autor
WHERE num IN (
    SELECT num
    FROM leer
    WHERE cod_ob IN (
        SELECT cod_ob
        FROM escribir e
        WHERE NOT EXISTS (
            SELECT *
            FROM escribir
            WHERE e.autor_id <> autor_id
            AND autor.autor_id = autor_id
            AND cod_ob IN (
                SELECT cod_ob
                FROM leer
                WHERE num = amigo.num
            )
        ) AND autor.autor_id = autor_id
    )
) AND NOT EXISTS (
    SELECT *
    FROM leer, escribir
    WHERE amigo.num <> num
    AND leer.cod_ob = escribir.cod_ob
    AND escribir.cod_autor = autor.cod_autor
);


-- QUERIES WITH GROUP BY

-- Exercise 29
-- untested
SELECT id_lib, titulo
FROM libro LEFT JOIN esta_en USING (id_lib)
WHERE titulo IS NOT NULL
GROUP BY id_lib, titulo
HAVING COUNT(cod_ob) > 1;