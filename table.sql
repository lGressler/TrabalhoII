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
