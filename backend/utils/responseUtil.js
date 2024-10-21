// responseUtil.js

// Utility function to format the response
const createResponse = (status, message, data = {}) => {
  return {
    s: status, // Status: 1 for success, 0 for failure
    m: message, // Message
    r: data, // Response data
  };
};

module.exports = createResponse;
