import React, { useState, useEffect } from 'react';
import { useCart } from '../cartcomponent/CartContext';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import './Order.css';
import { supabase } from '../supabaseClient';

const loadRazorpayScript = () => {
  return new Promise((resolve) => {
    if (window.Razorpay) {
      resolve(true);
      return;
    }
    const script = document.createElement('script');
    script.src = 'https://checkout.razorpay.com/v1/checkout.js';
    script.onload = () => {
      resolve(true);
    };
    script.onerror = () => {
      resolve(false);
    };
    document.body.appendChild(script);
  });
};

async function placeOrderWithSupabase({ address, cart, total, razorpayInfo, clearCart }) {
  const user = (await supabase.auth.getUser()).data.user;
  if (!user) throw new Error('Not logged in');

  // 1. Create order
  const { data: order, error: orderError } = await supabase
    .from('orders')
    .insert([{
      user_id: user.id,
      address,
      total,
      status: 'placed', // <-- add this line
      ...razorpayInfo // { razorpay_payment_id, razorpay_order_id, razorpay_signature }
    }])
    .select()
    .single();

  if (orderError) throw orderError;

  // 2. Add order items
  const orderItems = cart.map(item => ({
    order_id: order.id,
    product_id: item.product_id || item.id,
    quantity: item.quantity,
    price: Number(item.product?.price) || 0,
    page_type: item.page_type,
  }));

  const { error: itemsError } = await supabase
    .from('order_items')
    .insert(orderItems);

  if (itemsError) throw itemsError;

  // 3. Clear cart from database
  await supabase
    .from('cart_items')
    .delete()
    .eq('user_id', user.id);

  // 4. Clear cart in context (this will trigger real-time update)
  clearCart(user.id);

  return order;
}

const OrderdetailPage = () => {
  const { cart, clearCart } = useCart();
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

  const calculateItemPrice = (item) => {
    const basePrice = Number(item.product?.price) || 0;
    return item.page_type === "single" ? basePrice * 2 : basePrice;
  };

  const total = cart.reduce((acc, item) => 
    acc + (calculateItemPrice(item) * item.quantity), 0
  );
  const deliveryCharge = total > 1000 ? 0 : 50;
  const tax = total * 0.18; // 18% GST
  const finalTotal = total + deliveryCharge + tax;

  useEffect(() => {
    loadRazorpayScript();
  }, []);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  // Move Razorpay logic inside the component
  const createRazorpayOrder = (amount) => {
    const options = {
      key: 'rzp_test_YoGzNbhZznaSoq',
      amount: Math.round(amount * 100), // in paise
      currency: 'INR',
      name: 'PadhaiXpress',
      description: 'Order Payment',
      receipt: `receipt_${Date.now()}`,
      prefill: {
        name: formData.fullName,
        contact: formData.phoneNumber,
      },
      theme: { color: '#3399cc' },
      handler: async function (response) {
        // Handle payment success
        try {
          const fullAddress = `${formData.fullName}\n${formData.streetAddress}\n${formData.landmark ? formData.landmark + '\n' : ''}${formData.city}, ${formData.state} - ${formData.pinCode}\nPhone: ${formData.phoneNumber}`;
          const razorpayInfo = {
            razorpay_payment_id: response.razorpay_payment_id,
            razorpay_order_id: response.razorpay_order_id,
            razorpay_signature: response.razorpay_signature,
          };
          await placeOrderWithSupabase({
            address: fullAddress,
            cart,
            total: finalTotal,
            razorpayInfo,
            clearCart, // Pass the clearCart function
          });
          alert('Order placed and payment successful!');
          navigate('/orders');
        } catch (err) {
          setError('Order placement failed: ' + err.message);
        }
      },
    };

    const rzp = new window.Razorpay(options);
    rzp.open();
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
      // Check if Razorpay is loaded
      if (!window.Razorpay) {
        setError('Payment gateway is loading. Please try again in a moment.');
        return;
      }

      // Create and open Razorpay checkout
      createRazorpayOrder(finalTotal);
    } catch (error) {
      console.error('Payment initiation error:', error);
      setError('Failed to initiate payment. Please try again.');
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
                <img src={item.product?.image} alt={item.product?.name} />
              </div>
              <div className="item-details">
                <h3>{item.product?.name}</h3>
                <p className="item-code">Code: {item.product?.code}</p>
                <p className="item-pages">Pages: {item.product?.pages}</p>
                <p className="item-print-type">Print Type: {item.page_type === 'single' ? 'Single Side' : 'Double Side'}</p>

                <div className="item-price-qty">
                  <span className="quantity">Quantity: {item.quantity}</span>
                  <span className="price">₹{calculateItemPrice(item)}</span>
                </div>
                <p className="item-total">Item Total: ₹{(calculateItemPrice(item)* item.quantity).toFixed(2)}</p>
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