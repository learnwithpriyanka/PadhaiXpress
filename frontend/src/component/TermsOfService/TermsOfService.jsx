import React from 'react';
import './TermsOfService.css';
import Footer from '../../Footer';

const TermsOfService = () => {
  return (
    <div className="terms-container">
      <div className="terms-content">
        <div className="terms-header">
          <h1>Terms of Service</h1>
          <p className="last-updated">Last updated: {new Date().toLocaleDateString()}</p>
        </div>

        <div className="terms-section">
          <h2>1. Acceptance of Terms</h2>
          <p>
            By accessing and using PadhaiXpress ("the Service"), you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to abide by the above, please do not use this service.
          </p>
        </div>

        <div className="terms-section">
          <h2>2. Description of Service</h2>
          <p>
            PadhaiXpress is an educational platform that provides:
          </p>
          <ul>
            <li>Digital and physical educational workbooks</li>
            <li>Print services for educational materials</li>
            <li>Book recycling and donation services</li>
            <li>Educational notes and study materials</li>
            <li>University-specific study resources</li>
          </ul>
        </div>

        <div className="terms-section">
          <h2>3. User Accounts and Registration</h2>
          <p>
            To access certain features of the Service, you must register for an account. You agree to:
          </p>
          <ul>
            <li>Provide accurate, current, and complete information during registration</li>
            <li>Maintain and update your account information</li>
            <li>Keep your account credentials secure and confidential</li>
            <li>Notify us immediately of any unauthorized use of your account</li>
            <li>Accept responsibility for all activities under your account</li>
          </ul>
        </div>

        <div className="terms-section">
          <h2>4. Educational Materials and Content</h2>
          <p>
            All educational materials provided through PadhaiXpress are for educational purposes only. Users agree to:
          </p>
          <ul>
            <li>Use materials solely for personal educational purposes</li>
            <li>Not reproduce, distribute, or sell materials without permission</li>
            <li>Respect intellectual property rights of content creators</li>
            <li>Not use materials for commercial purposes without authorization</li>
          </ul>
        </div>

        <div className="terms-section">
          <h2>5. Print Services</h2>
          <p>
            Our print services are subject to the following terms:
          </p>
          <ul>
            <li>Print quality may vary based on file quality and specifications</li>
            <li>Delivery times are estimates and may vary</li>
            <li>Users are responsible for ensuring print files meet our requirements</li>
            <li>Refunds for print services follow our refund policy</li>
          </ul>
        </div>

        <div className="terms-section">
          <h2>6. Recycling and Donation Services</h2>
          <p>
            Our book recycling and donation program operates under these guidelines:
          </p>
          <ul>
            <li>Only educational books and materials are accepted</li>
            <li>Books should be in reasonable condition for donation</li>
            <li>We reserve the right to refuse materials that don't meet criteria</li>
            <li>Donated materials become property of PadhaiXpress</li>
          </ul>
        </div>

        <div className="terms-section">
          <h2>7. Payment and Billing</h2>
          <p>
            Payment terms for our services:
          </p>
          <ul>
            <li>All prices are in Indian Rupees (₹)</li>
            <li>Payment is required at the time of order</li>
            <li>We accept various payment methods as displayed on our platform</li>
            <li>Prices may change with prior notice</li>
            <li>Taxes and shipping fees are additional where applicable</li>
          </ul>
        </div>

        <div className="terms-section">
          <h2>8. Privacy and Data Protection</h2>
          <p>
            Your privacy is important to us. We collect and process personal data in accordance with our Privacy Policy. By using our Service, you consent to such processing and warrant that all data provided is accurate.
          </p>
        </div>

        <div className="terms-section">
          <h2>9. Prohibited Activities</h2>
          <p>
            Users are prohibited from:
          </p>
          <ul>
            <li>Violating any applicable laws or regulations</li>
            <li>Infringing on intellectual property rights</li>
            <li>Attempting to gain unauthorized access to our systems</li>
            <li>Using the Service for any illegal or unauthorized purpose</li>
            <li>Interfering with or disrupting the Service</li>
            <li>Sharing account credentials with others</li>
          </ul>
        </div>

        <div className="terms-section">
          <h2>10. Limitation of Liability</h2>
          <p>
            PadhaiXpress shall not be liable for any indirect, incidental, special, consequential, or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses, resulting from your use of the Service.
          </p>
        </div>

        <div className="terms-section">
          <h2>11. Termination</h2>
          <p>
            We may terminate or suspend your account and access to the Service immediately, without prior notice, for any reason, including breach of these Terms of Service.
          </p>
        </div>

        <div className="terms-section">
          <h2>12. Changes to Terms</h2>
          <p>
            We reserve the right to modify these terms at any time. We will notify users of any material changes via email or through the Service. Continued use of the Service after changes constitutes acceptance of the new terms.
          </p>
        </div>

        <div className="terms-section">
          <h2>13. Contact Information</h2>
          <p>
            For questions about these Terms of Service, please contact us at:
          </p>
          <div className="contact-info">
            <p><strong>Email:</strong> support@padhaixpress.com</p>
            <p><strong>Phone:</strong> +91-XXXXXXXXXX</p>
            <p><strong>Address:</strong> [Your Business Address]</p>
          </div>
        </div>

        <div className="terms-footer">
          <p>
            By using PadhaiXpress, you acknowledge that you have read, understood, and agree to be bound by these Terms of Service.
          </p>
        </div>
      </div>
      <Footer />
    </div>
  );
};

export default TermsOfService; 