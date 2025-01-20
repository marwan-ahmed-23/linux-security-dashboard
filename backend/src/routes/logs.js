const router = require('express').Router();
const logsController = require('../controllers/logsController');

router.get('/failed-logins', logsController.getFailedLogins);

router.delete('/cleanup', logsController.cleanupOldLogs);

module.exports = router;
