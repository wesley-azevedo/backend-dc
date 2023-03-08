const express = require('express');
const router = express.Router();
const fs = require('fs');


// Listar carrinho de compras por ID de usuário
router.get('/:id', function (req, res, next) {
  fs.readFile('./data/carrinhos.json', 'utf8', (err, data) => {
    if (err) {
      console.error(err);
      res.status(500).send('Erro ao ler carrinhos de compras');
      return;
    }
    const usuarioId = req.params.id;
    const carrinhos = JSON.parse(data);
    const carrinhoDoUsuario = carrinhos.find(carrinhos => carrinhos.id === usuarioId)



    res.send(carrinhoDoUsuario);
  });
});

module.exports = router;
