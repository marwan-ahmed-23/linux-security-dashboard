import React, { useEffect, useState } from 'react';
import api from '../services/api';

function PortList() {
  const [ports, setPorts] = useState([]);

  useEffect(() => {
    api.get('/system/ports')
      .then(res => {
        setPorts(res.data);
      })
      .catch(err => console.error(err));
  }, []);

  return (
    <div className="container">
      <h2>Open Ports</h2>
      <ul className="list-group">
        {ports.map((line, idx) => (
          <li key={idx} className="list-group-item">
            {line}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default PortList;
