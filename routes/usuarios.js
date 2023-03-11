var express = require('express');
var router = express.Router();
var fs = require('fs');
const { path } = require('../app');


// Listar usuarios 
router.get('/', function (req, res, next) {
    fs.readFile('./data/usuarios.json', "utf8", (err, data) => {

        res.send(data);
    })
});



// Listar usuarios por ID
router.get('/:id', function (req, res, next) {
    fs.readFile('./data/usuarios.json', "utf8", (err, data) => {
        
        try {
            const usuarios = JSON.parse(data);
            const id = req.params.id;

            const usuarioProcurado = usuarios.find((usuario) => usuario.id === id);
            if(!usuarioProcurado) {
                return res.status(404).send()
            }

            res.send(usuarioProcurado);
        } catch (err) {
            res.status(err.status)
            res.send(err.message)
        }

    })
});



// Criar usuarios
router.post('/', function (req, res, next) {
    fs.readFile('./data/usuarios.json', "utf8", (err, data) => {
        try {
            const usuarios = JSON.parse(data)

            const maiorId = usuarios.reduce((max, obj) => {
                return obj.id > max ? obj.id : max;
            }, 0);

            const novoId = parseInt(maiorId) + 1 + "";
            const usuarioNovo = req.body;
            usuarioNovo.id = novoId;
            usuarios.push(usuarioNovo);
            fs.writeFileSync('./data/usuarios.json', JSON.stringify(usuarios))

            res.send(usuarioNovo)
        } catch (err) {
            res.status(err.status)
            res.send(err)
        }

    })
});



// Atualizar usuarios
function update(req, res, next) {
    fs.readFile('./data/usuarios.json', "utf8", (err, data) => {
        try {
            const usuarios = JSON.parse(data);
            const id = req.params.id;

            const usuarioRequisitado = usuarios.find((usuario) => usuario.id === id);
            const usuarioAlterado = { ...usuarioRequisitado, ...req.body };
            usuarioAlterado.id = id;
            fs.writeFileSync('./data/usuarios.json', JSON.stringify(usuarios));

            res.send(usuarioAlterado);
        } catch {
            res.status(err.status)
            res.send(err.message)
        }

    })
}
router.put('/:id', update);
router.patch('/:id', update);



// Apagar usuarios
router.delete('/:id', function (req, res, next) {
    fs.readFile('./data/usuarios.json', "utf8", (err, data) => {
        const usuarios = JSON.parse(data)
        const id = req.params.id

        const usuarioDeletado = usuarios.find((usuario) => usuario.id === id)
        const novosUsuarios = usuarios.filter((usuario) => usuario.id !== id)

        fs.writeFileSync('./data/usuarios.json', JSON.stringify(novosUsuarios))

        res.send(usuarioDeletado)
    })
});



module.exports = router;
