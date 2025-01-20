const systemInfo = require('../utils/systemInfo');

exports.getSystemInfo = async (req, res) => {
  try {
    const info = await systemInfo.fetchSystemInfo();
    return res.json(info);
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
};

exports.getOpenPorts = async (req, res) => {
  try {
    const ports = await systemInfo.fetchOpenPorts();
    return res.json(ports);
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
};
