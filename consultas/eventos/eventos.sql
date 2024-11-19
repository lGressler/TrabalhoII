-- 2. Eventos realizados, clientes, funcionários e custo
-- Consulta SQL:

SELECT 
    ch.Nome AS Nome_Evento,
    c.Nome AS Nome_Cliente,
    l.Responsavel AS Nome_Funcionario,
    COALESCE(mc.Custo, 0) + COALESCE(cc.Custo, 0) AS Custo_Total
FROM 
    Checagens ch
LEFT JOIN Calibracao cc ON ch.ID_Checagem = cc.ID_Checagem
LEFT JOIN Manutencao mc ON ch.ID_Checagem = mc.ID_Checagem
INNER JOIN Cliente c ON ch.ID_Checagem = c.ID_Cliente
INNER JOIN Laboratorio l ON l.ID_Laboratorio = ch.ID_Checagem
ORDER BY Nome_Evento, Nome_Cliente, Nome_Funcionario;
