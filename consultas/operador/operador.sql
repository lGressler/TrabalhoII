-- 6. Operadores de conjunto

SELECT Nome
FROM Laboratorio
INTERSECT
SELECT Nome
FROM Equipamento
WHERE Localizacao LIKE '%A%';
