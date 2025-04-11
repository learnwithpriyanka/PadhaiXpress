const mongoose = require('mongoose');
require("dotenv").config();
// User Schema
const userDataSchema = new mongoose.Schema({
  name: {type:String,required:true},
  email: { type: String, required:true,unique: true },
  password: {type:String, required:true},
  confirmPassword: {type:String, required:true},
//   isVerified: { type: Boolean, default: false },
//   verificationCode: String,
});



const UserData = mongoose.model("UserData", userDataSchema);
 
module.exports = UserData;

