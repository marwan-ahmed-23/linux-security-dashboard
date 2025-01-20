const router = require('express').Router();
const systemController = require('../controllers/systemController');

router.get('/info', systemController.getSystemInfo);

router.get('/ports', systemController.getOpenPorts);

module.exports = router;
