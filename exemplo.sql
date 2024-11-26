EXPLAIN 
SELECT 
    l.Nome AS Nome_Laboratorio,
    e.Nome AS Nome_Equipamento,
    f.Nome AS Nome_Pessoa
FROM Laboratorio l
INNER JOIN Equipamento e ON l.ID_Laboratorio = e.ID_Laboratorio
INNER JOIN Funcionario f ON f.ID_Laboratorio = l.ID_Laboratorio
ORDER BY l.Nome, e.Nome, f.Nome;