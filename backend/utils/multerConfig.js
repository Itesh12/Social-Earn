const multer = require('multer');

// Configure multer storage
const storage = multer.memoryStorage(); // Store files in memory (you can also specify a disk storage)

const upload = multer({ storage });

// Export the upload middleware
module.exports = upload;
