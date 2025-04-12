import React, { useState } from 'react';
import { useCart } from '../cartcomponent/CartContext';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import './Order.css';

const OrderdetailPage = () => {
  const { cart } = useCart();
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    fullName: '',
    phoneNumber: '',
    streetAddress: '',
    city: '',
    state: '',
    pinCode: '',
    landmark: ''
  });
  const [error, setError] = useState('');

  const total = cart.reduce((acc, item) => acc + item.price * item.quantity, 0);
  const deliveryCharge = total > 1000 ? 0 : 50;
  const tax = total * 0.18; // 18% GST
  const finalTotal = total + deliveryCharge + tax;

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handlePlaceOrder = async () => {
    // Validate required fields
    const requiredFields = ['fullName', 'phoneNumber', 'streetAddress', 'city', 'state', 'pinCode'];
    const emptyFields = requiredFields.filter(field => !formData[field]);
    
    if (emptyFields.length > 0) {
      setError('Please fill in all required fields');
      return;
    }

    // Validate phone number
    if (!/^\d{10}$/.test(formData.phoneNumber)) {
      setError('Please enter a valid 10-digit phone number');
      return;
    }

    // Validate pin code
    if (!/^\d{6}$/.test(formData.pinCode)) {
      setError('Please enter a valid 6-digit PIN code');
      return;
    }

    try {
      const fullAddress = `${formData.fullName}\n${formData.streetAddress}\n${formData.landmark ? formData.landmark + '\n' : ''}${formData.city}, ${formData.state} - ${formData.pinCode}\nPhone: ${formData.phoneNumber}`;
      
      const response = await axios.post('http://localhost:8080/api/orders', {
        address: fullAddress,
        products: cart,
        total,
      }, {
        headers: {
          Authorization: `Bearer ${localStorage.getItem('token')}`,
        },
      });

      if (response.status === 201) {
        alert('Order placed successfully!');
        navigate('/orders'); // Redirect to order history
      }
    } catch (error) {
      console.error('Error placing order:', error);
      setError('Failed to place order. Please try again.');
    }
  };

  return (
    <div className="order-details-container">
      <div className="order-details-left">
        <div className="delivery-address">
          <h2>Delivery Address</h2>
          <div className="form-group">
            <input
              type="text"
              name="fullName"
              value={formData.fullName}
              onChange={handleChange}
              placeholder="Full Name *"
              className="form-input"
            />
          </div>
          <div className="form-group">
            <input
              type="tel"
              name="phoneNumber"
              value={formData.phoneNumber}
              onChange={handleChange}
              placeholder="Phone Number (10 digits) *"
              className="form-input"
            />
          </div>
          <div className="form-group">
            <textarea
              name="streetAddress"
              value={formData.streetAddress}
              onChange={handleChange}
              placeholder="Street Address *"
              className="form-input"
              rows="2"
            />
          </div>
          <div className="form-row">
            <div className="form-group">
              <input
                type="text"
                name="city"
                value={formData.city}
                onChange={handleChange}
                placeholder="City *"
                className="form-input"
              />
            </div>
            <div className="form-group">
              <input
                type="text"
                name="state"
                value={formData.state}
                onChange={handleChange}
                placeholder="State *"
                className="form-input"
              />
            </div>
          </div>
          <div className="form-row">
            <div className="form-group">
              <input
                type="text"
                name="pinCode"
                value={formData.pinCode}
                onChange={handleChange}
                placeholder="PIN Code (6 digits) *"
                className="form-input"
              />
            </div>
            <div className="form-group">
              <input
                type="text"
                name="landmark"
                value={formData.landmark}
                onChange={handleChange}
                placeholder="Landmark (Optional)"
                className="form-input"
              />
            </div>
          </div>
          {error && <p className="error-message">{error}</p>}
        </div>

        <div className="order-items">
          <h2>Order Items ({cart.length})</h2>
          {cart.map((item) => (
            <div key={item.id} className="order-item">
              <div className="item-image">
                <img src={item.image} alt={item.name} />
              </div>
              <div className="item-details">
                <h3>{item.name}</h3>
                <p className="item-code">Code: {item.code}</p>
                <div className="item-price-qty">
                  <span className="quantity">Quantity: {item.quantity}</span>
                  <span className="price">₹{item.price}</span>
                </div>
                <p className="item-total">Item Total: ₹{item.price * item.quantity}</p>
              </div>
            </div>
          ))}
        </div>
      </div>

      <div className="order-details-right">
        <div className="price-details">
          <h2>Price Details</h2>
          <div className="price-row">
            <span>Price ({cart.length} items)</span>
            <span>₹{total.toFixed(2)}</span>
          </div>
          <div className="price-row">
            <span>Delivery Charges</span>
            <span>{deliveryCharge === 0 ? 'FREE' : `₹${deliveryCharge.toFixed(2)}`}</span>
          </div>
          <div className="price-row">
            <span>GST (18%)</span>
            <span>₹{tax.toFixed(2)}</span>
          </div>
          <div className="price-row total">
            <span>Total Amount</span>
            <span>₹{finalTotal.toFixed(2)}</span>
          </div>
          {deliveryCharge === 0 && (
            <div className="savings-message">
              You saved ₹50 on delivery charges
            </div>
          )}
          <button className="place-order" onClick={handlePlaceOrder}>
            Place Order
          </button>
        </div>
      </div>
    </div>
  );
};

export default OrderdetailPage;