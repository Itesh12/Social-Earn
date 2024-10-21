// Import the jsonwebtoken library for handling JSON Web Tokens (JWT)
const jwt = require('jsonwebtoken');

// Set the secret key used for signing the JWTs
// The secret is retrieved from the environment variables or defaults to 'supersecret'
const secret = process.env.JWT_SECRET || 'supersecret';

// Utility functions for generating and verifying JWT tokens

// Generate JWT Token: Creates a signed JWT token with a given payload
exports.generateToken = (payload) => {
  // Sign the payload to create a token with the specified expiration time (30 days)
  return jwt.sign(payload, secret, { expiresIn: process.env.JWT_EXPIRES_IN });
};

// Verify JWT Token: Validates a given token and decodes its payload
exports.verifyToken = (token, callback) => {
  // Use jwt.verify to check the token's validity against the secret key
  jwt.verify(token, secret, callback); // Call the callback with the verification result
};
