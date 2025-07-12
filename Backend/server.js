require("dotenv").config();
const express = require("express");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const cookieParser = require("cookie-parser");
const cors = require("cors");

// Import routes
const authRouter = require("./routes/authRoutes");
const profileRoutes = require("./routes/profile"); // Updated path
const paymentRoutes = require("./routes/paymentRoutes");

const app = express();

// Middleware
app.use(cors({
  origin: "http://localhost:5173",
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));


// const nodemailer = require("nodemailer");
// const cors = require("cors");
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());

// app.use(cors());

// MongoDB Connection
const connectDB = require("./config/mongoose-connection");
connectDB();






// app.get("/datafetch",function(req,res){
//   try{
//   let data=jwt.decode("$2b$10$jl0TW71.epNWRTjl1IHGVO48Kp2y6QPkEnpg0YlNI5c1Wae7I9JTG","123456");
//   res.send(data);
//   }catch(err){
//     res.send("token is not valid");
//   }
// });



// app.get("/setcookie",function(req,res){

//   res.cookie("user","priyanka" ,{maxAge: 1000*60*60*24, httpOnly:true,
//     secure:true
//   });
//   res.send("cookie set successfully");
// });

// app.get("/readcookie",function(req,res){
//   let cookie=req.cookies.user;
//   res.send(cookie);
// });


app.use("/api/auth", authRouter);
app.use("/api/profile", profileRoutes);
app.use("/api/payment", paymentRoutes);

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Server error' });
});

// Start Server
const PORT = 8080;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
app.get("/", (req,res)=>{
  res.send("server is working well!");
});