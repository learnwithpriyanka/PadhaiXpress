const express = require('express');
const router = express.Router();
const authenticate = require('../middlewares/authenticate');
const { UserProfile, AddAddress, UpdateAddress, DeleteAddress } = require('../controllers/authController');

// Profile routes
router.get("/", authenticate, UserProfile);
router.post("/address", authenticate, AddAddress);
router.put("/address/:id", authenticate, UpdateAddress);
router.delete("/address/:id", authenticate, DeleteAddress);

module.exports = router;