-- Removendo tabelas existentes se elas já existirem
DROP TABLE IF EXISTS Sofre CASCADE;
DROP TABLE IF EXISTS Calibracao CASCADE;
DROP TABLE IF EXISTS Manutencao CASCADE;
DROP TABLE IF EXISTS Equipamento CASCADE;
DROP TABLE IF EXISTS Laboratorio CASCADE;
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
    ID_Checagem VARCHAR(50) PRIMARY KEY,
    Numero_revisao INT NOT NULL,
    Nome VARCHAR(100) NOT NULL,
    Data DATE NOT NULL,
    Descricao TEXT
);

-- Criação da tabela Calibração (especialização de Checagens)
CREATE TABLE Calibracao (
    ID_Checagem VARCHAR(50) PRIMARY KEY,
    Certificado VARCHAR(100),
    FOREIGN KEY (ID_Checagem) REFERENCES Checagens(ID_Checagem)
);

-- Criação da tabela Manutenção (especialização de Checagens)
CREATE TABLE Manutencao (
    ID_Checagem VARCHAR(50) PRIMARY KEY,
    Problema_apresentado TEXT,
    Status VARCHAR(50),
    FOREIGN KEY (ID_Checagem) REFERENCES Checagens(ID_Checagem)
);

-- Criação da tabela Laboratório
CREATE TABLE Laboratorio (
    ID_Laboratorio VARCHAR(50) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Area_atendimento VARCHAR(100) NOT NULL,
    Responsavel VARCHAR(100) NOT NULL
);

-- Criação da tabela Equipamento
CREATE TABLE Equipamento (
    TAG_Identificacao VARCHAR(50) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Numero_serie VARCHAR(50) NOT NULL,
    Localizacao VARCHAR(100) NOT NULL,
    ID_Laboratorio VARCHAR(50),
    ID_Fornecedor VARCHAR(14),
    FOREIGN KEY (ID_Laboratorio) REFERENCES Laboratorio(ID_Laboratorio),
    FOREIGN KEY (ID_Fornecedor) REFERENCES Fornecedor(CNPJ)
);

-- Criação da tabela Sofre (relacionamento n:n entre Equipamento e Checagens)
CREATE TABLE Sofre (
    ID_Equipamento VARCHAR(50),
    ID_Checagem VARCHAR(50),
    PRIMARY KEY (ID_Equipamento, ID_Checagem),
    FOREIGN KEY (ID_Equipamento) REFERENCES Equipamento(TAG_Identificacao),
    FOREIGN KEY (ID_Checagem) REFERENCES Checagens(ID_Checagem)
);

-- Inserindo dados na tabela Fornecedor
INSERT INTO Fornecedor (CNPJ, Razao_Social, Localizacao) VALUES
('12345678000195', 'Fornecedor A', 'Rua A, 123'),
('98765432000196', 'Fornecedor B', 'Rua B, 456'),
('11223344000197', 'Fornecedor C', 'Rua C, 789'),
('55667788000198', 'Fornecedor D', 'Rua D, 321'),
('99887766000199', 'Fornecedor E', 'Rua E, 654');

-- Inserindo dados na tabela Laboratório
INSERT INTO Laboratorio (ID_Laboratorio, Nome, Area_atendimento, Responsavel) VALUES
('LAB001', 'Laboratório A', 'Área A', 'Responsável A'),
('LAB002', 'Laboratório B', 'Área B', 'Responsável B'),
('LAB003', 'Laboratório C', 'Área C', 'Responsável C'),
('LAB004', 'Laboratório D', 'Área D', 'Responsável D'),
('LAB005', 'Laboratório E', 'Área E', 'Responsável E');

-- Inserindo dados na tabela Equipamento
INSERT INTO Equipamento (TAG_Identificacao, Nome, Numero_serie, Localizacao, ID_Laboratorio, ID_Fornecedor) VALUES
('EQ001', 'Equipamento 1', 'S001', 'Laboratório A', 'LAB001', '12345678000195'),
('EQ002', 'Equipamento 2', 'S002', 'Laboratório B', 'LAB002', '98765432000196'),
('EQ003', 'Equipamento 3', 'S003', 'Laboratório C', 'LAB003', '11223344000197'),
('EQ004', 'Equipamento 4', 'S004', 'Laboratório D', 'LAB004', '55667788000198'),
('EQ005', 'Equipamento 5', 'S005', 'Laboratório E', 'LAB005', '99887766000199');

-- Inserindo dados na tabela Checagens
INSERT INTO Checagens (ID_Checagem, Numero_revisao, Nome, Data, Descricao) VALUES
('CH001', 1, 'Checagem 1', '2024-01-01', 'Descrição da checagem 1'),
('CH002', 2, 'Checagem 2', '2024-02-01', 'Descrição da checagem 2'),
('CH003', 1, 'Checagem 3', '2024-03-01', 'Descrição da checagem 3'),
('CH004', 1, 'Checagem 4', '2024-04-01', 'Descrição da checagem 4'),
('CH005', 2, 'Checagem 5', '2024-05-01', 'Descrição da checagem 5');

-- Inserindo dados na tabela Calibração
INSERT INTO Calibracao (ID_Checagem, Certificado) VALUES
('CH001', 'Certificado A'),
('CH003', 'Certificado B');

-- Inserindo dados na tabela Manutenção
INSERT INTO Manutencao (ID_Checagem, Problema_apresentado, Status) VALUES
('CH002', 'Troca de peça', 'Concluída'),
('CH004', 'Ajuste de medição', 'Pendente');

-- Inserindo dados na tabela Sofre
INSERT INTO Sofre (ID_Equipamento, ID_Checagem) VALUES
('EQ001', 'CH001'),
('EQ002', 'CH002'),
('EQ003', 'CH003'),
('EQ004', 'CH004'),
('EQ005', 'CH005');
