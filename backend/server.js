// Import the Express framework for building the web application
const express = require('express');

// Import the body-parser middleware to parse incoming request bodies
const bodyParser = require('body-parser');

// Import route modules for authentication and user management
const authRoutes = require('./routes/authRoutes');
const userRoutes = require('./routes/userRoutes');

// Import error handler
const errorHandler = require('./middlewares/errorHandler');

// Load environment variables from a .env file into process.env
require('dotenv').config();

// Create an instance of the Express application
const app = express();

// Middleware to parse JSON requests
app.use(bodyParser.json());

// Define application routes

// Use the authentication routes for any requests to /api/v1/auth
app.use('/api/v1/auth', authRoutes);

// Use the user management routes for any requests to /api/v1/users
app.use('/api/v1/users', userRoutes);

// Centralized error handling middleware
app.use(errorHandler);

// Start the server and listen for incoming requests
const PORT = process.env.PORT || 3000; // Use the port from environment variables or default to 3000
app.listen(PORT, () => {
  // Log a message to the console when the server is successfully running
  console.log(`Server is running on port ${PORT}`);
});
