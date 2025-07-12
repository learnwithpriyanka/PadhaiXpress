const mongoose = require('mongoose');
require("dotenv").config();
// User Schema
const userDataSchema = new mongoose.Schema({
  name: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  role: { type: String, enum: ['customer', 'admin'], default: 'customer' },
  universityId: { type: String, required: true },
  address: { type: String, default: null },
  // isVerified: { type: Boolean, default: false },
  // verificationCode: String,
});



const UserData = mongoose.model("UserData", userDataSchema);
 
module.exports = UserData;

