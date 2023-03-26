------------------------------------------------------------
-------------------------USUARIO----------------------------
------------------------------------------------------------
-- Criar tabela usuario
CREATE TABLE
	`fs08`.`usuario` (
		`id` INT NOT NULL AUTO_INCREMENT,
		`username` VARCHAR(45) NOT NULL,
		`email` VARCHAR(45) NOT NULL,
		`password` VARCHAR(45) NOT NULL,
		PRIMARY KEY (`id`),
		UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE, -- Não é necessario, deixei apenas como referência de estudo (MySQL Workbench criou automático)
		UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE -- Não é necessario, deixei apenas como referência de estudo (MySQL Workbench criou automático)
	);

-- Inserindo valores iniciais na tabela usuario
INSERT INTO
	`fs08`.`usuario` (`username`, `email`, `password`)
VALUES
	('allan', 'allan@mail.com', '1234');

INSERT INTO
	`fs08`.`usuario` (`username`, `email`, `password`)
VALUES
	('joao', 'joao@mail.com', '1234');

INSERT INTO
	`fs08`.`usuario` (`username`, `email`, `password`)
VALUES
	('jose', 'jose@mail.com', '1234');

-- Retorna as informacoes da tabela de usuarios
SELECT
	*
FROM
	fs08.usuario;

-- id,username,email,password
-- 1,allan,allan@mail.com,1234
-- 2,joao,joao@mail.com,1234
-- 3,jose,jose@mail.com,1234
------------------------------------------------------------
-------------------------CARRINHO---------------------------
------------------------------------------------------------
-- Criar tabela carrinho
CREATE TABLE
	`fs08`.`carrinho` (
		`id` INT NOT NULL AUTO_INCREMENT,
		`desconto` DECIMAL(5, 2) NULL,
		`usuario_id` INT NULL,
		PRIMARY KEY (`id`),
		INDEX `chave estrangeira usuario_idx` (`usuario_id` ASC) VISIBLE, -- Não é necessario, deixei apenas como referência de estudo (MySQL Workbench criou automático)
		CONSTRAINT `chave estrangeira usuario` FOREIGN KEY (`usuario_id`) REFERENCES `fs08`.`usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
	);

-- Inserindo valores iniciais na tabela carrinho
INSERT INTO
	`fs08`.`carrinho` (`desconto`, `usuario_id`)
VALUES
	(20, 3);

INSERT INTO
	`fs08`.`carrinho` (`desconto`, `usuario_id`)
VALUES
	(30, 2);

INSERT INTO
	`fs08`.`carrinho` (`desconto`, `usuario_id`)
VALUES
	(10, 4);

INSERT INTO
	`fs08`.`carrinho` (`desconto`, `usuario_id`)
VALUES
	(0, 1);

-- Retorna as informacoes da tabela de carrinhos
select
	*
from
	fs08.carrinho;

-- id,desconto,usuario_id
-- 1,20.00,3
-- 2,30.00,2
-- 4,0.00,1
------------------------------------------------------------
-------------------------PRODUTO----------------------------
------------------------------------------------------------
-- Criar tabela produto
CREATE TABLE
	`fs08`.`produto` (
		`id` INT NOT NULL AUTO_INCREMENT,
		`categoria` VARCHAR(45) NULL,
		`descricao` VARCHAR(45) NULL,
		`valor` DECIMAL(10) NULL,
		`img` VARCHAR(45) NULL,
		`desconto` DECIMAL(5, 2) NULL,
		PRIMARY KEY (`id`)
	);

-- Inserindo valores iniciais na tabela produto
INSERT INTO
	`fs08`.`produto` (
		`categoria`,
		`descricao`,
		`valor`,
		`img`,
		`desconto`
	)
VALUES
	('tenis', 'tenis1', 100, 'http://imagem.com', 30);

INSERT INTO
	`fs08`.`produto` (
		`categoria`,
		`descricao`,
		`valor`,
		`img`,
		`desconto`
	)
VALUES
	('tenis', 'tenis2', 200, 'http://imagem.com', 30);

INSERT INTO
	`fs08`.`produto` (
		`categoria`,
		`descricao`,
		`valor`,
		`img`,
		`desconto`
	)
VALUES
	('tenis', 'tenis3', 50, 'http://imagem.com', 20);

-- Retorna as informacoes da tabela de produtos
-- id,categoria,descricao,valor,img,desconto
-- 1,tenis,tenis1,100,1,30
-- 2,tenis,tenis2,200,1,30
-- 3,tenis,tenis3,50,1,20
select
	*
from
	fs08.produto;

------------------------------------------------------------
---------------------CARRINHO_PRODUTO-----------------------
------------------------------------------------------------
-- Criar tabela carrinho_produto
CREATE TABLE
	`fs08`.`carrinho_produto` (
		`id` INT NOT NULL AUTO_INCREMENT,
		`carrinho_Id` INT NULL,
		`produto_id` INT NULL,
		`quantidade` INT NULL,
		PRIMARY KEY (`id`),
		INDEX `chave estrangeira carrinho_idx` (`carrinho_Id` ASC) VISIBLE, -- Não é necessario, deixei apenas como referência de estudo (MySQL Workbench criou automático)
		INDEX `chave estrangeira produto_idx` (`produto_id` ASC) VISIBLE, -- Não é necessario, deixei apenas como referência de estudo (MySQL Workbench criou automático)
		CONSTRAINT `chave estrangeira carrinho` FOREIGN KEY (`carrinho_Id`) REFERENCES `fs08`.`carrinho` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
		CONSTRAINT `chave estrangeira produto` FOREIGN KEY (`produto_id`) REFERENCES `fs08`.`produto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
	);

