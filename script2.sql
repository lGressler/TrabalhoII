-- Removendo tabelas existentes se elas já existirem
DROP TABLE IF EXISTS Possui CASCADE;
DROP TABLE IF EXISTS Detem CASCADE;
DROP TABLE IF EXISTS Servicos CASCADE;
DROP TABLE IF EXISTS Contrato CASCADE;
DROP TABLE IF EXISTS Juridico CASCADE;
DROP TABLE IF EXISTS Cliente CASCADE;
DROP TABLE IF EXISTS Manutencao CASCADE;
DROP TABLE IF EXISTS Laboratorio CASCADE;
DROP TABLE IF EXISTS Equipamento CASCADE;
DROP TABLE IF EXISTS Checagens CASCADE;
DROP TABLE IF EXISTS Fornecedor CASCADE;

-- Criação da tabela Fornecedor
CREATE TABLE Fornecedor (
    CNPJ VARCHAR(14) PRIMARY KEY,
    Razao_Social VARCHAR(100) NOT NULL,
    Localizacao VARCHAR(100) NOT NULL
);

-- Criação da tabela Checagens
CREATE TABLE Checagens (
    Identificacao VARCHAR(50) PRIMARY KEY,
    Numero_revisao INT NOT NULL,
    Nome VARCHAR(100) NOT NULL,
    Data DATE NOT NULL,
    Descricao TEXT
);

-- Criação da tabela Equipamento
CREATE TABLE Equipamento (
    TAG_Identificacao VARCHAR(50) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Numero_serie VARCHAR(50) NOT NULL,
    Localizacao VARCHAR(100) NOT NULL,
    ID_Laboratorio VARCHAR(50),
    FOREIGN KEY (ID_Laboratorio) REFERENCES Laboratorio(ID_Laboratorio)
);

-- Criação da tabela Laboratório
CREATE TABLE Laboratorio (
    ID_Laboratorio VARCHAR(50) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Area_atendimento VARCHAR(100) NOT NULL,
    Responsavel VARCHAR(100) NOT NULL,
    Receitas NUMERIC NOT NULL DEFAULT 0
);

-- Criação da tabela Manutenção
CREATE TABLE Manutencao (
    ID_Manutencao VARCHAR(50) PRIMARY KEY,
    Problema_apresentado TEXT,
    Status VARCHAR(50),
    TAG_Identificacao VARCHAR(50),
    FOREIGN KEY (TAG_Identificacao) REFERENCES Equipamento(TAG_Identificacao),
    Custo NUMERIC
);

-- Criação da tabela Cliente
CREATE TABLE Cliente (
    ID_Cliente VARCHAR(50) PRIMARY KEY,
    CPF VARCHAR(11) NOT NULL,
    Nome VARCHAR(100) NOT NULL
);

-- Criação da tabela Jurídico
CREATE TABLE Juridico (
    CNPJ VARCHAR(14) PRIMARY KEY,
    Razao_Social VARCHAR(100) NOT NULL
);

-- Criação da tabela Contrato
CREATE TABLE Contrato (
    ID_Contrato SERIAL PRIMARY KEY,
    CNPJ VARCHAR(14),
    FOREIGN KEY (CNPJ) REFERENCES Juridico(CNPJ)
);

-- Criação da tabela Serviços
CREATE TABLE Servicos (
    Codigo_servico VARCHAR(50) PRIMARY KEY,
    Data_servico DATE NOT NULL
);

-- Criação da tabela Detém
CREATE TABLE Detem (
    CNPJ VARCHAR(14),
    TAG_Identificacao VARCHAR(50),
    PRIMARY KEY (CNPJ, TAG_Identificacao),
    FOREIGN KEY (CNPJ) REFERENCES Fornecedor(CNPJ),
    FOREIGN KEY (TAG_Identificacao) REFERENCES Equipamento(TAG_Identificacao)
);

-- Criação da tabela Possui
CREATE TABLE Possui (
    ID_Laboratorio VARCHAR(50),
    TAG_Identificacao VARCHAR(50),
    PRIMARY KEY (ID_Laboratorio, TAG_Identificacao),
    FOREIGN KEY (ID_Laboratorio) REFERENCES Laboratorio(ID_Laboratorio),
    FOREIGN KEY (TAG_Identificacao) REFERENCES Equipamento(TAG_Identificacao)
);

