-- Tabela de Laboratórios
CREATE TABLE Laboratorio (
    ID_Laboratorio SERIAL PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Receitas NUMERIC(10, 2) NOT NULL
);

-- Tabela de Equipamentos
CREATE TABLE Equipamento (
    TAG_Identificacao VARCHAR(50) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    ID_Laboratorio INT NOT NULL REFERENCES Laboratorio(ID_Laboratorio)
);

-- Tabela de Funcionários
CREATE TABLE Funcionario (
    ID_Funcionario SERIAL PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Cargo VARCHAR(100),
    ID_Laboratorio INT NOT NULL REFERENCES Laboratorio(ID_Laboratorio)
);

-- Tabela de Clientes
CREATE TABLE Cliente (
    ID_Cliente SERIAL PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(200)
);

-- Tabela de Manutenção
CREATE TABLE Manutencao (
    ID_Manutencao SERIAL PRIMARY KEY,
    TAG_Equipamento VARCHAR(50) NOT NULL REFERENCES Equipamento(TAG_Identificacao),
    Custo NUMERIC(10, 2),
    Data DATE
);

-- Tabela de Calibração
CREATE TABLE Calibracao (
    ID_Calibracao SERIAL PRIMARY KEY,
    TAG_Equipamento VARCHAR(50) NOT NULL REFERENCES Equipamento(TAG_Identificacao),
    Custo NUMERIC(10, 2),
    Data DATE
);

-- Tabela de Qualificação
CREATE TABLE Qualificacao (
    ID_Qualificacao SERIAL PRIMARY KEY,
    TAG_Equipamento VARCHAR(50) NOT NULL REFERENCES Equipamento(TAG_Identificacao),
    Custo NUMERIC(10, 2),
    Data DATE
);

-- Tabela de Checagem
CREATE TABLE Checagem (
    ID_Checagem SERIAL PRIMARY KEY,
    TAG_Equipamento VARCHAR(50) NOT NULL REFERENCES Equipamento(TAG_Identificacao),
    Data DATE
);

-- Tabela de Equipamento_Cliente (Relacionamento entre Equipamento e Cliente)
CREATE TABLE Equipamento_Cliente (
    ID_Equipamento_Cliente SERIAL PRIMARY KEY,
    ID_Cliente INT NOT NULL REFERENCES Cliente(ID_Cliente),
    TAG_Equipamento VARCHAR(50) NOT NULL REFERENCES Equipamento(TAG_Identificacao),
    Data_Utilizacao DATE NOT NULL
);

-- Inserção de Dados para Laboratórios
INSERT INTO Laboratorio (Nome, Receitas) VALUES
('Laboratório A', 50000.00),
('Laboratório B', 35000.00),
('Laboratório C', 70000.00);
('Laboratório D', 90000.00);
('Laboratório E', 40000.00);

-- Inserção de Dados para Equipamentos
INSERT INTO Equipamento (TAG_Identificacao, Nome, ID_Laboratorio) VALUES
('EQ-001', 'Equipamento A', 1),
('EQ-002', 'Equipamento B', 1),
('EQ-003', 'Equipamento C', 2),
('EQ-004', 'Equipamento D', 3);
('EQ-005', 'Equipamento E', 4);

-- Inserção de Dados para Funcionários
INSERT INTO Funcionario (Nome, Cargo, ID_Laboratorio) VALUES
('João Silva', 'Técnico', 1),
('Maria Souza', 'Engenheira', 2),
('Carlos Oliveira', 'Assistente', 3);
('Paulo Santos', 'Gerente', 4);

-- Inserção de Dados para Clientes
INSERT INTO Cliente (Nome, Endereco) VALUES
('Cliente A', 'Rua X, 123'),
('Cliente B', 'Avenida Y, 456'),
('Cliente C', 'Praça Z, 789');
('Cliente D', 'BR-166, 200');
('Cliente E', 'BR-66, 55');

-- Inserção de Dados para Manutenção
INSERT INTO Manutencao (TAG_Equipamento, Custo, Data) VALUES
('EQ-001', 200.00, '2024-12-01'),
('EQ-002', 150.00, '2024-12-10');
('EQ-003', 180.00, '2024-11-10');
('EQ-004', 200.00, '2024-10-10');
('EQ-005', 330.00, '2024-09-10');

-- Inserção de Dados para Calibração
INSERT INTO Calibracao (TAG_Equipamento, Custo, Data) VALUES
('EQ-001', 300.00, '2024-12-05'),
('EQ-003', 250.00, '2024-12-12');

-- Inserção de Dados para Qualificação
INSERT INTO Qualificacao (TAG_Equipamento, Custo, Data) VALUES
('EQ-002', 500.00, '2024-12-15'),
('EQ-004', 400.00, '2024-12-20');

-- Inserção de Dados para Checagem
INSERT INTO Checagem (TAG_Equipamento, Data) VALUES
('EQ-001', '2024-12-02'),
('EQ-002', '2024-12-06');

-- Inserção de Dados para Equipamento_Cliente
INSERT INTO Equipamento_Cliente (ID_Cliente, TAG_Equipamento, Data_Utilizacao) VALUES
(1, 'EQ-001', '2024-12-01'),
(2, 'EQ-002', '2024-12-10'),
(3, 'EQ-003', '2024-12-05');

-- Consulta 1: Nome do laboratório, Equipamentos e Pessoas
EXPLAIN 
SELECT 
    l.Nome AS Nome_Laboratorio,
    e.Nome AS Nome_Equipamento,
    f.Nome AS Nome_Pessoa
FROM Laboratorio l
INNER JOIN Equipamento e ON l.ID_Laboratorio = e.ID_Laboratorio
INNER JOIN Funcionario f ON f.ID_Laboratorio = l.ID_Laboratorio
ORDER BY l.Nome, e.Nome, f.Nome;

-- Consulta 2: Todos os eventos (calibração, manutenção, qualificação e checagem)
EXPLAIN 
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
EXPLAIN 
SELECT 
    l.Nome AS Nome_Laboratorio,
    cal.Custo AS Custo_Calibracao,
    l.Receitas AS Receitas_Laboratorio
FROM Laboratorio l
INNER JOIN Equipamento e ON l.ID_Laboratorio = e.ID_Laboratorio
INNER JOIN Calibracao cal ON e.TAG_Identificacao = cal.TAG_Equipamento
ORDER BY l.Nome;

-- Consulta 4: Nome dos Funcionários, Equipamentos e Custo Gerado
EXPLAIN 
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
EXPLAIN 
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
