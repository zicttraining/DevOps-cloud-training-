const http = require('http');
const fs = require('fs');
const path = require('path');
const express = require('express');

const hostname = '127.0.0.1';
const port = 3000;

const app = express();

// Serve static files from the 'public' directory
app.use(express.static(path.join(__dirname, 'public')));

const server = http.createServer(app);

server.listen(port, hostname, () => {
    console.log(`Server running at http://${hostname}:${port}/`);
});
