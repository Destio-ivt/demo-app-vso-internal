import './App.css'

function App() {
  const envVars = [
    { key: 'App Title', value: import.meta.env.VITE_APP_TITLE },
    { key: 'API Endpoint', value: import.meta.env.VITE_API_ENDPOINT },
    { key: 'Max Retries', value: import.meta.env.VITE_MAX_RETRIES },
    { key: 'Enable Analytics', value: import.meta.env.VITE_ENABLE_ANALYTICS },
    { key: 'Theme Color', value: import.meta.env.VITE_THEME_COLOR },
    { key: 'Support Email', value: import.meta.env.VITE_SUPPORT_EMAIL },
    { key: 'Session Timeout', value: import.meta.env.VITE_SESSION_TIMEOUT_MINUTES },
    { key: 'Beta Feature', value: import.meta.env.VITE_FEATURE_FLAG_BETA },
    { key: 'Company Name', value: import.meta.env.VITE_COMPANY_NAME },
    { key: 'App Version', value: import.meta.env.VITE_APP_VERSION },
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
