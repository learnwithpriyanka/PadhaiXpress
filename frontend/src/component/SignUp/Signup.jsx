import React, { useState } from "react";
import axios from "axios";
import "./signup.css";
import { useNavigate } from "react-router-dom";

function SignUp() {
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    password: "",
    confirmPassword: "",
  });
  const [message, setMessage] = useState("");
  const [error, setError] = useState("");
  const navigate = useNavigate();

  const handleChange = (e) => {
    const { id, value } = e.target;
    setFormData((prevData) => ({ ...prevData, [id]: value }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (formData.password !== formData.confirmPassword) {
      setError("Passwords do not match.");
      setMessage("");
      return;
    }
    console.log("Form Data:", formData);

    try {
      const response = await axios.post("http://localhost:8080/api/auth/signup", formData);
      setMessage(response.data.message);
      setError("");
      setTimeout(()=>{
        navigate("/signin");
      },2000);
    } catch (err) {
      if(err.response){
        setError(err.response.data.error || "An error occurred. Please try again.");

      } else if(err.request){
        setError("No response from the server. Please try again later.");
      } else {
        setError("An unexpected error occurred. Please try again.");
      }
      console.log(err.response);
      setMessage("");
    }
  };

  const handleGoogleSignIn = () => {
    window.location.href = "http://localhost:8080/api/auth/google";
  };

  return (
    <div className="signup-container">
      <div className="signup-left">
        <img
          src="/media/image/image.webp"
          alt="Sign Up"
          className="signup-image"
        />
      </div>
      <div className="signup-right">
        <h2>Welcome!</h2>
        <h3>Create Your Account</h3>
        <p>Join us and start your journey today.</p>
        <form className="signup-form" onSubmit={handleSubmit}>
          <div className="form-group">
            <input
              type="text"
              id="name"
              placeholder="Name"
              className="form-input"
              value={formData.name}
              onChange={handleChange}
              required
            />
          </div>
          <div className="form-group">
            <input
              type="email"
              id="email"
              placeholder="Email"
              className="form-input"
              value={formData.email}
              onChange={handleChange}
              required
            />
          </div>
          <div className="form-group">
            <input
              type="password"
              id="password"
              placeholder="Password"
              className="form-input"
              value={formData.password}
              onChange={handleChange}
              required
            />
          </div>
          <div className="form-group">
            <input
              type="password"
              id="confirmPassword"
              placeholder="Confirm Password"
              className="form-input"
              value={formData.confirmPassword}
              onChange={handleChange}
              required
            />
          </div>
          {error && <p className="error-message">{error}</p>}
          {message && <p className="success-message">{message}</p>}
          <button type="submit" className="form-button">Sign Up</button>
          <button type="button" className="google-button" onClick={handleGoogleSignIn}>
            Sign in with Google
          </button>
          <div className="login-link">
            <p>
              Already have an account?{" "}
              <a href="/signin" className="link">
                Sign In
              </a>
            </p>
          </div>
        </form>
      </div>
    </div>
  );
}

export default SignUp;