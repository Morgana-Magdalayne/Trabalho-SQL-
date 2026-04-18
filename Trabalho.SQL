-- CRIAÇÃO DO BANCO
CREATE DATABASE ecommerce;
USE ecommerce;

-- ======================
-- CLIENTE
-- ======================
CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    tipo ENUM('PF', 'PJ') NOT NULL
);

CREATE TABLE cliente_pf (
    id_cliente INT PRIMARY KEY,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE cliente_pj (
    id_cliente INT PRIMARY KEY,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- ======================
-- PRODUTO
-- ======================
CREATE TABLE produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL
);

-- ======================
-- FORNECEDOR
-- ======================
CREATE TABLE fornecedor (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL
);

-- RELAÇÃO PRODUTO-FORNECEDOR (N:N)
CREATE TABLE produto_fornecedor (
    id_produto INT,
    id_fornecedor INT,
    PRIMARY KEY (id_produto, id_fornecedor),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor)
);

-- ======================
-- ESTOQUE
-- ======================
CREATE TABLE estoque (
    id_produto INT PRIMARY KEY,
    quantidade INT NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- ======================
-- PEDIDO
-- ======================
CREATE TABLE pedido (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pendente', 'Pago', 'Enviado', 'Entregue', 'Cancelado') DEFAULT 'Pendente',
    valor_total DECIMAL(10,2),

    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- ITENS DO PEDIDO (N:N)
CREATE TABLE item_pedido (
    id_pedido INT,
    id_produto INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- ======================
-- PAGAMENTO
-- ======================
CREATE TABLE pagamento (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,

    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- ======================
-- ENTREGA
-- ======================
CREATE TABLE entrega (
    id_entrega INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    status VARCHAR(50),
    codigo_rastreio VARCHAR(50),

    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);
