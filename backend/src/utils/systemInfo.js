const { exec } = require('child_process');
const os = require('os');

exports.fetchSystemInfo = async () => {
  return {
    platform: os.platform(),
    hostname: os.hostname(),
    uptime: os.uptime(),
    arch: os.arch(),
    cpuCores: os.cpus().length,
    totalMemoryMB: Math.round(os.totalmem() / 1024 / 1024),
    freeMemoryMB: Math.round(os.freemem() / 1024 / 1024),
  };
};

exports.fetchOpenPorts = async () => {
  return new Promise((resolve, reject) => {
    exec('ss -tuln', (err, stdout, stderr) => {
      if (err) return reject(err);
      const lines = stdout.split('\n').slice(1);
      const ports = lines.map(line => line.trim()).filter(line => line);
      resolve(ports);
    });
  });
};

exports.fetchFailedLogins = async () => {
  return new Promise((resolve, reject) => {
    exec("grep 'Failed password' /var/log/auth.log | tail -n 10", (err, stdout, stderr) => {
      if (err) return reject(err);
      const lines = stdout.split('\n').filter(line => line);
      resolve(lines);
    });
  });
};
