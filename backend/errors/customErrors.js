// /errors/customErrors.js

// Custom error class for 404 Not Found errors
class NotFoundError extends Error {
  constructor(message) {
    super(message);
    this.name = 'NotFoundError';
  }
}

// Custom error class for 403 Forbidden errors
class ForbiddenError extends Error {
  constructor(message) {
    super(message);
    this.name = 'ForbiddenError';
  }
}

// Export the custom error classes
module.exports = { NotFoundError, ForbiddenError };