-- Inserindo dados na tabela Fornecedor
INSERT INTO Fornecedor (CNPJ, Razao_Social, Localizacao) VALUES
('12345678000195', 'Fornecedor A', 'Rua A, 123'),
('98765432000196', 'Fornecedor B', 'Rua B, 456'),
('11223344000197', 'Fornecedor C', 'Rua C, 789'),
('55667788000198', 'Fornecedor D', 'Rua D, 321'),
('99887766000199', 'Fornecedor E', 'Rua E, 654');

-- Inserindo dados na tabela Checagens
INSERT INTO Checagens (Identificacao, Numero_revisao, Nome, Data, Descricao) VALUES
('CH001', 1, 'Checagem 1', '2024-01-01', 'Descrição da checagem 1'),
('CH002', 2, 'Checagem 2', '2024-02-01', 'Descrição da checagem 2'),
('CH003', 1, 'Checagem 3', '2024-03-01', 'Descrição da checagem 3'),
('CH004', 1, 'Checagem 4', '2024-04-01', 'Descrição da checagem 4'),
('CH005', 2, 'Checagem 5', '2024-05-01', 'Descrição da checagem 5');

-- Inserindo dados na tabela Equipamento
INSERT INTO Equipamento (TAG_Identificacao, Nome, Numero_serie, Localizacao, ID_Laboratorio) VALUES
('EQ001', 'Equipamento 1', 'S001', 'Laboratório A', 'LAB001'),
('EQ002', 'Equipamento 2', 'S002', 'Laboratório B', 'LAB002'),
('EQ003', 'Equipamento 3', 'S003', 'Laboratório C', 'LAB003'),
('EQ004', 'Equipamento 4', 'S004', 'Laboratório D', 'LAB004'),
('EQ005', 'Equipamento 5', 'S005', 'Laboratório E', 'LAB005');

-- Inserindo dados na tabela Laboratório
INSERT INTO Laboratorio (ID_Laboratorio, Nome, Area_atendimento, Responsavel, Receitas) VALUES
('LAB001', 'Laboratório A', 'Área A', 'Responsável A', 1000),
('LAB002', 'Laboratório B', 'Área B', 'Responsável B', 2000),
('LAB003', 'Laboratório C', 'Área C', 'Responsável C', 1500),
('LAB004', 'Laboratório D', 'Área D', 'Responsável D', 2500),
('LAB005', 'Laboratório E', 'Área E', 'Responsável E', 3000);

-- Inserindo dados na tabela Manutenção
INSERT INTO Manutencao (ID_Manutencao, Problema_apresentado, Status, TAG_Identificacao, Custo) VALUES
('MNT001', 'Troca de peça', 'Concluída', 'EQ001', 500),
('MNT002', 'Verificação de calibragem', 'Em andamento', 'EQ002', 200),
('MNT003', 'Substituição de componentes', 'Pendente', 'EQ003', 300),
('MNT004', 'Ajuste de medição', 'Concluída', 'EQ004', 400),
('MNT005', 'Troca de sensor', 'Concluída', 'EQ005', 600);

-- Inserindo dados na tabela Cliente
INSERT INTO Cliente (ID_Cliente, CPF, Nome) VALUES
('CLI001', '12345678901', 'Cliente A'),
('CLI002', '23456789012', 'Cliente B'),
('CLI003', '34567890123', 'Cliente C'),
('CLI004', '45678901234', 'Cliente D'),
('CLI005', '56789012345', 'Cliente E');

-- Consultas solicitadas
-- 1. Laboratórios, equipamentos e pessoas
SELECT 
    l.Nome AS Nome_Laboratorio,
    e.Nome AS Nome_Equipamento,
    c.Nome AS Nome_Cliente
FROM 
    Laboratorio l
INNER JOIN Equipamento e ON l.ID_Laboratorio = e.ID_Laboratorio
INNER JOIN Possui p ON e.TAG_Identificacao = p.TAG_Identificacao
INNER JOIN Cliente c ON c.ID_Cliente = p.ID_Laboratorio
ORDER BY l.Nome, e.Nome, c.Nome;

-- 2. Eventos realizados e custos
SELECT 
    ch.Nome AS Nome_Evento,
    c.Nome AS Nome_Cliente,
    l.Responsavel AS Nome_Funcionario,
    COALESCE(m.Custo, 0) AS Custo
FROM 
    Checagens ch
LEFT JOIN Manutencao m ON ch.Identificacao = m.ID_Manutencao
INNER JOIN Cliente c ON c.ID_Cliente = ch.Identificacao
INNER JOIN Laboratorio l ON l.ID_Laboratorio = m.TAG_Identificacao
ORDER BY Nome_Evento;
-- Continue com as demais consultas como no exemplo acima.
