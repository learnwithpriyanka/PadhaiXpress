import React, { useState } from "react";
import axios from "axios";
import "./signup.css";
import { useNavigate } from "react-router-dom";
import { supabase } from '../../supabaseClient';

function SignUp() {
  const [formData, setFormData] = useState({
    email: "",
    password: "",
    confirmPassword: "",
    name: "",
    universityId: ""
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
    if (!formData.name || !formData.email || !formData.password || !formData.universityId) {
      setError("Please fill all required fields.");
      setMessage("");
      return;
    }

    try {
      // 1. Register with Supabase for authentication
      const { data, error } = await supabase.auth.signUp({
        email: formData.email,
        password: formData.password,
      });

      if (error) {
        setError(error.message);
        setMessage("");
      } else {
        // Insert user profile into Supabase 'users' table
        const user = data.user;
        const { error: insertError } = await supabase
          .from('users')
          .insert([{
            id: user.id, // Use the Supabase Auth user id
            email: formData.email,
            name: formData.name,
            university_id: formData.universityId,
            address: formData.address || null,
            role: 'customer'
          }]);
        if (insertError) {
          setError(insertError.message);
          setMessage("");
          return;
        }
        setMessage("Signup successful! Please check your email to verify your account.");
        setError("");
        setTimeout(() => {
          navigate("/signin");
        }, 2000);
      }
    } catch (err) {
      setError("An unexpected error occurred. Please try again.");
      setMessage("");
    }
  };

  const handleGoogleSignIn = async () => {
    try {
      const { data, error } = await supabase.auth.signInWithOAuth({
        provider: 'google',
        options: {
          redirectTo: `${window.location.origin}/signup-success`
        }
      });
      
      if (error) {
        setError('Google sign-in failed: ' + error.message);
        setMessage('');
      }
      // The redirect will handle the rest of the flow
    } catch (err) {
      setError('Google sign-in failed. Please try again.');
      setMessage('');
    }
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
              value={formData.name || ""}
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
              type="text"
              id="universityId"
              placeholder="University ID Number"
              className="form-input"
              value={formData.universityId}
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
          <button type="button" className="google-button" onClick={handleGoogleSignIn} disabled>
            Google Sign-in (Coming Soon)
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