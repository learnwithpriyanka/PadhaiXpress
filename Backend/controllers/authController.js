const userData = require('../models/usermodel');
const bcrypt = require('bcrypt');
const generateToken = require('../utils/generateToken');
const UserData = require('../models/usermodel');
const OrderData = require('../models/orderModel');

module.exports.signupUser = async (req, res) => {
    console.log("Request Body:", req.body);
    const { name, email, password, confirmPassword } = req.body;

    try {
        // Validate required fields
        if (!name || !email || !password || !confirmPassword) {
            return res.status(400).json({ error: "All fields are required." });
        }

        if (password !== confirmPassword) {
            return res.status(400).json({ error: "Passwords do not match." });
        }

        // Check if the user already exists
        const existingUser = await userData.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ error: "Email is already registered." });
        }

        const hashedPassword = await bcrypt.hash(password, 10);

        const user = new userData({
            name,
            email,
            password: hashedPassword,
            confirmPassword: hashedPassword

        });
        await user.save();

        let token = generateToken({ email });
        res.cookie("token", token, {
            httpOnly: true,
            secure: true,
            maxAge: 1000 * 60 * 60 * 24 * 30,

        });

        // Send a success response
        res.status(201).json({ message: "User registered successfully." });
    } catch (err) {
        console.error("Error during user signup:", err.message);
        res.status(500).json({ error: "Internal server error. Please try again later." });

    }
};

module.exports.loginUser = async (req, res) => {
    const { email, password } = req.body;

    try {
        let user = await userData.findOne({ email });
        if (!user) {
            return res.status(400).json({ error: "User not found " });
        }
        bcrypt.compare(password, user.password).then((result) => {
            if (result) {
                let token = generateToken({ email });
                res.cookie("token", token, {
                    httpOnly: true,
                    secure: true,
                    maxAge: 1000 * 60 * 60 * 24 * 30,
                });
                res.status(200).json({ message: "Login successful" });
            } else {
                res.status(400).json({ error: "Invalid credentials" });
            }
        });
    } catch (err) {
        res.status(500).json({ error: "Internal server error" });
    }
};

module.exports.logoutUser = async (req, res) => { };
module.exports.getUserProfile = async (req, res) => { };

module.exports.getUserAddress = async (req, res) => {
  try {
    const userId = req.user.id; // Assuming user ID is available in req.user
    const user = await UserData.findById(userId);

    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.json({ address: user.address }); // Assuming `address` is a field in the user schema
  } catch (error) {
    console.error('Error fetching user address:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

module.exports.getOrderHistory = async (req, res) => {
  try {
    const userId = req.user.id; // Assuming user ID is available in req.user
    const orders = await OrderData.find({ userId });

    if (!orders || orders.length === 0) {
      return res.status(404).json({ error: 'No orders found' });
    }

    res.json({ orders });
  } catch (error) {
    console.error('Error fetching order history:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

module.exports.placeOrder = async (req, res) => {
  try {
    const userId = req.user.id; // Assuming user ID is available in req.user
    const { address, products, total } = req.body;

    const newOrder = new OrderData({
      userId,
      address,
      products,
      total,
      date: new Date(),
    });

    await newOrder.save();

    res.status(201).json({ message: 'Order placed successfully' });
  } catch (error) {
    console.error('Error placing order:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};




module.exports.UserProfile= async (req, res) => {
  try {
      let profile = await Profile.findOne({ user: req.user.id });
      if (!profile) {
          profile = new Profile({
              user: req.user.id,
              name: req.user.name,
              email: req.user.email,
              addresses: []
          });
          await profile.save();
      }
      res.json(profile);
  } catch (error) {
      res.status(500).json({ error: 'Server error' });
  }
};



module.exports.AddAddress=async (req, res) => {
  try {
      const profile = await Profile.findOne({ user: req.user.id });
      profile.addresses.push(req.body);
      await profile.save();
      res.json(profile.addresses[profile.addresses.length - 1]);
  } catch (error) {
      res.status(500).json({ error: 'Server error' });
  }
};

module.exports.UpdateAddress=async (req, res) => {
  try {
      const profile = await Profile.findOne({ user: req.user.id });
      const address = profile.addresses.id(req.params.id);
      if (!address) return res.status(404).json({ error: 'Address not found' });
      
      Object.assign(address, req.body);
      await profile.save();
      res.json(address);
  } catch (error) {
      res.status(500).json({ error: 'Server error' });
  }
};

module.exports.DeleteAddress=async (req, res) => {
  try {
      const profile = await Profile.findOne({ user: req.user.id });
      profile.addresses.pull(req.params.id);
      await profile.save();
      res.json({ message: 'Address deleted' });
  } catch (error) {
      res.status(500).json({ error: 'Server error' });
  }
};