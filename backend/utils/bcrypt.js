// Import the bcryptjs library for hashing and comparing passwords
const bcrypt = require('bcryptjs');

// Utility to handle password hashing and comparison

// Hash Password: Takes a plain text password and returns a hashed version
exports.hashPassword = (password, callback) => {
  // Use bcrypt's hash function to create a hash of the password
  // The second argument (10) is the number of salt rounds to use
  bcrypt.hash(password, 10, (err, hash) => {
    if (err) throw err; // Throw an error if hashing fails
    callback(hash); // Call the provided callback with the generated hash
  });
};

// Compare Password: Compares a plain text password with a hashed password
exports.comparePassword = (password, hash, callback) => {
  // Use bcrypt's compare function to check if the password matches the hash
  bcrypt.compare(password, hash, (err, isMatch) => {
    if (err) throw err; // Throw an error if comparison fails
    callback(isMatch); // Call the provided callback with the result (true or false)
  });
};
