-- 1. Listagem de laboratórios, equipamentos e pessoas que os utilizam
-- Consulta SQL:

SELECT 
    l.Nome AS Nome_Laboratorio,
    e.Nome AS Nome_Equipamento,
    c.Nome AS Nome_Cliente
FROM 
    Laboratorio l
INNER JOIN Equipamento e ON l.ID_Laboratorio = e.ID_Laboratorio
INNER JOIN Sofre s ON e.TAG_Identificacao = s.ID_Equipamento
INNER JOIN Checagens ch ON s.ID_Checagem = ch.ID_Checagem
INNER JOIN Cliente c ON ch.ID_Checagem = c.ID_Cliente
ORDER BY l.Nome, e.Nome, c.Nome;
