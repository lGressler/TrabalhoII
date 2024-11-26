-- Inserção de Dados para Laboratórios
INSERT INTO Laboratorio (Nome, Receitas) VALUES
('Laboratório A', 50000.00),
('Laboratório B', 35000.00),
('Laboratório C', 70000.00);

-- Inserção de Dados para Equipamentos
INSERT INTO Equipamento (TAG_Identificacao, Nome, ID_Laboratorio) VALUES
('EQ-001', 'Equipamento A', 1),
('EQ-002', 'Equipamento B', 1),
('EQ-003', 'Equipamento C', 2),
('EQ-004', 'Equipamento D', 3);

-- Inserção de Dados para Funcionários
INSERT INTO Funcionario (Nome, Cargo, ID_Laboratorio) VALUES
('João Silva', 'Técnico', 1),
('Maria Souza', 'Engenheira', 2),
('Carlos Oliveira', 'Assistente', 3);

-- Inserção de Dados para Clientes
INSERT INTO Cliente (Nome, Endereco) VALUES
('Cliente A', 'Rua X, 123'),
('Cliente B', 'Avenida Y, 456'),
('Cliente C', 'Praça Z, 789');

-- Inserção de Dados para Manutenção
INSERT INTO Manutencao (TAG_Equipamento, Custo, Data) VALUES
('EQ-001', 200.00, '2024-12-01'),
('EQ-002', 150.00, '2024-12-10');

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
