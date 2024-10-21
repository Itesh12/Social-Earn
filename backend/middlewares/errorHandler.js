// Centralized Error Handling Middleware

// Custom error handler function
const errorHandler = (err, req, res, next) => {
  // Log the error for debugging
  console.error(err);

  // Determine the response structure based on the error type
  let status = 500; // Default to Internal Server Error
  let message = 'An unexpected error occurred'; // Default error message

  // Handle common types of errors
  if (err.name === 'ValidationError') {
    status = 400; // Bad Request
    message = err.message || 'Validation error occurred';
  } else if (err.name === 'CastError') {
    status = 400; // Bad Request for invalid ObjectId
    message = 'Invalid ID format';
  } else if (err.name === 'MongoError' && err.code === 11000) {
    status = 409; // Conflict for duplicate key error
    message = 'Duplicate key error: a user with this email already exists';
  } else if (err.name === 'NotFoundError') {
    status = 404; // Not Found
    message = err.message || 'Resource not found';
  } else if (err.name === 'ForbiddenError') {
    status = 403; // Forbidden
    message = err.message || 'Access forbidden';
  } else if (err.status) {
    status = err.status; // Custom status set on the error object
    message = err.message || message; // Use the error message if provided
  }

  // Respond with a structured format
  res.status(status).json({
    s: 0, // Status: 0 for failure
    m: message, // Error message
    r: {}, // Empty response object for errors
  });
};

// Global error handler for unhandled promise rejections
process.on('unhandledRejection', (reason, promise) => {
  console.error('Unhandled Rejection at:', promise, 'reason:', reason);
});

// Module exports
module.exports = errorHandler;
