SELECT * FROM fs08.usuario; -- Retorna as informacoes da tabela de usuarios
-- id,username,email,password
-- 1,allan,asdf,asdf
-- 2,allan2,asdf21,asdf
-- 3,alaln3,asdf,32
-- 4,asdf4,asd4,asdd

select * from fs08.carrinho; -- Retorna as informacoes da tabela de carrinhos
-- id,desconto,usuario_id
-- 1,20,3
-- 2,30,2
-- 3,10,4
-- 4,0,1

select * from fs08.produto; -- Retorna as informacoes da tabela de produtos
-- id,categoria,descricao,valor,img,desconto
-- 1,tenis,tenis1,100,1,30
-- 2,tenis,tenis2,200,1,30
-- 3,tenis,tenis3,50,1,20

select * from fs08.carrinho_produto; -- Tabela auxiliar que guarda as informacoes de quais produtos estao em quais carrinhos, unico dado que é guardado: quantidade
-- id,carrinho_id,produto_id,quantidade
-- 1,1,1,10
-- 2,1,2,20
-- 3,2,2,30
-- 4,3,1,40

-- SQL para atualizar valores
update fs08.produto set desconto = 30 where id = 1;
update fs08.produto set desconto = 30 where id = 2;

-- Criar todas as ligacoes entre usuarios e carrinho (sem filtrar os usuarios e carrinhos corretos) A * B (Todas as combinacoes)
SELECT * FROM fs08.usuario, fs08.carrinho;
-- As combinacoes de carrinhos que poussuem usuario;
SELECT * FROM fs08.usuario, fs08.carrinho where usuario.id = carrinho.usuario_id;
SELECT * FROM fs08.usuario inner JOIN fs08.carrinho ON usuario.id = carrinho.usuario_id;

-- Combinacao do carrinho do usuario 4 (Combinacao entre tds os usuarios que possuem carrinho, mas somente do usuario 4)
SELECT * FROM fs08.usuario inner JOIN fs08.carrinho ON usuario.id = carrinho.usuario_id where usuario.id = 4;

-- Combinacao do carrinho do usuario 4 (Combinacao entre tds os usuarios que possuem carrinho, mas somente do usuario 4)
-- traga apenas o carrinho
SELECT carrinho_id FROM fs08.usuario inner JOIN fs08.carrinho ON usuario.id = carrinho.usuario_id where usuario.id = 4;


-- Insercoes de produtos nos carrinhos
insert into fs08.carrinho_produto (carrinho_id, produto_id, quantidade) values (1, 1, 10);
insert into fs08.carrinho_produto (carrinho_id, produto_id, quantidade) values (1, 2, 20);
insert into fs08.carrinho_produto (carrinho_id, produto_id, quantidade) values (2, 2, 30);
insert into fs08.carrinho_produto (carrinho_id, produto_id, quantidade) values (3, 1, 40);


-- Todos os carrinhos que possuem produtos dentro, filtrado pelo carrinho 3
-- Somente colunas produto.id, quantidade, descricao
select produto.id,carrinho_produto.quantidade, produto.descricao 
	from fs08.carrinho_produto inner JOIN fs08.produto on carrinho_produto.produto_id = produto.id 
	where carrinho_id = 3;

-- Quais os produtos, quantidade, descricao do usuario 4?
select produto.id,carrinho_produto.quantidade, produto.descricao 
	from fs08.carrinho_produto inner JOIN fs08.produto on carrinho_produto.produto_id = produto.id 
	where carrinho_id = (SELECT carrinho.id FROM fs08.usuario inner JOIN fs08.carrinho ON usuario.id = carrinho.usuario_id where usuario.id = 4);

