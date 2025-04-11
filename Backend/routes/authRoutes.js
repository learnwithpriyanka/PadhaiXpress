const express = require('express');
const router = express.Router();
// SignUp Route
const {signupUser,loginUser,logoutUser,getUserProfile} = require("../controllers/authController");


router.post("/signup",signupUser);
router.post("/signin",loginUser);
router.get("/logout",logoutUser);
router.get("/profile",getUserProfile);






    module.exports = router;