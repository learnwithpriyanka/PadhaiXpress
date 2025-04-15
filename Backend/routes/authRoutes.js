const express = require('express');
const router = express.Router();
// SignUp Route
const {signupUser,loginUser,logoutUser,getUserProfile,getUserAddress, getOrderHistory, placeOrder, UserProfile, AddAddress, UpdateAddress, DeleteAddress} = require("../controllers/authController");
const authenticate = require('../middlewares/authenticate');

router.post("/signup",signupUser);
router.post("/signin",loginUser);
router.get("/logout",logoutUser);
router.get("/profile",getUserProfile);
router.get('/user/address', authenticate, getUserAddress);
router.get('/orders', authenticate, getOrderHistory);
router.post('/orders', authenticate, placeOrder);
router.get("/",authenticate,UserProfile);
router.post("/address",authenticate,AddAddress);
router.put("/address/:id",authenticate,UpdateAddress);
router.delete("/address/:id",authenticate,DeleteAddress);


module.exports = router;