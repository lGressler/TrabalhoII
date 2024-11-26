-- Consulta 1: Nome do laboratório, Equipamentos e Pessoas
SELECT 
    l.Nome AS Nome_Laboratorio,
    e.Nome AS Nome_Equipamento,
    f.Nome AS Nome_Pessoa
FROM Laboratorio l
INNER JOIN Equipamento e ON l.ID_Laboratorio = e.ID_Laboratorio
INNER JOIN Funcionario f ON f.ID_Laboratorio = l.ID_Laboratorio
ORDER BY l.Nome, e.Nome, f.Nome;

-- Consulta 2: Todos os eventos (calibração, manutenção, qualificação e checagem)
SELECT 
    'Manutenção' AS Evento,
    c.Nome AS Nome_Cliente,
    f.Nome AS Nome_Funcionario,
    m.Custo AS Custo_Evento
FROM Manutencao m
INNER JOIN Equipamento e ON m.TAG_Equipamento = e.TAG_Identificacao
INNER JOIN Equipamento_Cliente ec ON e.TAG_Identificacao = ec.TAG_Equipamento
INNER JOIN Cliente c ON ec.ID_Cliente = c.ID_Cliente
INNER JOIN Funcionario f ON f.ID_Laboratorio = e.ID_Laboratorio
UNION
SELECT 
    'Calibração' AS Evento,
    c.Nome AS Nome_Cliente,
    f.Nome AS Nome_Funcionario,
    cal.Custo AS Custo_Evento
FROM Calibracao cal
INNER JOIN Equipamento e ON cal.TAG_Equipamento = e.TAG_Identificacao
INNER JOIN Equipamento_Cliente ec ON e.TAG_Identificacao = ec.TAG_Equipamento
INNER JOIN Cliente c ON ec.ID_Cliente = c.ID_Cliente
INNER JOIN Funcionario f ON f.ID_Laboratorio = e.ID_Laboratorio
UNION
SELECT 
    'Qualificação' AS Evento,
    c.Nome AS Nome_Cliente,
    f.Nome AS Nome_Funcionario,
    q.Custo AS Custo_Evento
FROM Qualificacao q
INNER JOIN Equipamento e ON q.TAG_Equipamento = e.TAG_Identificacao
INNER JOIN Equipamento_Cliente ec ON e.TAG_Identificacao = ec.TAG_Equipamento
INNER JOIN Cliente c ON ec.ID_Cliente = c.ID_Cliente
INNER JOIN Funcionario f ON f.ID_Laboratorio = e.ID_Laboratorio;

-- Consulta 3: Custo de Calibração em relação às receitas do laboratório
SELECT 
    l.Nome AS Nome_Laboratorio,
    cal.Custo AS Custo_Calibracao,
    l.Receitas AS Receitas_Laboratorio
FROM Laboratorio l
INNER JOIN Equipamento e ON l.ID_Laboratorio = e.ID_Laboratorio
INNER JOIN Calibracao cal ON e.TAG_Identificacao = cal.TAG_Equipamento
ORDER BY l.Nome;

-- Consulta 4: Nome dos Funcionários, Equipamentos e Custo Gerado
SELECT 
    f.Nome AS Nome_Funcionario,
    e.Nome AS Nome_Equipamento,
    COALESCE(m.Custo, 0) + COALESCE(cal.Custo, 0) + COALESCE(q.Custo, 0) AS Custo_Gerado
FROM Funcionario f
INNER JOIN Laboratorio l ON f.ID_Laboratorio = l.ID_Laboratorio
INNER JOIN Equipamento e ON l.ID_Laboratorio = e.ID_Laboratorio
LEFT JOIN Manutencao m ON e.TAG_Identificacao = m.TAG_Equipamento
LEFT JOIN Calibracao cal ON e.TAG_Identificacao = cal.TAG_Equipamento
LEFT JOIN Qualificacao q ON e.TAG_Identificacao = q.TAG_Equipamento
ORDER BY f.Nome;

-- Consulta 5: Nome de Clientes, Equipamentos e Custo Gerado
SELECT 
    c.Nome AS Nome_Cliente,
    e.Nome AS Nome_Equipamento,
    COALESCE(m.Custo, 0) + COALESCE(cal.Custo, 0) + COALESCE(q.Custo, 0) AS Custo_Gerado
FROM Cliente c
INNER JOIN Equipamento_Cliente ec ON c.ID_Cliente = ec.ID_Cliente
INNER JOIN Equipamento e ON ec.TAG_Equipamento = e.TAG_Identificacao
LEFT JOIN Manutencao m ON e.TAG_Identificacao = m.TAG_Equipamento
LEFT JOIN Calibracao cal ON e.TAG_Identificacao = cal.TAG_Equipamento
LEFT JOIN Qualificacao q ON e.TAG_Identificacao = q.TAG_Equipamento
ORDER BY c.Nome;

-- Consulta 6: União entre funcionários e clientes com base nos laboratórios e equipamentos
SELECT DISTINCT f.Nome AS Nome, 'Funcionario' AS Tipo
FROM Funcionario f
INNER JOIN Laboratorio l ON f.ID_Laboratorio = l.ID_Laboratorio
INNER JOIN Equipamento e ON l.ID_Laboratorio = e.ID_Laboratorio
UNION
SELECT DISTINCT c.Nome AS Nome, 'Cliente' AS Tipo
FROM Cliente c
INNER JOIN Equipamento_Cliente ec ON c.ID_Cliente = ec.ID_Cliente
INNER JOIN Equipamento e ON ec.TAG_Equipamento = e.TAG_Identificacao;

-- Consulta 7: Consulta envolvendo Checagem e outros detalhes
SELECT 
    e.Nome AS Equipamento,
    c.Nome AS Cliente,
    ch.Data AS Data_Checagem
FROM Checagem ch
INNER JOIN Equipamento e ON ch.TAG_Equipamento = e.TAG_Identificacao
INNER JOIN Equipamento_Cliente ec ON e.TAG_Identificacao = ec.TAG_Equipamento
INNER JOIN Cliente c ON ec.ID_Cliente = c.ID_Cliente;