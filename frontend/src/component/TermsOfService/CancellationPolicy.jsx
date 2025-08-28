import React from 'react';
import Footer from '../../Footer';

const CancellationPolicy = () => {
  return (
    <div className="terms-container">
      <div className="terms-content">
        <div className="terms-header">
          <h1>Cancellation & Refund Policy</h1>
          <p className="last-updated">Last updated on Jul 15th 2025</p>
        </div>
        <div className="terms-section">
          <p>PadhaiXpress believes in helping its customers as far as possible, and has therefore a liberal cancellation policy. Under this policy:</p>
          <ul>
            <li>Cancellations will be considered only if the request is made within 1-2 days of placing the order. However, the cancellation request may not be entertained if the orders have been communicated to the vendors/merchants and they have initiated the process of shipping them.</li>
            <li>PadhaiXpress does not accept cancellation requests for perishable items like flowers, eatables etc. However, refund/replacement can be made if the customer establishes that the quality of product delivered is not good.</li>
            <li>In case of receipt of damaged or defective items please report the same to our Customer Service team. The request will, however, be entertained once the merchant has checked and determined the same at his own end. This should be reported within 1-2 days of receipt of the products.</li>
            <li>In case you feel that the product received is not as shown on the site or as per your expectations, you must bring it to the notice of our customer service within 1-2 days of receiving the product. The Customer Service Team after looking into your complaint will take an appropriate decision.</li>
            <li>In case of complaints regarding products that come with a warranty from manufacturers, please refer the issue to them.</li>
            <li>In case of any Refunds approved by the PadhaiXpress, it’ll take 3-5 days for the refund to be processed to the end customer.</li>
          </ul>
        </div>
        <div className="terms-section">
          <div className="footer-modal-disclaimer">
            <strong>Disclaimer:</strong> The above content is created at NAVNIT KUMAR's sole discretion. Razorpay shall not be liable for any content provided here and shall not be responsible for any claims and liability that may arise due to merchant’s non-adherence to it.
          </div>
        </div>
        <div className="terms-footer">
          <p>
            By using PadhaiXpress, you acknowledge that you have read and understood this Cancellation & Refund Policy.
          </p>
        </div>
      </div>
      <Footer />
    </div>
  );
};

export default CancellationPolicy; 