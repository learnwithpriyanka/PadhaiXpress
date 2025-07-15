import React from 'react';
import './PrivacyPolicy.css';
import Footer from '../../Footer';

const PrivacyPolicy = () => {
  return (
    <div className="privacy-container">
      <div className="privacy-content">
        <div className="privacy-header">
          <h1>Privacy Policy</h1>
          <p className="last-updated">Last updated: {new Date().toLocaleDateString()}</p>
        </div>

        <div className="privacy-section">
          <h2>1. Information We Collect</h2>
          <p>
            We collect information you provide directly to us, such as when you create an account, place an order, or contact us for support.
          </p>
          <ul>
            <li>Name, email address, and university ID</li>
            <li>Shipping and billing addresses</li>
            <li>Payment information (processed securely)</li>
            <li>Order history and preferences</li>
            <li>Communication records with our support team</li>
          </ul>
        </div>

        <div className="privacy-section">
          <h2>2. How We Use Your Information</h2>
          <p>
            We use the information we collect to:
          </p>
          <ul>
            <li>Process and fulfill your orders</li>
            <li>Provide customer support and respond to inquiries</li>
            <li>Send order confirmations and updates</li>
            <li>Improve our services and user experience</li>
            <li>Comply with legal obligations</li>
            <li>Send educational content and updates (with consent)</li>
          </ul>
        </div>

        <div className="privacy-section">
          <h2>3. Information Sharing</h2>
          <p>
            We do not sell, trade, or rent your personal information to third parties. We may share information with:
          </p>
          <ul>
            <li>Payment processors to complete transactions</li>
            <li>Shipping partners to deliver your orders</li>
            <li>Print service providers for order fulfillment</li>
            <li>Legal authorities when required by law</li>
            <li>Service providers who assist in our operations</li>
          </ul>
        </div>

        <div className="privacy-section">
          <h2>4. Data Security</h2>
          <p>
            We implement appropriate security measures to protect your personal information:
          </p>
          <ul>
            <li>Encryption of sensitive data in transit and at rest</li>
            <li>Secure payment processing through trusted providers</li>
            <li>Regular security assessments and updates</li>
            <li>Limited access to personal information on a need-to-know basis</li>
            <li>Secure data storage and backup procedures</li>
          </ul>
        </div>

        <div className="privacy-section">
          <h2>5. Cookies and Tracking</h2>
          <p>
            We use cookies and similar technologies to:
          </p>
          <ul>
            <li>Remember your preferences and settings</li>
            <li>Analyze website usage and performance</li>
            <li>Provide personalized content and recommendations</li>
            <li>Improve our services and user experience</li>
            <li>Ensure secure authentication and session management</li>
          </ul>
        </div>

        <div className="privacy-section">
          <h2>6. Your Rights and Choices</h2>
          <p>
            You have the right to:
          </p>
          <ul>
            <li>Access and review your personal information</li>
            <li>Update or correct your account information</li>
            <li>Request deletion of your personal data</li>
            <li>Opt-out of marketing communications</li>
            <li>Control cookie preferences through your browser</li>
            <li>Contact us with privacy concerns</li>
          </ul>
        </div>

        <div className="privacy-section">
          <h2>7. Data Retention</h2>
          <p>
            We retain your personal information for as long as necessary to:
          </p>
          <ul>
            <li>Provide our services and fulfill orders</li>
            <li>Comply with legal and regulatory requirements</li>
            <li>Resolve disputes and enforce agreements</li>
            <li>Maintain business records for tax purposes</li>
            <li>Improve our services based on usage patterns</li>
          </ul>
        </div>

        <div className="privacy-section">
          <h2>8. Children's Privacy</h2>
          <p>
            Our services are not intended for children under 13 years of age. We do not knowingly collect personal information from children under 13. If you believe we have collected information from a child under 13, please contact us immediately.
          </p>
        </div>

        <div className="privacy-section">
          <h2>9. International Data Transfers</h2>
          <p>
            Your information may be transferred to and processed in countries other than your own. We ensure appropriate safeguards are in place to protect your data in accordance with applicable laws.
          </p>
        </div>

        <div className="privacy-section">
          <h2>10. Changes to This Policy</h2>
          <p>
            We may update this Privacy Policy from time to time. We will notify you of any material changes by posting the new policy on our website and updating the "Last updated" date. Your continued use of our services after changes constitutes acceptance of the updated policy.
          </p>
        </div>

        <div className="privacy-section">
          <h2>11. Contact Us</h2>
          <p>
            If you have questions about this Privacy Policy or our data practices, please contact us:
          </p>
          <div className="contact-info">
            <p><strong>Email:</strong> privacy@padhaixpress.com</p>
            <p><strong>Phone:</strong> +91-XXXXXXXXXX</p>
            <p><strong>Address:</strong> [Your Business Address]</p>
          </div>
        </div>

        <div className="privacy-footer">
          <p>
            By using PadhaiXpress, you acknowledge that you have read and understood this Privacy Policy and consent to the collection, use, and sharing of your information as described herein.
          </p>
        </div>
      </div>
      <Footer />
    </div>
  );
};

export default PrivacyPolicy; 