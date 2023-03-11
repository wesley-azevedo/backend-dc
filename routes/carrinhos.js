var express = require('express');
var router = express.Router();
var fs = require('fs');

// Listar carrinhos
router.get('/', function (req, res, next) {
    fs.readFile('./data/carrinhos.json', "utf8", (err, data) => {
        res.send(data);
    })
});



// Pegar carrinho de um usuario
router.get('/usuario/:usuario_id', function (req, res, next) {
    fs.readFile('./data/carrinhos.json', "utf8", (err, data) => {

        try {
            const carrinhos = JSON.parse(data);
            const usuario_id = req.params.usuario_id;

            const carrinhoEncontrado = carrinhos.find((carrinho) => carrinho.usuario_id === usuario_id)

            if (!carrinhoEncontrado) {
                return res.status(404).send()
            }

            res.send(carrinhoEncontrado);
        } catch (err) {
            res.status(err.status)
            res.send(err.message)
        }

    })
});

// Pegar valor carrinho de um usuario
router.get('/usuario/valor/:usuario_id', function (req, res, next) {
    fs.readFile('./data/carrinhos.json', "utf8", (err, dataCarrinhos) => {
        fs.readFile('./data/produtos.json', "utf8", (err, dataProdutos) => { // ler o arquivo
            try {
                const carrinhos = JSON.parse(dataCarrinhos);
                const produtos = JSON.parse(dataProdutos);
                const usuario_id = req.params.usuario_id;

                const carrinhoDoUsuarioRequerido = carrinhos.find((carrinho) => carrinho.usuario_id === usuario_id)

                if (!carrinhoDoUsuarioRequerido) {
                    return res.status(404).send()
                }
                carrinhoDoUsuarioRequerido.produtos = carrinhoDoUsuarioRequerido.produtos.map((produtoCarrinho) => {
                    const produto = produtos.find((produto) => produtoCarrinho.produto_id === produto.id)
                    return {
                        ...produto,
                        quantidade: produtoCarrinho.quantidade,
                    }
                })

                const valorProdutos = carrinhoDoUsuarioRequerido.produtos.map(produto =>
                    produto.quantidade * produto.valor * (1 - ((produto.desconto || 0) / 100)))

                console.log(valorProdutos)
                let somaProdutos = 0
                valorProdutos.forEach(valor => {
                    somaProdutos += valor
                });

                const valorTotalCarrinho = somaProdutos * (1 - (carrinhoDoUsuarioRequerido.desconto / 100))

                res.send({
                    ...carrinhoDoUsuarioRequerido,
                    valorTotalCarrinho
                });

            } catch (err) {
                res.status(err.status)
                res.send(err.message)
            }
        })

    })
});

module.exports = router;
