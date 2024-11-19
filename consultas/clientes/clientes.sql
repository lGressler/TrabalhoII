-- Clientes, equipamentos e custos

SELECT 
    c.Nome AS Nome_Cliente,
    e.Nome AS Nome_Equipamento,
    SUM(COALESCE(cc.Custo, 0) + COALESCE(mc.Custo, 0)) AS Custo_Total
FROM 
    Cliente c
INNER JOIN Checagens ch ON c.ID_Cliente = ch.ID_Checagem
INNER JOIN Sofre s ON ch.ID_Checagem = s.ID_Checagem
INNER JOIN Equipamento e ON s.ID_Equipamento = e.TAG_Identificacao
LEFT JOIN Calibracao cc ON ch.ID_Checagem = cc.ID_Checagem
LEFT JOIN Manutencao mc ON ch.ID_Checagem = mc.ID_Checagem
GROUP BY c.Nome, e.Nome
ORDER BY Nome_Cliente, Nome_Equipamento;
