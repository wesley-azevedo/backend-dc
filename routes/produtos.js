var express = require('express');
var router = express.Router();
var fs = require('fs');


// Listar produtos Lucas e Wesley
router.get('/', function (req, res, next) {
    fs.readFile('./data/produtos.json', "utf8", (err, data) => { // ler o arquivo

        res.send(data) //envio tudo na tela do inmsonia
    })
});

// Listar produtos por ID Guilherme e Hélio
router.get('/:id', function (req, res, next) {
    fs.readFile('./data/produtos.json', "utf8", (err, data) => {
        const produtos = JSON.parse(data)
        const id = req.params.id

        const produtoProcurado = produtos.find((produto) => produto.id === id)//Encontro o produto procurado na url

        res.send(produtoProcurado)//mostro ele na tela do insmomnia
    })
});

// Criar produtos Deivid e Igor
router.post('/', function (req, res, next) {
    fs.readFile('./data/produtos.json', "utf8", (err, data) => { 
        const produtos = JSON.parse(data)
        
        const maiorId = produtos.reduce((max, obj) => { //eu encontro o maiorID para eu acrescentar o novo
            return obj.id > max ? obj.id : max;         //produto no final do vetor
        }, 0);
        const novoId = parseInt(maiorId) + 1;//Crio o novoID para o produto novo
        const produtoNovo = {...req.body };//Crio o novo produto

        produtoNovo.id = novoId; //Fixo o ID do novo produto
        produtos.push(produtoNovo)//Coloco no vetor
        fs.writeFileSync('./data/produtos.json', JSON.stringify(produtos))

        res.send(produtoNovo)
    })
});

// Atualizar produtos André e Rian
function update(req, res, next) {
    fs.readFile('./data/produtos.json', "utf8", (err, data) => { //Lê o arquivo
        const produtos = JSON.parse(data)
        const id = req.params.id //ID que eu quero alterar

        const produtoRequisitado = produtos.find((produto) => produto.id === id) //Encontro produto a ser alterado
        const produtoAlterado = { ...produtoRequisitado, ...req.body };//Faço o "merge" das alterações 
        produtoAlterado.id = id; //Eu deixo o ID fixo
        produtos[id-1] = produtoAlterado //Acrescento no vetor produtos o produto alterado

        fs.writeFileSync('./data/produtos.json', JSON.stringify(produtos))//Re-escrevo o arquivo com o produto alterado

        res.send(produtoAlterado)//envio o produto alterado na tela do insominia
    })
}
router.put('/:id', update);
router.patch('/:id', update);



// Apagar produtos Emmanuel
router.delete('/:id', function (req, res, next) {
    fs.readFile('./data/produtos.json', "utf8", (err, data) => {
        const produtos = JSON.parse(data)
        const id = req.params.id

        const produtoDeletado = produtos.find((produto) => produto.id === id)
        const novosProdutos = produtos.filter((produto) => produto.id !== id)

        fs.writeFileSync('./data/produtos.json', JSON.stringify(novosProdutos))

        res.send(produtoDeletado)
    })
    // res.send('Remove produto ' + req.params.id)
});



module.exports = router;
