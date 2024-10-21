// Import the Express framework to create the router
const express = require('express');

// Import the user controller that handles user-related logic
const userController = require('../controllers/userController');

// Import the authentication middleware to protect user routes
const { authenticate } = require('../middlewares/authMiddleware');

// Import the multer config
const upload = require('../utils/multerConfig');

// Create a new router instance for defining user-related routes
const router = express.Router();

// Define CRUD operations for user management

// GET route to retrieve all users
// This route is protected by the authenticate middleware
router.get('/', authenticate, userController.getAllUsers);

// PUT route to update a user's information by their ID
// This route requires authentication before allowing the update operation
router.put('/', authenticate, upload.none(), userController.updateUser);

// DELETE route to remove a user by their ID
// This route is protected by the authenticate middleware
router.delete('/', authenticate, userController.deleteUser);

// Export the router to be used in other parts of the application
module.exports = router;
