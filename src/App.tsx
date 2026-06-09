import './App.css'

import { useEffect, useState } from 'react';
import './App.css'

function App() {
  const [config, setConfig] = useState<any>(null);

  useEffect(() => {
    fetch('/config.json')
      .then((res) => res.json())
      .then((data) => setConfig(data))
      .catch((err) => console.error("Gagal memuat config", err));
  }, []);

  if (!config) {
    return <div>Loading configuration...</div>;
  }

  const envVars = [
    { key: 'App Title', value: config.VITE_APP_TITLE },
    { key: 'API Endpoint', value: config.VITE_API_ENDPOINT },
    { key: 'Max Retries', value: config.VITE_MAX_RETRIES },
    { key: 'Enable Analytics', value: config.VITE_ENABLE_ANALYTICS },
    { key: 'Theme Color', value: config.VITE_THEME_COLOR },
    { key: 'Support Email', value: config.VITE_SUPPORT_EMAIL },
    { key: 'Session Timeout', value: config.VITE_SESSION_TIMEOUT_MINUTES },
    { key: 'Beta Feature', value: config.VITE_FEATURE_FLAG_BETA },
    { key: 'Company Name', value: config.VITE_COMPANY_NAME },
    { key: 'App Version', value: config.VITE_APP_VERSION },
  ];

  return (
    <div className="container">
      <h1>Environment Configuration</h1>
      <table>
        <thead>
          <tr>
            <th>Setting</th>
            <th>Value</th>
          </tr>
        </thead>
        <tbody>
          {envVars.map((item) => (
            <tr key={item.key}>
              <td>{item.key}</td>
              <td>{item.value}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  )
}

export default App
