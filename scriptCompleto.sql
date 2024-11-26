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
INSERT INTO Laboratorio (ID_Laboratorio, Nome, Receitas) VALUES
(1, 'Laboratório A', 50000.00),
(2, 'Laboratório B', 35000.00),
(3, 'Laboratório C', 70000.00),
(4, 'Laboratório D', 90000.00),
(5, 'Laboratório E', 40000.00);

-- Inserção de Dados para Equipamentos
INSERT INTO Equipamento (TAG_Identificacao, Nome, ID_Laboratorio) VALUES
('EQ-001', 'Equipamento A', 1),
('EQ-002', 'Equipamento B', 1),
('EQ-003', 'Equipamento C', 2),
('EQ-004', 'Equipamento D', 3),
('EQ-005', 'Equipamento E', 4);

-- Inserção de Dados para Funcionários
INSERT INTO Funcionario (ID_Funcionario, Nome, Cargo, ID_Laboratorio) VALUES
(11, 'João Silva', 'Técnico', 1),
(22, 'Maria Souza', 'Engenheira', 2),
(33, 'Carlos Oliveira', 'Assistente', 3),
(44, 'Paulo Santos', 'Gerente', 4),
(55, 'Ana Costa', 'Coordenadora', 5);

-- Inserção de Dados para Clientes
INSERT INTO Cliente (ID_Cliente, Nome, Endereco) VALUES
(1, 'Cliente A', 'Rua X, 123'),
(2, 'Cliente B', 'Avenida Y, 456'),
(3, 'Cliente C', 'Praça Z, 789'),
(4, 'Cliente D', 'BR-166, 200'),
(5, 'Cliente E', 'BR-66, 55');

-- Inserção de Dados para Manutenção
INSERT INTO Manutencao (ID_Manutencao, TAG_Equipamento, Custo, Data) VALUES
(01, 'EQ-001', 200.00, '2024-12-01'),
(02, 'EQ-002', 150.00, '2024-12-10'),
(03, 'EQ-003', 180.00, '2024-11-10'),
(04, 'EQ-004', 200.00, '2024-10-10'),
(05, 'EQ-005', 330.00, '2024-09-10');

-- Inserção de Dados para Calibração
INSERT INTO Calibracao (ID_Calibracao, TAG_Equipamento, Custo, Data) VALUES
(21, 'EQ-001', 300.00, '2024-12-05'),
(22, 'EQ-003', 250.00, '2024-12-12'),
(23, 'EQ-005', 350.00, '2024-12-18'),
(24, 'EQ-002', 400.00, '2024-12-25'),
(25, 'EQ-004', 450.00, '2024-12-30');

-- Inserção de Dados para Qualificação
INSERT INTO Qualificacao (ID_Qualificacao, TAG_Equipamento, Custo, Data) VALUES
(31, 'EQ-002', 500.00, '2024-12-15'),
(32, 'EQ-004', 400.00, '2024-12-20'),
(33, 'EQ-005', 600.00, '2024-12-25'),
(34, 'EQ-001', 700.00, '2024-12-30'),
(35, 'EQ-003', 800.00, '2024-12-05');

-- Inserção de Dados para Checagem
INSERT INTO Checagem (ID_Checagem, TAG_Equipamento, Data) VALUES
(41, 'EQ-001', '2024-12-02'),
(42, 'EQ-002', '2024-12-06'),
(43, 'EQ-003', '2024-12-08'),
(44, 'EQ-004', '2024-12-11'),
(45, 'EQ-005', '2024-12-15');

-- Inserção de Dados para Equipamento_Cliente
INSERT INTO Equipamento_Cliente (ID_Cliente, TAG_Equipamento, Data_Utilizacao) VALUES
(1, 'EQ-001', '2024-12-01'),
(2, 'EQ-002', '2024-12-10'),
(3, 'EQ-003', '2024-12-05'),
(4, 'EQ-004', '2024-12-15'),
(5, 'EQ-005', '2024-12-20');

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
