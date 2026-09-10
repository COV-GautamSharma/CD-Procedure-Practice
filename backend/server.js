const express = require("express");

const app = express();

const PORT = 5000;
const VERSION = "1.0.0";

app.get("/api/status", (req, res) => {
    res.json({
        status: "running",
        message: "Backend is running!",
        version: VERSION
    });
});

app.get("/health", (req, res) => {
    res.status(200).send("OK");
});

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Backend running on port ${PORT}`);
});