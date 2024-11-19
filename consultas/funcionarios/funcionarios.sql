-- Funcionarios, equipamentos e custos

SELECT 
    l.Responsavel AS Nome_Funcionario,
    e.Nome AS Nome_Equipamento,
    SUM(COALESCE(cc.Custo, 0) + COALESCE(mc.Custo, 0)) AS Custo_Total
FROM 
    Laboratorio l
INNER JOIN Equipamento e ON l.ID_Laboratorio = e.ID_Laboratorio
LEFT JOIN Sofre s ON e.TAG_Identificacao = s.ID_Equipamento
LEFT JOIN Checagens ch ON s.ID_Checagem = ch.ID_Checagem
LEFT JOIN Calibracao cc ON ch.ID_Checagem = cc.ID_Checagem
LEFT JOIN Manutencao mc ON ch.ID_Checagem = mc.ID_Checagem
GROUP BY l.Responsavel, e.Nome
ORDER BY Nome_Funcionario, Nome_Equipamento;
