select * from fs08.produto;

-- INSERT INTO `fs08`.`produto` (`id`, `categoria`, `descricao`, `valor`, `desconto`) VALUES ('1', 'calçados', 'muito bom', '200', '50');
-- INSERT INTO `fs08`.`produto` (`id`, `categoria`, `descricao`, `valor`, `desconto`) VALUES ('2', 'calçados', 'não muito bom', '100', '75');

select * from fs08.usuario;
select * from fs08.carrinho;


select * from fs08.usuario, fs08.carrinho;

SELECT carrinho.desconto FROM fs08.usuario INNER JOIN fs08.carrinho ON usuario.id = carrinho.usuario_id;