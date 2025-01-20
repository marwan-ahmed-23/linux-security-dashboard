const router = require('express').Router();
const vulnerabilityController = require('../controllers/vulnerabilityController');

router.post('/scan', vulnerabilityController.runScan);

router.get('/results', vulnerabilityController.getScanResults);

module.exports = router;
