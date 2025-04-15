import React, { useState ,useContext} from "react";
import axios from "axios";
import "./SignIn.css";
import { useNavigate,useLocation } from "react-router-dom";
import { AuthContext } from "../../context/AuthContext";

function SignIn() {
  const [formData, setFormData] = useState({
    email: "",
    password: "",
  });
  const [message, setMessage] = useState("");
  const navigate = useNavigate();
  const { login } = useContext(AuthContext); // Access the login function from AuthContext
  const location = useLocation(); // Get the current location

  const handleChange = (e) => {
    const { id, value } = e.target;
    setFormData((prevData) => ({ ...prevData, [id]: value }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
    const response = await axios.post("http://localhost:8080/api/auth/signin", formData, {
      withCredentials: true,
        headers: {
          'Content-Type': 'application/json'
        }
    });
      localStorage.setItem("token", response.data.token);
      login(response.data.token); // Call the login function from AuthContext
      setMessage(response.data.message);
      const from = location.state?.from || "/";
      setTimeout(() => {
        navigate(from);
      }, 1500);
    } catch (err) {
      console.error('Signin error:', err);
      if (err.code === 'ERR_CONNECTION_REFUSED') {
        setMessage('Cannot connect to server. Please make sure the server is running.');
      } else {
        setMessage(err.response?.data?.error || 'An error occurred. Please try again.');
      }  
      }
  };

  return (
    <div className="signin-container">
      <div className="signin-left">
        <img
          src="/media/image/signin-image.jpg"
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