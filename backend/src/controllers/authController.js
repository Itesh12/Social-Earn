const jwt = require('jsonwebtoken');
require('express-async-errors');
const User = require('../models/userModel');
const Community = require('../models/communityModel');
// const Email = require('../utils/email');
const AppError = require('../../utils/appError');
const crypto = require('crypto');
const passport = require('passport');
const logger = require('../../utils/logger');

const signToken = (id) => {
  return jwt.sign({ id }, process.env.JWT_SECRET ?? 'secret', {
    expiresIn: process.env.JWT_EXPIRES_IN,
  });
};

const createSendToken = (user, statusCode, res) => {
  const token = signToken(user._id);
  const cookieOptions = {
    expires: new Date(
      Date.now() +
        +(process.env.JWT_COOKIE_EXPIRES_IN ?? '90') * 24 * 60 * 60 * 1000
    ),
    httpOnly: true,
    secure: false,
  };
  if (process.env.NODE_ENV === 'production') cookieOptions.secure = true;

  res.cookie('jwt', token, cookieOptions);

  const userObj = user.toObject();
  // Remove password from output
  delete userObj.password;

  res.status(statusCode).json({
    status: 'success',
    token,
    data: {
      user,
    },
  });
};

exports.signup = async (req, res) => {
  try {
    const { username, email, password } = req.body;

    // Ensure username contains only valid characters
    if (username.match(/^\w+$/) === null) {
      throw new AppError(
        'Username can only contain letters, numbers, and underscores',
        400
      );
    }

    // Check for existing username or email
    const existingUser = await User.findOne({ $or: [{ email }, { username }] });
    if (existingUser) {
      throw new AppError('Email or username is already taken', 400);
    }

    // Create new user
    const newUser = await User.create({ username, email, password });

    // Log successful signup (for debugging/logging purposes)
    logger.info('Send Welcome Message Through Email To User');

    // Generate and send JWT token
    createSendToken(newUser, 201, res);
  } catch (error) {
    // Check if the error is an instance of AppError
    if (error instanceof AppError) {
      return res.status(error.statusCode).json({
        status: 'error',
        message: {
          statusCode: error.statusCode,
          status: error.status,
          isOperational: error.isOperational,
          message: error.message, // Include the specific error message
        },
      });
    }
    // Handle unexpected errors
    res.status(500).json({
      status: 'error',
      message: 'An unexpected error occurred.',
    });
    logger.error(error); // Log unexpected errors for further investigation
  }
};

exports.signin = async (req, res) => {
  const { email } = req.body;
  const user = await User.findOne({ email });
  createSendToken(user, 200, res);
};

exports.signout = (req, res) => {
  res.cookie('jwt', 'loggedout', {
    expires: new Date(Date.now() + 10 * 1000),
    httpOnly: true,
  });
  res.status(200).json({ status: 'success' });
};

exports.protect = async (req, res, next) => {
  passport.authenticate('jwt', { session: false }, function (err, user) {
    if (err) throw err;
    if (!user) throw new AppError('Unauthorized', 401);
    req.user = user;
    next();
  })(req, res, next);
};

exports.restrictTo = (...roles) => {
  return (req, res, next) => {
    if (!roles.includes(req.user.role)) {
      throw new AppError(
        'You do not have permission to perform this action',
        403
      );
    }

    next();
  };
};

exports.forgotPassword = async (req, res, next) => {
  // 1) Get user based on POSTed email
  const user = await User.findOne({ email: req.body.email });
  if (!user) {
    throw new AppError('There is no user with email address.', 404);
  }

  // 2) Generate the random reset token
  const resetToken = user.createPasswordResetToken();
  await user.save({ validateBeforeSave: false });

  // 3) Send it to user's email
  try {
    // const resetURL = `${req.protocol}://${req.get(
    //   'host'
    // )}/api/v1/users/resetPassword/${resetToken}`;
    // await new Email(user, resetURL).sendPasswordReset();

    logger.info('Send Password Reset');

    res.status(200).json({
      status: 'success',
      message: 'Token sent to email!',
    });
  } catch (err) {
    user.passwordResetToken = undefined;
    user.passwordResetExpires = undefined;
    await user.save({ validateBeforeSave: false });

    throw new AppError(
      'There was an error sending the email. Try again later!',
      500
    );
  }
};

exports.resetPassword = async (req, res, next) => {
  // Get user based on the token
  const hashedToken = crypto
    .createHash('sha256')
    .update(req.params.token)
    .digest('hex');

  const user = await User.findOne({
    passwordResetToken: hashedToken,
    passwordResetExpires: { $gt: Date.now() },
  });

  //  If there is user, set the new password
  if (!user) {
    throw new AppError('Invalid token.', 404);
  }
  user.password = req.body.password;
  user.passwordResetToken = undefined;
  user.passwordResetExpires = undefined;
  await user.save();

  //  Update changedPasswordAt property for the user
  //  Log the user in, send JWT
  createSendToken(user, 200, res);
};

exports.updatePassword = async (req, res, next) => {
  // 1) Get user from collection
  const user = await User.findById(req.user.id).select('+password');

  // 2) Check if POSTed current password is correct
  if (!(await user.correctPassword(req.body.currentPassword, user.password))) {
    throw new AppError('Your current password is wrong.', 401);
  }

  // 3) If so, update password
  user.password = req.body.password;
  await user.save();
  // User.findByIdAndUpdate will NOT work as intended!

  // 4) Log user in, send JWT
  createSendToken(user, 200, res);
};
