// Import the mysql2 library for MySQL database connection
const mysql = require('mysql2');

// Load environment variables from a .env file
require('dotenv').config();

// Create a MySQL database connection using credentials from environment variables
const db = mysql.createConnection({
  host: process.env.DB_HOST, // The hostname of the database server
  user: process.env.DB_USER, // The username to access the database
  password: process.env.DB_PASSWORD, // The password for the specified user
  database: process.env.DB_NAME, // The name of the database to connect to
});

// Establish the connection to the MySQL database
db.connect((err) => {
  // If there is an error during connection, log it and stop execution
  if (err) {
    console.error('Error connecting to the database:', err.message);
    return;
  }

  // If the connection is successful, log a confirmation message
  console.log('Connected to the MySQL database!');
});

// Export the db object for use in other parts of the application
module.exports = db;
