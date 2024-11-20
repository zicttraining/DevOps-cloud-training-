const express = require("express");

const app = express();

app.get("/", (req, res) => {
  res.send("<h1>Hey guys, Welcome to my new Express Application!!</h1>");
});

app.get("/info", (req, res) => {
  res.send("hey this is /info api");
});

app.listen(3000, () => {
  console.log("listening");
});
