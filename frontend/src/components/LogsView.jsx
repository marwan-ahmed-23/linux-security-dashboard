import React, { useEffect, useState } from 'react';
import api from '../services/api';

function LogsView() {
  const [failedLogins, setFailedLogins] = useState([]);

  useEffect(() => {
    api.get('/logs/failed-logins')
      .then(res => setFailedLogins(res.data))
      .catch(err => console.error(err));
  }, []);

  return (
    <div className="container">
      <h2>Failed Login Attempts</h2>
      <ul className="list-group">
        {failedLogins.map((line, idx) => (
          <li key={idx} className="list-group-item">
            {line}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default LogsView;
