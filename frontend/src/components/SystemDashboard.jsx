import React, { useEffect, useState } from 'react';
import api from '../services/api';

function SystemDashboard() {
  const [info, setInfo] = useState(null);

  useEffect(() => {
    api.get('/system/info')
      .then(res => setInfo(res.data))
      .catch(err => console.error(err));
  }, []);

  if (!info) {
    return <p>Loading system info...</p>;
  }

  return (
    <div className="container">
      <h2>System Dashboard</h2>
      <ul className="list-group">
        <li className="list-group-item">Platform: {info.platform}</li>
        <li className="list-group-item">Hostname: {info.hostname}</li>
        <li className="list-group-item">CPU Cores: {info.cpuCores}</li>
        <li className="list-group-item">Total Memory (MB): {info.totalMemoryMB}</li>
        <li className="list-group-item">Free Memory (MB): {info.freeMemoryMB}</li>
      </ul>
    </div>
  );
}

export default SystemDashboard;
