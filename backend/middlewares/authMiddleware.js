// Import the JWT utility for token verification
const jwt = require('../utils/jwt');

// Middleware to authenticate routes: Protects routes by verifying JWT tokens
exports.authenticate = (req, res, next) => {
  // Get the token from the Authorization header
  const authHeader = req.headers.authorization;

  // Check if the header is in the correct format
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res
      .status(401)
      .json({ message: 'No token provided or invalid format' });
  }

  // Extract the token from the header
  const token = authHeader.split(' ')[1];

  // Verify the provided token using the jwt utility
  jwt.verifyToken(token, (err, decoded) => {
    if (err) {
      // If the token is invalid or verification fails, return an unauthorized response
      return res.status(401).json({ message: 'Invalid token' });
    }

    // If the token is valid, attach the decoded user information to the request object
    req.user = decoded;

    // Call the next middleware in the stack
    next();
  });
};
