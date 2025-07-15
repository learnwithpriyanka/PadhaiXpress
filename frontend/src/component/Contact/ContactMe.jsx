import React, { useState } from "react";
import "./contact.css";
import MapComponent from "./MapComponent";
import { FaCommentDots, FaPhoneAlt, FaInstagram, FaPaperPlane, FaTelegramPlane } from "react-icons/fa";

const ContactPage = () => {
  const [form, setForm] = useState({ name: "", email: "", subject: "", message: "" });
  const [success, setSuccess] = useState("");

  const handleChange = (e) => {
    setForm({ ...form, [e.target.id]: e.target.value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // Simple validation
    if (!form.name || !form.email || !form.subject || !form.message) {
      setSuccess("Please fill all fields.");
      return;
    }
    setSuccess("Thank you for contacting us!");
    setForm({ name: "", email: "", subject: "", message: "" });
    setTimeout(() => setSuccess(""), 3000);
  };

  return (
    <>
      <div className="c" style={{ minHeight: "100vh", padding: "0 8px" }}>
        <div
          className="contac"
          style={{
            maxWidth: "1200px",
            margin: "0 ",
            padding: " 0",
          }}
        >
          <div className="image" style={{ textAlign: "center", marginBottom: "32px" }}>
            <h1
              style={{
                fontSize: "clamp(2rem, 6vw, 60px)",
                fontWeight: "bold",
                color: "#2D5F9A",
                marginBottom: "12px",
                lineHeight: 1.1,
              }}
            >
              Get in touch
            </h1>
            <p style={{ fontSize: "clamp(1.1rem, 3vw, 30px)", color: "#444" }}>
              Have questions? We'd love to hear from you.
            </p>
          </div>

          {/* Cards Section */}
          <div
            className="row p-5 contact-card-grid"
            style={{
              display: "grid",
              gridTemplateColumns: "repeat(auto-fit, minmax(240px, 1fr))",
              gap: "32px",
              justifyItems: "center",
              alignItems: "stretch",
              width: "100%",
              margin: "0 auto",
              padding: 0,
              maxWidth: "1200px",
            }}
          >
            {/* Feedback Card */}
            <div
              className="card1 col-3 p-5"
              onClick={() =>
                window.open(
                  "https://docs.google.com/forms/d/e/1FAIpQLScKnuChJGLO1KfBc641A6G0R6fa7u0ISEviIo5u6Ufjqi4pkg/viewform?usp=headero",
                  "_blank"
                )
              }
              style={{ cursor: "pointer" }}
              tabIndex={0}
              aria-label="Feedback"
            >
              <FaCommentDots size={60} color="#2D5F9A" style={{ marginLeft: "30px" }} />
              <h4>Feedback</h4>
            </div>

            {/* Contact Card */}
            <div className="card1 col-3 p-5">
              <a
                href="tel:+917667761697"
                style={{ color: "#2D5F9A", textDecoration: "none" }}
                aria-label="Call us"
              >
                <FaPhoneAlt size={60} color="#2D5F9A" style={{ marginLeft: "30px" }} />
                <h4>Contact us</h4>
                <p style={{ color: "black" }}>+91 7667761697</p>
              </a>
            </div>

            {/* Telegram Card */}
            <div className="card1 col-3 p-5">
              <a
                href="https://t.me/padhaiexpress1122" // <-- Replace with your actual Telegram link
                target="_blank"
                rel="noopener noreferrer"
                style={{ color: "#2D5F9A", textDecoration: "none" }}
                aria-label="Telegram"
              >
                <FaTelegramPlane size={60} style={{ marginLeft: "30px" }} />
                <h4>Telegram</h4>
                <p style={{ color: "black" }}>Join our channel</p>
              </a>
            </div>

            {/* Instagram Card */}
            <div
              className="card1 col-3 p-5"
              onClick={() =>
                window.open(
                  "https://www.instagram.com/padhai_xpress?igsh=MWtpNDU2cDE1cTBnNw==",
                  "_blank"
                )
              }
              style={{ cursor: "pointer" }}
              tabIndex={0}
              aria-label="Instagram"
            >
              <FaInstagram size={60} color="#E4405F" style={{ marginLeft: "30px" }} />
              <h4>Instagram</h4>
              <p style={{ color: "black" }}>See our Instagram</p>
            </div>
          </div>

          <div
            className="address-map-row"
            style={{
              display: "flex",
              width: "100%",
              marginTop: "40px",
              alignItems: "stretch",
              justifyContent: "center",
              flexWrap: "wrap",
            }}
          >
            {/* Address Card */}
            <div
              className="card1 address-card"
              style={{
                flex: "1 1 320px",
                minWidth: "260px",
                maxWidth: "600px",
                width: "100%",
                display: "flex",
                flexDirection: "column",
                justifyContent: "center",
                alignItems: "center",
                background: "rgba(255,255,255,0.95)",
                boxShadow: "0 8px 32px rgba(44,95,154,0.10)",
                border: "2px solid #2D5F9A",
                borderRadius: "32px",
                padding: "32px 12px",
                margin: "10px auto",
              }}
              tabIndex={0}
              aria-label="Office Address"
            >
              <h2
                style={{
                  marginBottom: "18px",
                  color: "#2D5F9A",
                  width: "100%",
                  textAlign: "center",
                  fontSize: "clamp(1.3rem, 4vw, 2rem)",
                  fontWeight: "700",
                  letterSpacing: "1px",
                  marginTop: "20px",
                }}
              >
                Our Address
              </h2>
              <div
                style={{
                  color: "#222",
                  fontSize: "clamp(1rem, 2.5vw, 1.15rem)",
                  lineHeight: "2",
                  textAlign: "center",
                  width: "100%",
                  wordBreak: "break-word",
                  marginBottom: "24px",
                }}
              >
                <strong style={{ fontSize: "1.1em", color: "#2D5F9A" }}>PadhaiXpress Office</strong>
                <br />
                Kolanukonda, near Ambedkar Statue, EVS Clueave,  
Guntur,  
Mangalagiri - 522503,  
Andhra Pradesh,
                
                India
              </div>
              <a
               href="https://maps.google.com/?q=Kolanukonda, near Ambedkar Statue, EVS Clueave, Guntur, Mangalagiri - 522503, Andhra Pradesh" target="_blank"
                
                rel="noopener noreferrer"
                style={{
                  marginTop: "0",
                  marginBottom: "18px",
                  color: "#fff",
                  background: "#2D5F9A",
                  padding: "10px 24px",
                  borderRadius: "24px",
                  textDecoration: "none",
                  fontWeight: "bold",
                  fontSize: "clamp(1rem, 2vw, 1.15rem)",
                  boxShadow: "0 2px 8px rgba(44,95,154,0.10)",
                  width: "fit-content",
                  alignSelf: "center",
                  transition: "background 0.2s, transform 0.2s",
                  display: "inline-block",
                }}
              >
                View on Map
              </a>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default ContactPage;