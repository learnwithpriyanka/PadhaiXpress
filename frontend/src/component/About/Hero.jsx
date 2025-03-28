import React from "react";
import "./About.css";

function Hero() {
  return (
    <div>
      <div className="hero">
        <p>
          PadhaixPress is an innovative educational platform designed to provide
          high-quality study materials, workbooks, and print-ready PDFs.
          <br></br> Our mission is to make learning accessible, engaging, and
          affordable for everyone. Whether you are a school student, <br></br>a
          college student, or a lifelong learner, PadhaixPress has something to
          offer you.
        </p>
      </div>
      <div className="hero2">
        <h1>Key Features</h1>
        <div className="hero2-container">
          <div className="hero2-content">
            <h5>Printable Workbooks</h5>
            <p >Our platform offers printable workbooks that are designed to enhance the learning experience. These workbooks include exercises, quizzes, and practice problems that help reinforce the material covered in the study guides.
            </p>

          </div>
          <div className="hero2-content">
            <h5>Print-Ready PDFs</h5>
            
         <p>We provide print-ready PDFs that can be downloaded and printed with ease. These PDFs are formatted for quick and efficient printing, ensuring that you receive your materials in the shortest time possible.

         </p>

          </div>
          <div className="hero2-content">
            <h5>Comprehensive Study Materials</h5>
            <p>Access a wide range of study materials across various subjects, including science, mathematics, literature, and more. Our resources are meticulously curated to ensure they meet the highest educational standards.</p>

          </div>
          <div className="hero2-content">
            <h5>Cost-Effective Solutions</h5>
            <p>At PadhaixPress, we believe that education should be affordable. We offer our study materials and printing services at competitive prices, making it accessible to a wider audience.</p>

          </div>
        </div>
      </div>
    </div>
  );
}

export default Hero;
