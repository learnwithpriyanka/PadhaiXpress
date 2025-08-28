
import React, { useState } from "react";
import "./contact.css";
import { MessageCircle, Phone, Instagram, Send, MapPin, Mail } from "lucide-react";

const ContactMe = () => {
  const [form, setForm] = useState({ name: "", email: "", subject: "", message: "" });
  const [success, setSuccess] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleChange = (e) => {
    setForm({ ...form, [e.target.id]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsSubmitting(true);
    
    // Simple validation
    if (!form.name || !form.email || !form.subject || !form.message) {
      setSuccess("Please fill all fields.");
      setIsSubmitting(false);
      return;
    }
    
    // Simulate API call
    setTimeout(() => {
      setSuccess("Thank you for contacting us! We'll get back to you soon.");
      setForm({ name: "", email: "", subject: "", message: "" });
      setIsSubmitting(false);
      setTimeout(() => setSuccess(""), 5000);
    }, 1000);
  };

  return (
    <div className="contactme-root contact-page">
      {/* Hero Section */}
      <section className="hero-section">
        <div className="hero-content">
          <h1 className="hero-title">Get in Touch</h1>
          <p className="hero-subtitle">
            Have questions? We'd love to hear from you. Send us a message and we'll respond as soon as possible.
          </p>
        </div>
        <div className="hero-overlay"></div>
      </section>

      <div className="container">
        {/* Contact Cards Grid */}
        <section className="contact-cards-section">
          <div className="contact-cards-grid">
            {/* Feedback Card */}
            <div 
              className="contact-card"
              onClick={() =>
                window.open(
                  "https://docs.google.com/forms/d/e/1FAIpQLScKnuChJGLO1KfBc641A6G0R6fa7u0ISEviIo5u6Ufjqi4pkg/viewform?usp=headero",
                  "_blank"
                )
              }
              role="button"
              tabIndex={0}
              aria-label="Feedback"
            >
              <div className="card-icon">
                <MessageCircle />
              </div>
              <h3>Feedback</h3>
              <p>Share your thoughts with us</p>
            </div>

            {/* Contact Card */}
            <div className="contact-card">
              <a
                href="tel:+917667761697"
                className="card-link"
                aria-label="Call us"
              >
                <div className="card-icon">
                  <Phone />
                </div>
                <h3>Call Us</h3>
                <p>+91 7667761697</p>
              </a>
            </div>

            {/* Email Card */}
            <div className="contact-card">
              <a
                href="mailto:support@padhaixpress.in"
                className="card-link"
                aria-label="Email us"
              >
                <div className="card-icon">
                  <Mail />
                </div>
                <h3>Email Us</h3>
                <p>support@padhaixpress.in</p>
              </a>
            </div>

            {/* Telegram Card */}
            <div className="contact-card">
              <a
                href="https://t.me/padhaiexpress1122"
                target="_blank"
                rel="noopener noreferrer"
                className="card-link"
                aria-label="Telegram"
              >
                <div className="card-icon telegram">
                  <Send />
                </div>
                <h3>Telegram</h3>
                <p>Join our channel</p>
              </a>
            </div>

            {/* Instagram Card */}
            <div
              className="contact-card"
              onClick={() =>
                window.open(
                  "https://www.instagram.com/padhai_xpress?igsh=MWtpNDU2cDE1cTBnNw==",
                  "_blank"
                )
              }
              role="button"
              tabIndex={0}
              aria-label="Instagram"
            >
              <div className="card-icon instagram">
                <Instagram />
              </div>
              <h3>Instagram</h3>
              <p>Follow us on Instagram</p>
            </div>
          </div>
        </section>

        {/* Main Content Section */}
        <section className="main-content">
          <div className="content-grid">
            {/* Contact Form */}
            <div className="form-section">
              <div className="form-header">
                <h2>Send us a Message</h2>
                <p>Fill out the form below and we'll get back to you .</p>
              </div>
              
              <form onSubmit={handleSubmit} className="contact-form">
                <div className="form-group">
                  <label htmlFor="name">Full Name</label>
                  <input
                    type="text"
                    id="name"
                    value={form.name}
                    onChange={handleChange}
                    placeholder="Enter your full name"
                    required
                  />
                </div>

                <div className="form-group">
                  <label htmlFor="email">Email Address</label>
                  <input
                    type="email"
                    id="email"
                    value={form.email}
                    onChange={handleChange}
                    placeholder="Enter your email address"
                    required
                  />
                </div>

                <div className="form-group">
                  <label htmlFor="subject">Subject</label>
                  <input
                    type="text"
                    id="subject"
                    value={form.subject}
                    onChange={handleChange}
                    placeholder="What's this about?"
                    required
                  />
                </div>

                <div className="form-group">
                  <label htmlFor="message">Message</label>
                  <textarea
                    id="message"
                    value={form.message}
                    onChange={handleChange}
                    placeholder="Tell us more about your inquiry..."
                    rows={6}
                    required
                  />
                </div>

                <button 
                  type="submit" 
                  className={`submit-btn ${isSubmitting ? 'loading' : ''}`}
                  disabled={isSubmitting}
                >
                  {isSubmitting ? 'Sending...' : 'Send Message'}
                </button>

                {success && (
                  <div className={`success-message ${success.includes('Please') ? 'error' : ''}`}>
                    {success}
                  </div>
                )}
              </form>
            </div>

            {/* Address and Map Section */}
            <div className="address-section">
              <div className="address-card">
                <div className="address-header">
                  <div className="address-icon">
                    <MapPin />
                  </div>
                  <h2>Our Office</h2>
                </div>
                
                <div className="address-content">
                  <h3>PadhaiXpress Office</h3>
                  <p>
                    Kolanukonda, near Ambedkar Statue,<br/>
                   Guntur,<br/>
                    Mangalagiri - 522503,<br/>
                    Andhra Pradesh, India
                  </p>
                  
                  <div className="address-actions">
                                        <a
                      href="https://maps.google.com/maps?q=Kalinga%20University%20Naya%20Raipur&t=&z=13&ie=UTF8&iwloc=&output=embed"
                      target="_blank"
                      rel="noopener noreferrer"
                      className="map-btn"
                    >
                      <MapPin />
                      View on Map
                    </a>
                  </div>
                </div>
              </div>

              {/* Office Hours */}
              <div className="office-hours">
                <h3>Office Hours</h3>
                <div className="hours-grid">
                  <div className="hour-item">
                    <span className="day">Monday - Friday</span>
                    <span className="time">9:00 AM - 6:00 PM</span>
                  </div>
                  <div className="hour-item">
                    <span className="day">Saturday</span>
                    <span className="time">10:00 AM - 4:00 PM</span>
                  </div>
                  <div className="hour-item">
                    <span className="day">Sunday</span>
                    <span className="time">Closed</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
      </div>
    </div>
  );
};

export default ContactMe;
