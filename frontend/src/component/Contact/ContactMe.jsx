import React from "react";
import "./contact.css";
import MapComponent from "./MapComponent";

const ContactPage = () => {
  return (
    <>
      <div className="c">
        <div className="contac">
          <div className="image">
            <h1 style={{ fontSize: "60px" }}>Get in touch</h1>
            <p style={{ fontSize: "30px" }}>
              Have questions? We'd love to hear from you.
            </p>
          </div>

          {/* Cards Section */}
          <div className="row p-5">
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
>
  <i
    className="fa fa-commenting p-5 mt-1"
    aria-hidden="true"
    style={{
      fontSize: "60px", // Reduced size for the icon
      color: "#2D5F9A",
      marginLeft: "30px",
    }}
  ></i>
  <h4>Feedback</h4>
  <p style={{ color: "black" }}></p>
</div>


            {/* Contact Card */}
            <div className="card1 col-3 p-5">
              <i
                className="fa fa-phone-square mt-1"
                aria-hidden="true"
                style={{
                  fontSize: "80px",
                  color: "#2D5F9A",
                  marginLeft: "30px",
                }}
              ></i>
              <h4>Contact us</h4>
              <p>+91 8294291858</p>
            </div>

            {/* Facebook Card */}
            <div className="card1 col-3 p-5">
              <i
                className="fa fa-facebook-square"
                aria-hidden="true"
                style={{
                  fontSize: "80px",
                  color: "#2D5F9A",
                  marginLeft: "30px",
                }}
              ></i>
              <h4>Facebook</h4>
              <p>
                <a
                  href="https://www.facebook.com/"
                  target="_blank"
                  rel="noopener noreferrer"
                  style={{ color: "black" }}
                >
                  See our posts
                </a>
              </p>
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
            >
              <i
                className="fa fa-instagram"
                aria-hidden="true"
                style={{
                  fontSize: "80px",
                  color: "#E4405F",
                  marginLeft: "30px",
                }}
              ></i>
              <h4>Instagram</h4>
              <p style={{ color: "black" }}>See our Instagram</p>
            </div>
          </div>

          {/* Message and Map Section */}
          <div className="row">
            <div
              className="message col-6 p-5"
              style={{ display: "flex", flexWrap: "wrap" }}
            >
              <form className="form">
                <h3
                  style={{
                    textAlign: "center",
                    paddingTop: "10px",
                    paddingBottom: "60px",
                  }}
                >
                  Send us a Message
                </h3>

                <label htmlFor="name">Enter your name</label>
                <br />
                <input
                  type="text"
                  placeholder="Here enter your name"
                  id="name"
                  className="frm"
                />
                <br />

                <label htmlFor="email">Email</label>
                <br />
                <input
                  type="email"
                  placeholder="Enter Email"
                  id="email"
                  className="frm"
                />
                <br />

                <label htmlFor="sub">Subject</label>
                <br />
                <input
                  type="text"
                  placeholder="Enter Subject"
                  id="sub"
                  className="frm"
                />
                <br />

                <label htmlFor="mess">Message</label>
                <br />
                <textarea
                  placeholder="Enter Message"
                  rows="4"
                  id="mess"
                  className="frm"
                  style={{ height: "90px" }}
                ></textarea>

                <div className="container">
                  <button
                    type="submit"
                    className="btn btn-primary mb-5"
                    style={{
                      color: "white",
                      backgroundColor: "#2D5F9A",
                      border: "none",
                      width: "80vh",
                      height: "40px",
                    }}
                  >
                    <i className="fa fa-paper-plane p-2" aria-hidden="true" />
                    Send Message
                  </button>
                </div>
              </form>
            </div>

            <div className="message col-6 p-5">
              <form
                className="form"
                style={{
                  border: "2px solid black",
                  height: "750px",
                  borderRadius: "20px",
                }}
              >
                <MapComponent />
              </form>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default ContactPage;
