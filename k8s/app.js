const express = require('express');
const app = express();
const port = 3000;
const secureCredentials = process.env.SECURE_CREDENTIALS || "default_secure_credentials";
app.get('/', (req, res) => {
  res.send(`Hello from Node.js! Secure credentials: ${secureCredentials}`);
});

// Health check endpoint for Kubernetes liveness probe
app.get('/healthz', (req, res) => {
  res.sendStatus(200);
});

// Health check endpoint for Kubernetes readiness probe
app.get('/ready', (req, res) => {
  res.sendStatus(200);
});

// Start the server
app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});

