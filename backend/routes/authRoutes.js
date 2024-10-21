// Import the Express framework to create the router
const express = require('express');

// Import the authentication controller that handles registration and login logic
const authController = require('../controllers/authController');

// Import the multer config
const upload = require('../utils/multerConfig');

// Create a new router instance for defining authentication routes
const router = express.Router();

// Define routes for user registration and login

// POST route for user registration
// Calls the register method from the authController to handle the registration logic
router.post('/register', upload.none(), authController.register);

// POST route for user login
// Calls the login method from the authController to handle the login logic
router.post('/login', upload.none(), authController.login);

// Export the router to be used in other parts of the application
module.exports = router;
