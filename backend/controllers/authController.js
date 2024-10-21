const bcrypt = require('../utils/bcrypt');
const jwt = require('../utils/jwt');
const User = require('../models/userModel');
const { NotFoundError, ForbiddenError } = require('../errors/customErrors');
const createResponse = require('../utils/responseUtil'); // Utility for formatting the response

// Registration Logic: Registers a new user
exports.register = (req, res, next) => {
  const {
    name,
    email,
    password,
    username,
    profileVisibility,
    bio,
    profileBanner,
    socialMediaLinks,
    communitiesJoined,
    profilePicture,
    website,
    location,
    interests,
    skills,
    achievements,
    accountStatus,
    languagePreferences,
    notificationPreferences,
    themePreferences,
  } = req.body;

  // Validate input fields
  if (!name || !email || !password) {
    return next(new ForbiddenError('All required fields must be provided.'));
  }

  // Check if a user with the provided email already exists
  User.findByEmail(email, (err, result) => {
    if (err) return next(err);

    // If a user already exists, send an error response
    if (result.length > 0) {
      return next(new ForbiddenError('User already exists'));
    }

    // Hash the provided password
    bcrypt.hashPassword(password, (hash) => {
      // Generate a token for the user
      const token = jwt.generateToken({ name, email });

      // Create the user in the database
      User.create(
        {
          name,
          email,
          password: hash,
          token,
          username: username || null, // Default to null if undefined
          profileVisibility: profileVisibility || 'public', // Default to 'public' if undefined
          bio: bio || null, // Default to null if undefined
          profileBanner: profileBanner || null, // Default to null if undefined
          socialMediaLinks: socialMediaLinks || {}, // Default to an empty object if undefined
          communitiesJoined: communitiesJoined || [], // Default to an empty array if undefined
          profilePicture: profilePicture || null, // Default to null if undefined
          website: website || null, // Default to null if undefined
          location: location || null, // Default to null if undefined
          interests: interests || [], // Default to an empty array if undefined
          skills: skills || [], // Default to an empty array if undefined
          achievements: achievements || [], // Default to an empty array if undefined
          accountStatus: accountStatus || 'active', // Default to 'active' if undefined
          languagePreferences: languagePreferences || 'en', // Default to 'en' if undefined
          notificationPreferences: notificationPreferences || 0, // Default to 0 if undefined
          themePreferences: themePreferences || 'light', // Default to 'light' if undefined
        },
        (err, userId) => {
          if (err) return next(err);

          // Respond with all user fields except the password
          res.status(201).json(
            createResponse(1, 'User registered successfully', {
              user: {
                name,
                email,
                token,
                username: username || null,
                profileVisibility: profileVisibility || 'public',
                bio: bio || null,
                profileBanner: profileBanner || null,
                socialMediaLinks: socialMediaLinks || {},
                communitiesJoined: communitiesJoined || [],
                profilePicture: profilePicture || null,
                website: website || null,
                location: location || null,
                interests: interests || [],
                skills: skills || [],
                achievements: achievements || [],
                accountStatus: accountStatus || 'active',
                languagePreferences: languagePreferences || 'en',
                notificationPreferences: notificationPreferences || 0,
                themePreferences: themePreferences || 'light',
              },
            })
          );
        }
      );
    });
  });
};

// Login Logic: Authenticates a user and returns a JWT token
exports.login = (req, res, next) => {
  const { email, password } = req.body;

  // Validate input fields
  if (!email) {
    return next(new ForbiddenError('Email is required')); // Email is required
  }
  if (!password) {
    return next(new ForbiddenError('Password is required')); // Password is required
  }

  // Find the user in the database by their email
  User.findByEmail(email, (err, users) => {
    if (err) {
      return next(err); // Handle database errors
    }
    if (users.length === 0) {
      return next(new NotFoundError('User not found')); // No user found with this email
    }

    const user = users[0]; // Get the first user (assuming unique emails)

    // Compare the provided password with the stored hashed password
    bcrypt.comparePassword(password, user.password, (isMatch) => {
      if (err) {
        return next(err); // Handle bcrypt errors
      }
      if (!isMatch) {
        return next(new ForbiddenError('Incorrect password')); // Password mismatch
      }

      // Respond with a success message and return the user's details
      res.json(
        createResponse(1, 'Login successful', {
          user: {
            name: user.name,
            email: user.email,
            password: user.password,
            username: user.username,
            profileVisibility: user.profileVisibility,
            bio: user.bio,
            profileBanner: user.profileBanner,
            socialMediaLinks: user.socialMediaLinks,
            communitiesJoined: user.communitiesJoined,
            profilePicture: user.profilePicture,
            website: user.website,
            location: user.location,
            interests: user.interests,
            skills: user.skills,
            achievements: user.achievements,
            accountStatus: user.accountStatus,
            languagePreferences: user.languagePreferences,
            notificationPreferences: user.notificationPreferences,
            themePreferences: user.themePreferences,
            token: user.token,
          },
        })
      );
    });
  });
};
