-- Cria a tabela Produto
CREATE TABLE Produto (
    idProduto INT PRIMARY KEY AUTO_INCREMENT,
    nomeProduto VARCHAR(255) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL
);

-- Cria a tabela Venda
CREATE TABLE Venda (
    idVenda INT PRIMARY KEY AUTO_INCREMENT,
    dataVenda DATETIME DEFAULT CURRENT_TIMESTAMP,
    valorTotal DECIMAL(10, 2)
);

-- Cria a tabela ItemVenda (itens que compõem uma venda)
CREATE TABLE ItemVenda (
    idItemVenda INT PRIMARY KEY AUTO_INCREMENT,
    idVenda INT NOT NULL,
    idProduto INT NOT NULL,
    valorUnitario DECIMAL(10, 2) NOT NULL,
    quantidade INT NOT NULL,
    -- Define a chave estrangeira para a tabela Venda
    FOREIGN KEY (idVenda) REFERENCES Venda(idVenda),
    -- Define a chave estrangeira para a tabela Produto
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);

-- Insere 5 produtos de exemplo
INSERT INTO Produto (nomeProduto, descricao, preco) VALUES
('Chocolate', 'Chocolate ao leite', 7.00),
('Batata', 'Batata Inglesa', 2.00),
('Sorvete', 'Sorvete sabor chocolate - Kibon', 25.00),
('Maça', 'Maça Gala.', 4.00),
('Banana', 'Banana Prata', 8.00);

-- Insere 2 vendas de exemplo
INSERT INTO Venda (dataVenda, valorTotal) VALUES
('2025-07-01 10:30:00', 0.00), -- O valor total será atualizado após a inserção dos itens
('2025-07-02 14:00:00', 0.00); -- O valor total será atualizado após a inserção dos itens

-- Insere os itens para a primeira venda (idVenda = 1)
-- Produtos: 1=Chocolate, 2=Batata, 3=Sorvete
INSERT INTO ItemVenda (idVenda, idProduto, valorUnitario, quantidade) VALUES
(1, 1, 7.00, 2),   -- 2 unidades de Chocolate @ 7.00 cada
(1, 2, 2.00, 5),   -- 5 unidades de Batata @ 2.00 cada
(1, 3, 25.00, 1);  -- 1 unidade de Sorvete @ 25.00 cada

-- Insere os itens para a segunda venda (idVenda = 2)
-- Produtos: 4=Maça, 5=Banana, 1=Chocolate
INSERT INTO ItemVenda (idVenda, idProduto, valorUnitario, quantidade) VALUES
(2, 4, 4.00, 3),   -- 3 unidades de Maça @ 4.00 cada
(2, 5, 8.00, 2),   -- 2 unidades de Banana @ 8.00 cada
(2, 1, 7.00, 1);   -- 1 unidade de Chocolate @ 7.00 cada

-- Atualiza o valorTotal para a primeira venda (idVenda = 1) com base nos itens inseridos
-- Cálculo: (7.00 * 2) + (2.00 * 5) + (25.00 * 1) = 14.00 + 10.00 + 25.00 = 49.00
UPDATE Venda
SET valorTotal = (SELECT SUM(valorUnitario * quantidade) FROM ItemVenda WHERE idVenda = 1)
WHERE idVenda = 1;

-- Atualiza o valorTotal para a segunda venda (idVenda = 2) com base nos itens inseridos
-- Cálculo: (4.00 * 3) + (8.00 * 2) + (7.00 * 1) = 12.00 + 16.00 + 7.00 = 35.00
UPDATE Venda
SET valorTotal = (SELECT SUM(valorUnitario * quantidade) FROM ItemVenda WHERE idVenda = 2)
WHERE idVenda = 2;