-- Inserindo valores iniciais na tabela carrinho_produto
insert into
	fs08.carrinho_produto (carrinho_id, produto_id, quantidade)
values
	(1, 1, 10);

insert into
	fs08.carrinho_produto (carrinho_id, produto_id, quantidade)
values
	(1, 2, 20);

insert into
	fs08.carrinho_produto (carrinho_id, produto_id, quantidade)
values
	(2, 2, 30);

insert into
	fs08.carrinho_produto (carrinho_id, produto_id, quantidade)
values
	(3, 1, 40);

-- Tabela auxiliar que guarda as informacoes de quais produtos estao em quais carrinhos, unico dado que é guardado: quantidade
select
	*
from
	fs08.carrinho_produto;

-- id,carrinho_Id,produto_id,quantidade
-- 1,1,1,10
-- 2,1,2,20
-- 3,2,2,30
------------------------------------------------------------
---------------------------SQL------------------------------
------------------------------------------------------------
-- Atualiza o produto com id 1 para ter o valor desconto = 30
update fs08.produto
set
	desconto = 30
where
	id = 1;

-- Atualiza o produto com id 2 Spara ter o valor desconto = 15
update fs08.produto
set
	desconto = 15
where
	id = 2;

-- Exibir todas as ligacoes entre usuarios e carrinho (sem filtrar os usuarios e carrinhos corretos) A * B (Todas as combinações)
SELECT
	*
FROM
	fs08.usuario,
	fs08.carrinho;

-- As combinacoes de carrinhos que poussuem usuario;
SELECT
	*
FROM
	fs08.usuario,
	fs08.carrinho
where
	usuario.id = carrinho.usuario_id;

-- As combinacoes de carrinhos que poussuem usuario (Recomendo usar este ao invés do anterior)
SELECT
	*
FROM
	fs08.usuario
	inner JOIN fs08.carrinho ON usuario.id = carrinho.usuario_id;

-- Combinacao do carrinho do usuario 3 (Combinacao entre tds os usuarios que possuem carrinho, mas somente do usuario 3)
SELECT
	*
FROM
	fs08.usuario
	inner JOIN fs08.carrinho ON usuario.id = carrinho.usuario_id
where
	usuario.id = 3;

-- Combinacao do carrinho do usuario 3 (Combinacao entre tds os usuarios que possuem carrinho, mas somente do usuario 3)
-- traga apenas o carrinho
SELECT
	carrinho_id
FROM
	fs08.usuario
	inner JOIN fs08.carrinho ON usuario.id = carrinho.usuario_id
where
	usuario.id = 4;

-- Os carrinhos que possuem produtos dentro, filtrado pelo carrinho 2;
-- Somente colunas produto.id, quantidade, descricao
select
	produto.id,
	carrinho_produto.quantidade,
	produto.descricao
from
	fs08.carrinho_produto
	inner JOIN fs08.produto on carrinho_produto.produto_id = produto.id
where
	carrinho_id = 2;

-- Quais os produtos, quantidade, descricao do usuario 3?
select
	produto.id,
	carrinho_produto.quantidade,
	produto.descricao
from
	fs08.carrinho_produto
	inner JOIN fs08.produto on carrinho_produto.produto_id = produto.id
where
	carrinho_id = (
		SELECT
			carrinho.id
		FROM
			fs08.usuario
			inner JOIN fs08.carrinho ON usuario.id = carrinho.usuario_id
		where
			usuario.id = 3
	);