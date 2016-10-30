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