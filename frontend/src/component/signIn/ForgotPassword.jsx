import React from 'react'


function ForgotPassword() {

    const [email, setEmail] = useState("");
    return (  
        <div className="forgot-password-container">
      <form onSubmit={handleSubmit} className="forgot-password-form">
        <h2>Forgot Password</h2>
        <p>Enter your email to reset your password</p>
        <input
          type="email"
          id="email"
          placeholder="Your email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
        />
        <button type="submit">Send Reset Link</button>
        {message && <p>{message}</p>}
      </form>
    </div>
    );
}

export default ForgotPassword;