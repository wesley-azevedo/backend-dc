CREATE TABLE `usuario` (
  `id` int NOT NULL,
  `username` varchar(55) NOT NULL,
  `name` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`)
);

CREATE TABLE `produto` (
  `id` int NOT NULL,
  `categoria` varchar(45) NOT NULL,
  `descricao` varchar(45) NOT NULL,
  `valor` decimal(45,0) NOT NULL,
  `img` varchar(45) DEFAULT NULL,
  `desconto` decimal(45,0) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `carrinho` (
  `id` int NOT NULL,
  `desconto` decimal(10,0) DEFAULT '0',
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuario_id_UNIQUE` (`usuario_id`),
  KEY `chaveEstrangeiraXXYY_idx` (`usuario_id`),
  CONSTRAINT `chaveEstrangeiraXXYY` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
);


select * from fs08.produto;

-- INSERT INTO `fs08`.`produto` (`id`, `categoria`, `descricao`, `valor`, `desconto`) VALUES ('1', 'calçados', 'muito bom', '200', '50');
-- INSERT INTO `fs08`.`produto` (`id`, `categoria`, `descricao`, `valor`, `desconto`) VALUES ('2', 'calçados', 'não muito bom', '100', '75');

select * from fs08.usuario;
select * from fs08.carrinho;


select * from fs08.usuario, fs08.carrinho;

SELECT carrinho.desconto FROM fs08.usuario INNER JOIN fs08.carrinho ON usuario.id = carrinho.usuario_id;

