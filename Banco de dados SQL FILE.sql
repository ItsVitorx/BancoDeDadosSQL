-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS RestauranteDB;
USE RestauranteDB;

-- Criação da tabela Prato
CREATE TABLE IF NOT EXISTS Prato (
    Codigo_Prato INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao TEXT,
    Preco DECIMAL(10, 2) NOT NULL
);

-- Criação da tabela Cliente
CREATE TABLE IF NOT EXISTS Cliente (
    Codigo_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Telefone VARCHAR(15),
    Email VARCHAR(100)
);

-- Criação da tabela Pedido
CREATE TABLE IF NOT EXISTS Pedido (
    Codigo_Pedido INT AUTO_INCREMENT PRIMARY KEY,
    Data_Pedido DATETIME NOT NULL,
    Status VARCHAR(50) NOT NULL,
    Codigo_Cliente INT,
    FOREIGN KEY (Codigo_Cliente) REFERENCES Cliente(Codigo_Cliente)
);

-- Criação da tabela Item_Pedido
CREATE TABLE IF NOT EXISTS Item_Pedido (
    Codigo_Item INT AUTO_INCREMENT PRIMARY KEY,
    Quantidade INT NOT NULL,
    Codigo_Prato INT,
    Codigo_Pedido INT,
    FOREIGN KEY (Codigo_Prato) REFERENCES Prato(Codigo_Prato),
    FOREIGN KEY (Codigo_Pedido) REFERENCES Pedido(Codigo_Pedido)
);

-- Inserção de dados de exemplo
INSERT INTO Prato (Nome, Descricao, Preco) VALUES
('Prato 1', 'Banana Caturra Grelhada', 10.99),
('Prato 2', 'Batata frita no capricho', 12.99),
('Prato 3', 'Salada Completa', 15.99);

INSERT INTO Prato (Nome, Descricao, Preco) VALUES ('Lasanha', 'Deliciosa lasanha de carne e queijo', 19.99);

INSERT INTO Cliente (Nome, Telefone, Email) VALUES ('João Silva', '(11) 98765-4321', 'joao.silva@example.com');

INSERT INTO Pedido (Data_Pedido, Status, Codigo_Cliente) VALUES ('2024-06-05 10:30:00', 'Em andamento', 1); 

INSERT INTO Item_Pedido (Quantidade, Codigo_Prato, Codigo_Pedido) VALUES (2, 1, 1);  -- Adiciona 2 unidades do Prato 1 ao Pedido 1

-- Consultas
SELECT * FROM Prato;
SELECT * FROM Cliente;
SELECT * FROM Pedido;
SELECT * FROM Item_Pedido;
SELECT * FROM Pedido WHERE Codigo_Cliente = 1;
SELECT Prato.Nome, COUNT(Item_Pedido.Codigo_Prato) AS TotalPedidos
FROM Prato
JOIN Item_Pedido ON Prato.Codigo_Prato = Item_Pedido.Codigo_Prato
GROUP BY Prato.Codigo_Prato
ORDER BY TotalPedidos DESC
LIMIT 5;

-- Atualizações
UPDATE Prato SET Preco = 21.99 WHERE Nome = 'Lasanha';

-- Exclusões
DELETE FROM Cliente WHERE Nome = 'João Silva'; 
