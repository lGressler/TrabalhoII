-- Criação de Tabelas

-- Tabela de Fornecedores
CREATE TABLE Fornecedor (
    CNPJ CHAR(14) PRIMARY KEY,
    Razao_Social VARCHAR(100) NOT NULL,
    Localizacao VARCHAR(100)
);

-- Tabela de Laboratórios
CREATE TABLE Laboratorio (
    ID_Laboratorio SERIAL PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Area_Atendimento VARCHAR(100) NOT NULL,
    Responsavel VARCHAR(100),
    Receitas NUMERIC(10, 2)
);

-- Tabela de Equipamentos
CREATE TABLE Equipamento (
    TAG_Identificacao VARCHAR(50) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Numero_Serie VARCHAR(50),
    Localizacao VARCHAR(100),
    ID_Laboratorio INT NOT NULL REFERENCES Laboratorio(ID_Laboratorio),
    CNPJ_Fornecedor CHAR(14) REFERENCES Fornecedor(CNPJ)
);

-- Tabela de Checagens (Base para Manutenção e Calibração)
CREATE TABLE Checagem (
    ID_Checagem SERIAL PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Data DATE NOT NULL,
    Descricao TEXT,
    TAG_Equipamento VARCHAR(50) NOT NULL REFERENCES Equipamento(TAG_Identificacao)
);

-- Tabela de Manutenção (Especialização de Checagem)
CREATE TABLE Manutencao (
    ID_Manutencao SERIAL PRIMARY KEY,
    Problema_Apresentado TEXT NOT NULL,
    Status VARCHAR(50) NOT NULL,
    Custo NUMERIC(10, 2),
    ID_Checagem INT NOT NULL REFERENCES Checagem(ID_Checagem)
);

-- Tabela de Calibração (Especialização de Checagem)
CREATE TABLE Calibracao (
    ID_Calibracao SERIAL PRIMARY KEY,
    Procedimento_Adotado TEXT NOT NULL,
    Resultado VARCHAR(50),
    Custo NUMERIC(10, 2),
    ID_Checagem INT NOT NULL REFERENCES Checagem(ID_Checagem)
);

-- Inserção de Dados

-- Inserção de Dados Falsos para Fornecedores
INSERT INTO Fornecedor (CNPJ, Razao_Social, Localizacao) VALUES
('11111111000111', 'Fornecedor X', 'Belo Horizonte'),
('22222222000122', 'Fornecedor Y', 'Porto Alegre'),
('33333333000133', 'Fornecedor Z', 'Curitiba');

-- Inserção de Dados Falsos para Laboratórios
INSERT INTO Laboratorio (Nome, Area_Atendimento, Responsavel, Receitas) VALUES
('Laboratório de Biotecnologia', 'Biotecnologia', 'Dr. Alice', 120000.00),
('Laboratório de Física', 'Física', 'Prof. Carlos', 95000.00),
('Laboratório de Engenharia', 'Engenharia', 'Eng. Laura', 105000.00);

-- Inserção de Dados Falsos para Equipamentos
INSERT INTO Equipamento (TAG_Identificacao, Nome, Numero_Serie, Localizacao, ID_Laboratorio, CNPJ_Fornecedor) VALUES
('EQ-004', 'Espectrofotômetro', 'SN11111', 'Sala 4', 1, '11111111000111'),
('EQ-005', 'Gerador', 'SN22222', 'Sala 5', 2, '22222222000122'),
('EQ-006', 'Micrômetro', 'SN33333', 'Sala 6', 3, '33333333000133'),
('EQ-007', 'Ultrassom', 'SN44444', 'Sala 7', 2, '11111111000111');

-- Inserção de Dados Falsos para Checagens
INSERT INTO Checagem (Nome, Data, Descricao, TAG_Equipamento) VALUES
('Inspeção de Funcionamento', '2024-12-01', 'Verificação do funcionamento geral.', 'EQ-004'),
('Teste de Desempenho', '2024-12-10', 'Avaliação de desempenho do gerador.', 'EQ-005'),
('Calibração de Precisão', '2024-12-05', 'Calibração de medição de espessura.', 'EQ-006'),
('Verificação de Segurança', '2024-12-15', 'Revisão dos sistemas de segurança.', 'EQ-007');

-- Inserção de Dados Falsos para Manutenção
INSERT INTO Manutencao (Problema_Apresentado, Status, Custo, ID_Checagem) VALUES
('Quebra de Fusível', 'Concluído', 250.00, 1),
('Falha no Sistema Elétrico', 'Em Progresso', 450.00, 2),
('Desgaste nas Lentes', 'Concluído', 300.00, 3),
('Vibração Excessiva', 'Concluído', 500.00, 4);

-- Inserção de Dados Falsos para Calibração
INSERT INTO Calibracao (Procedimento_Adotado, Resultado, Custo, ID_Checagem) VALUES
('Calibração com Padrão de Referência', 'Aprovado', 200.00, 1),
('Teste com Certificado Internacional', 'Aprovado', 350.00, 2),
('Ajuste de Precisão', 'Reprovado', 150.00, 3),
('Calibração com Padrão Certificado', 'Aprovado', 250.00, 4);

-- Consultas

-- Consulta 1: Laboratórios, Equipamentos e Checagens
SELECT 
    l.Nome AS Nome_Laboratorio,
    e.Nome AS Nome_Equipamento,
    c.Nome AS Nome_Checagem
FROM Laboratorio l
INNER JOIN Equipamento e ON l.ID_Laboratorio = e.ID_Laboratorio
INNER JOIN Checagem c ON e.TAG_Identificacao = c.TAG_Equipamento
ORDER BY l.Nome, e.Nome;

-- Consulta 2: Checagens, Manutenção e Calibração
SELECT 
    c.Nome AS Nome_Checagem,
    COALESCE(m.Custo, 0) + COALESCE(cal.Custo, 0) AS Custo_Total
FROM Checagem c
LEFT JOIN Manutencao m ON c.ID_Checagem = m.ID_Checagem
LEFT JOIN Calibracao cal ON c.ID_Checagem = cal.ID_Checagem
ORDER BY c.Nome;

-- Consulta 3: Custos de Calibração e Receitas
SELECT 
    l.Nome AS Nome_Laboratorio,
    cal.Procedimento_Adotado AS Evento_Calibragem,
    cal.Custo AS Custo_Calibragem,
    l.Receitas AS Receitas_Laboratorio
FROM Laboratorio l
INNER JOIN Equipamento e ON l.ID_Laboratorio = e.ID_Laboratorio
INNER JOIN Checagem c ON e.TAG_Identificacao = c.TAG_Equipamento
INNER JOIN Calibracao cal ON c.ID_Checagem = cal.ID_Checagem
GROUP BY l.Nome, cal.Procedimento_Adotado, cal.Custo, l.Receitas
HAVING cal.Custo > 0
ORDER BY l.Nome;
