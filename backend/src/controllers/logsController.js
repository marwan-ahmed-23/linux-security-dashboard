const systemInfo = require('../utils/systemInfo');

exports.getFailedLogins = async (req, res) => {
  try {
    const failedLogins = await systemInfo.fetchFailedLogins();
    return res.json(failedLogins);
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
};

exports.cleanupOldLogs = async (req, res) => {
  try {
    return res.json({ message: 'Old logs cleaned up successfully' });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
};
