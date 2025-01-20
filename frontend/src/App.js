import React from 'react';
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import SystemDashboard from './components/SystemDashboard';
import PortList from './components/PortList';
import VulnerabilityScanner from './components/VulnerabilityScanner';
import LogsView from './components/LogsView';

function App() {
  return (
    <Router>
      <nav className="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
        <div className="container-fluid">
          <Link to="/" className="navbar-brand">Linux Security Dashboard</Link>
          <div>
            <Link to="/ports" className="btn btn-outline-light me-2">Open Ports</Link>
            <Link to="/vulnerabilities" className="btn btn-outline-light me-2">Scanner</Link>
            <Link to="/logs" className="btn btn-outline-light">Logs</Link>
          </div>
        </div>
      </nav>
      <div className="container">
        <Routes>
          <Route path="/" element={<SystemDashboard />} />
          <Route path="/ports" element={<PortList />} />
          <Route path="/vulnerabilities" element={<VulnerabilityScanner />} />
          <Route path="/logs" element={<LogsView />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
