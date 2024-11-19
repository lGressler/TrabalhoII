-- 7. consulta com tabelas nao usadas anteriormente

SELECT 
    f.Razao_Social AS Nome_Fornecedor,
    e.Nome AS Nome_Equipamento,
    ch.Nome AS Evento,
    l.Nome AS Nome_Laboratorio
FROM 
    Fornecedor f
INNER JOIN Equipamento e ON f.CNPJ = e.ID_Fornecedor
INNER JOIN Sofre s ON e.TAG_Identificacao = s.ID_Equipamento
INNER JOIN Checagens ch ON s.ID_Checagem = ch.ID_Checagem
INNER JOIN Laboratorio l ON e.ID_Laboratorio = l.ID_Laboratorio
ORDER BY Nome_Fornecedor, Nome_Equipamento;
