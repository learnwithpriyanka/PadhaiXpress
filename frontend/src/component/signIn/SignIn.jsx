import React, { useState ,useContext} from "react";
import axios from "axios";
import "./SignIn.css";
import { useNavigate,useLocation } from "react-router-dom";
import { AuthContext } from "../../context/AuthContext";
import { supabase } from '../../supabaseClient';

function SignIn() {
  const [formData, setFormData] = useState({
    email: "",
    password: "",
  });
  const [message, setMessage] = useState("");
  const navigate = useNavigate();
  const { login } = useContext(AuthContext);
  const location = useLocation();

  const handleChange = (e) => {
    const { id, value } = e.target;
    setFormData((prevData) => ({ ...prevData, [id]: value }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const { data, error } = await supabase.auth.signInWithPassword({
        email: formData.email,
        password: formData.password,
      });
      if (error) {
        setMessage(error.message);
      } else {
        // Store the JWT access token for API calls
        localStorage.setItem("token", data.session.access_token);
        login(data.session.access_token);
        setMessage("Login successful!");

        // 2. Get user ID
        const userId = data.user.id;

        // 3. Fetch user role from users table
        const { data: userData, error: userError } = await supabase
          .from('users')
          .select('role')
          .eq('id', userId)
          .single();

        if (userError) {
          // handle error
          return;
        }

        // 4. Redirect logic: prioritize previous page
        navigate(location.state?.from || "/", { replace: true });
      }
    } catch (err) {
      setMessage("An error occurred. Please try again.");
    }
  };

  return (
    <div className="signin-container">
      <div className="signin-left">
        <img
          src="/media/image/image.webp"
          alt="Sign In"
          className="signin-image"
        />
      </div>
      <div className="signin-right">
        <h2>Welcome Back!</h2>
        <h3>Sign In to Your Account</h3>
        <form className="signin-form" onSubmit={handleSubmit}>
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
          {message && <p className="message">{message}</p>}
          <button type="submit" className="form-button">Sign In</button>
          <div className="signup-link">
            <p>
              Don't have an account?{" "}
              <a href="/signup" className="link">
                Sign Up
              </a>
            </p>
          </div>
        </form>
      </div>
    </div>
  );
}

export default SignIn;