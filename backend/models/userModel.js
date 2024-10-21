const db = require('../config/db');

// User Model: Provides methods to interact with the users table in the database
const User = {
  // Create a new user in the database
  create: (data, callback) => {
    const sql = `INSERT INTO users (name, email, password, token, username, profileVisibility, bio, profileBanner, socialMediaLinks, communitiesJoined, profilePicture, website, location, interests, skills, achievements, accountStatus, languagePreferences, notificationPreferences, themePreferences) 
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;

    db.query(
      sql,
      [
        data.name,
        data.email,
        data.password,
        data.token,
        data.username || null,
        data.profileVisibility || 'public',
        data.bio || null,
        data.profileBanner || null,
        JSON.stringify(data.socialMediaLinks || {}),
        JSON.stringify(data.communitiesJoined || []),
        data.profilePicture || null,
        data.website || null,
        data.location || null,
        JSON.stringify(data.interests || []),
        JSON.stringify(data.skills || []),
        JSON.stringify(data.achievements || []),
        data.accountStatus || 'active',
        data.languagePreferences || 'en',
        JSON.stringify(data.notificationPreferences || {}),
        data.themePreferences || 'light',
      ],
      callback
    );
  },

  // Find a user by their email address
  findByEmail: (email, callback) => {
    const sql = `SELECT * FROM users WHERE email = ?`;
    db.query(sql, [email], (err, results) => {
      if (err) return callback(err);
      callback(null, results);
    });
  },

  // Find a user by their unique ID
  findById: (id, callback) => {
    const sql = `SELECT * FROM users WHERE id = ?`;
    db.query(sql, [id], callback);
  },

  // Retrieve all users from the database
  getAll: (callback) => {
    const sql = `SELECT * FROM users`;
    db.query(sql, callback);
  },

  // Update a user's information in the database
  // Update a user's information in the database
  update: (id, data, callback) => {
    const sql = `UPDATE users SET 
      name = ?, 
      email = ?, 
      username = ?, 
      profileVisibility = ?, 
      lastActive = ?, 
      bio = ?, 
      profileBanner = ?, 
      socialMediaLinks = ?, 
      communitiesJoined = ?, 
      profilePicture = ?, 
      website = ?, 
      location = ?, 
      interests = ?, 
      skills = ?, 
      achievements = ?, 
      accountStatus = ?, 
      languagePreferences = ?, 
      notificationPreferences = ?, 
      themePreferences = ? 
      WHERE id = ?`;

    db.query(
      sql,
      [
        data.name || null,
        data.email || null,
        data.username || null,
        data.profileVisibility || 'public',
        new Date(), // Update lastActive to current date
        data.bio || null,
        data.profileBanner || null,
        JSON.stringify(data.socialMediaLinks || {}),
        JSON.stringify(data.communitiesJoined || []),
        data.profilePicture || null,
        data.website || null,
        data.location || null,
        JSON.stringify(data.interests || []),
        JSON.stringify(data.skills || []),
        JSON.stringify(data.achievements || []),
        data.accountStatus || 'active',
        JSON.stringify(data.languagePreferences || ['en']),
        JSON.stringify(data.notificationPreferences || {}),
        data.themePreferences || 'light',
        id,
      ],
      callback
    );
  },

  // Delete a user from the database by their ID
  delete: (id, callback) => {
    const sql = `DELETE FROM users WHERE id = ?`;
    db.query(sql, [id], callback);
  },
};

// Export the User model for use in other parts of the application
module.exports = User;
