import React from 'react';
import Footer from '../../Footer';

const ShippingPolicy = () => {
  return (
    <div className="terms-container">
      <div className="terms-content">
        <div className="terms-header">
          <h1>Shipping & Delivery Policy</h1>
          <p className="last-updated">Last updated on Jul 15th 2025</p>
        </div>
        <div className="terms-section">
          <p>For International buyers, orders are shipped and delivered through registered international courier companies and/or International speed post only. For domestic buyers, orders are shipped through registered domestic courier companies and /or speed post only. Orders are shipped within 1-2 days or as per the delivery date agreed at the time of order confirmation and delivering of the shipment subject to Courier Company / post office norms. PadhaiXpress is not liable for any delay in delivery by the courier company / postal authorities and only guarantees to hand over the consignment to the courier company or postal authorities within 1-2 days from the date of the order and payment or as per the delivery date agreed at the time of order confirmation. Delivery of all orders will be to the address provided by the buyer. Delivery of our services will be confirmed on your mail ID as specified during registration. For any issues in utilizing our services you may contact our helpdesk on 7667761697 or support@padhaixpress.in</p>
        </div>
        <div className="terms-section">
          <div className="footer-modal-disclaimer">
            <strong>Disclaimer:</strong> The above content is created at NAVNIT KUMAR's sole discretion. Razorpay shall not be liable for any content provided here and shall not be responsible for any claims and liability that may arise due to merchant’s non-adherence to it.
          </div>
        </div>
        <div className="terms-footer">
          <p>
            By using PadhaiXpress, you acknowledge that you have read and understood this Shipping & Delivery Policy.
          </p>
        </div>
      </div>
      <Footer />
    </div>
  );
};

export default ShippingPolicy; 