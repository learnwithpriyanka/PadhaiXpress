const mongoose = require('mongoose');

const addressSchema = new mongoose.Schema({
    street: String,
    city: String,
    state: String,
    pincode: String
});

const profileSchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    },
    name: String,
    email: String,
    phone: String,
    addresses: [addressSchema]
});

module.exports = mongoose.model('Profile', profileSchema);