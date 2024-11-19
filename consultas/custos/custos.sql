-- Custo de calibração e receitas dos laboratorios 

SELECT 
    l.Nome AS Nome_Laboratorio,
    ch.Nome AS Evento_Calibragem,
    cc.Custo AS Custo_Calibragem,
    l.Receitas AS Receita_Laboratorio
FROM 
    Laboratorio l
INNER JOIN Equipamento e ON l.ID_Laboratorio = e.ID_Laboratorio
INNER JOIN Sofre s ON e.TAG_Identificacao = s.ID_Equipamento
INNER JOIN Calibracao cc ON s.ID_Checagem = cc.ID_Checagem
INNER JOIN Checagens ch ON cc.ID_Checagem = ch.ID_Checagem
WHERE cc.Custo IS NOT NULL
ORDER BY l.Nome, ch.Nome;
