const bcrypt = require('../utils/bcrypt');
const jwt = require('../utils/jwt');
const User = require('../models/userModel');
const { NotFoundError, ForbiddenError } = require('../errors/customErrors');
const createResponse = require('../utils/responseUtil'); // Utility for consistent API responses

// Get All Users: Retrieves all users or a specific user based on the userId query parameter
exports.getAllUsers = (req, res, next) => {
  const userId = req.query.userId; // Access the userId from query parameters (if provided)

  if (userId) {
    // If userId is provided, retrieve the specific user by ID
    User.findById(userId, (err, user) => {
      if (err) {
        return next(err); // Handle database errors
      }
      if (!user) {
        return next(new NotFoundError('User not found')); // Handle case where user is not found
      }

      // Create a user object without the password
      const { password, ...userWithoutPassword } = user;

      // Respond with the retrieved user data without password
      return res.json(
        createResponse(1, 'User retrieved successfully', {
          user: userWithoutPassword,
        })
      );
    });
  } else {
    // If no userId is provided, retrieve all users
    User.getAll((err, users) => {
      if (err) {
        return next(err); // Handle database errors
      }

      // Remove passwords from all users
      const usersWithoutPasswords = users.map(
        ({ password, ...userWithoutPassword }) => userWithoutPassword
      );

      // Respond with a list of all users without passwords
      res.json(
        createResponse(1, 'Users retrieved successfully', {
          users: usersWithoutPasswords,
        })
      );
    });
  }
};

// Update User: Updates the user's information based on the userId query parameter
exports.updateUser = (req, res, next) => {
  const userId = req.query.userId;
  const {
    name,
    email,
    communitiesJoined,
    bio,
    profilePicture,
    website,
    location,
    interests,
    notificationPreferences,
    username,
    profileBanner,
    socialMediaLinks,
    skills,
    achievements,
    accountStatus,
    languagePreferences,
    themePreferences,
  } = req.body;

  // Validate input
  if (!userId) {
    return next(new ForbiddenError('User ID is required.'));
  }

  // Create an object for the fields to be updated
  const updatedData = {};
  if (name !== undefined) updatedData.name = name.trim();
  if (email !== undefined) updatedData.email = email.trim();
  if (bio !== undefined) updatedData.bio = bio;
  if (profilePicture !== undefined) updatedData.profilePicture = profilePicture;
  if (website !== undefined) updatedData.website = website;
  if (location !== undefined) updatedData.location = location;
  if (notificationPreferences !== undefined)
    updatedData.notificationPreferences = notificationPreferences;
  if (communitiesJoined !== undefined)
    updatedData.communitiesJoined = JSON.stringify(communitiesJoined);
  if (username !== undefined) updatedData.username = username;
  if (profileBanner !== undefined) updatedData.profileBanner = profileBanner;
  if (socialMediaLinks !== undefined)
    updatedData.socialMediaLinks = JSON.stringify(socialMediaLinks);
  if (skills !== undefined) updatedData.skills = JSON.stringify(skills);
  if (achievements !== undefined)
    updatedData.achievements = JSON.stringify(achievements);
  if (accountStatus !== undefined) updatedData.accountStatus = accountStatus;
  if (languagePreferences !== undefined)
    updatedData.languagePreferences = JSON.stringify(languagePreferences);
  if (themePreferences !== undefined)
    updatedData.themePreferences = themePreferences;

  // Handle array fields
  if (interests !== undefined)
    updatedData.interests = JSON.stringify(interests);

  console.log('Updating user:', updatedData); // Debugging line to check the data

  // Update the user's data, excluding token
  User.update(userId, updatedData, (err) => {
    if (err) return next(err);

    // Retrieve the updated user
    User.findById(userId, (err, user) => {
      if (err) return next(err);
      if (!user) return next(new NotFoundError('User not found'));

      // Remove the password and token fields from the response
      const { password, token, ...userWithoutPasswordAndToken } = user;

      // Respond with the updated user data
      return res.json(
        createResponse(1, 'User updated successfully', {
          user: userWithoutPasswordAndToken,
        })
      );
    });
  });
};

// Delete User: Deletes a user based on the userId query parameter
exports.deleteUser = (req, res, next) => {
  const userId = req.query.userId;

  if (!userId) {
    return next(new ForbiddenError('User ID is required.'));
  }

  User.delete(userId, (err) => {
    if (err) return next(err);

    // Respond indicating successful deletion
    return res.json(createResponse(1, 'User deleted successfully'));
  });
};
