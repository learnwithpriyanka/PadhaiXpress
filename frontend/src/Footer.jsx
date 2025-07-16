import React from 'react';
import './index.css'
import { Link } from 'react-router-dom';

function Footer() {
    return (
        <footer className="modern-footer">
            <div className="footer-container">
                {/* Brand Section */}
                <div className="footer-brand">
                    <Link className="footer-logo" to="/">
                        <div className="logo-container">
                            <div className="logo-icon">
                                <span>PX</span>
                            </div>
                            <div className="logo-text">
                                <h3>PadhaiXpress</h3>
                            </div>
                        </div>
                    </Link>
                    <p className="footer-slogan">Your One-Stop Hub for Study Materials!</p>
                    <div className="footer-description">
                        Empowering students with quality educational resources, sustainable practices, and innovative learning solutions.
                    </div>
                </div>

                {/* Quick Links Section */}
                <div className="footer-section">
                    <h4 className="footer-title">Quick Links</h4>
                    <div className="footer-links">
                        <Link to="/about" className="footer-link">About Us</Link>
                        <Link to="/contact" className="footer-link">Contact</Link>
                        <Link to="/workbook" className="footer-link">Workbooks</Link>
                        <Link to="/project" className="footer-link">Print Projects</Link>
                        <Link to="/recycle" className="footer-link">Recycle</Link>
                        <Link to="/notes" className="footer-link">Notes</Link>
                    </div>
                </div>

                {/* Account Section */}
                <div className="footer-section">
                    <h4 className="footer-title">Account</h4>
                    <div className="footer-links">
                        <Link to="/signup" className="footer-link">Sign Up</Link>
                        <Link to="/signin" className="footer-link">Sign In</Link>
                        <Link to="/profile" className="footer-link">Profile</Link>
                        <Link to="/orders" className="footer-link">Order History</Link>
                    </div>
                </div>

                {/* Social Media Section */}
                <div className="footer-section">
                    <h4 className="footer-title">Connect With Us</h4>
                    <div className="social-links">
                        <a href="#" className="social-link facebook">
                            <i className="fa-brands fa-facebook"></i>
                            <span>Facebook</span>
                        </a>
                        <a href="#" className="social-link instagram">
                            <i className="fa-brands fa-instagram"></i>
                            <span>Instagram</span>
                        </a>
                        <a href="#" className="social-link twitter">
                            <i className="fa-brands fa-square-twitter"></i>
                            <span>Twitter</span>
                        </a>
                        <a href="#" className="social-link whatsapp">
                            <i className="fa-brands fa-whatsapp"></i>
                            <span>WhatsApp</span>
                        </a>
                    </div>
                </div>
            </div>

            {/* Footer Bottom */}
            <div className="footer-bottom">
                <div className="footer-bottom-content">
                    <p>&copy; 2024 PadhaiXpress. All rights reserved.</p>
                    <div className="footer-bottom-links">
                        <Link to="/privacy" className="footer-bottom-link">Privacy Policy</Link>
                        <Link to="/terms" className="footer-bottom-link">Terms and Conditions</Link>
                        <Link to="/shipping" className="footer-bottom-link">Shipping & Delivery Policy</Link>
                    </div>
                </div>
            </div>
        </footer>
    );
}

export default Footer;