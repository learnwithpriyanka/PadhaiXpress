const userData = require('../models/usermodel');
const bcrypt = require('bcrypt');
const generateToken = require('../utils/generateToken');


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
            return res.status(400).json({ error: "User not found" });
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