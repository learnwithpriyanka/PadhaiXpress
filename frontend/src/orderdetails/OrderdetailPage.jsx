import React, { useState, useEffect } from 'react';
import { useCart } from '../cartcomponent/CartContext';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import './OrderdetailPage.css';
import { supabase } from '../supabaseClient';
import { useToast } from '../components/ToastContext';

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

async function placeOrderWithSupabase({ address, cart, total, razorpayInfo, clearCart, paymentMethod }) {
  const user = (await supabase.auth.getUser()).data.user;
  if (!user) throw new Error('Not logged in');

  const orderStatus = 'placed';

  const { data: order, error: orderError } = await supabase
    .from('orders')
    .insert([{
      user_id: user.id,
      address,
      total,
      status: orderStatus,
      payment_method: paymentMethod,
      ...razorpayInfo
    }])
    .select()
    .single();

  if (orderError) throw orderError;

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

  await supabase
    .from('cart_items')
    .delete()
    .eq('user_id', user.id);

  clearCart(user.id);

  return order;
}

const OrderdetailPage = () => {
  const { cart, clearCart } = useCart();
  const navigate = useNavigate();
  const { showToast } = useToast();
  const [formData, setFormData] = useState({
    fullName: '',
    phoneNumber: '',
    streetAddress: '',
    city: '',
    state: '',
    pinCode: '',
    landmark: ''
  });
  const [paymentMethod, setPaymentMethod] = useState('online');
  const [error, setError] = useState('');
  const [couponCode, setCouponCode] = useState('');
  const [appliedCoupon, setAppliedCoupon] = useState(null);
  const [couponError, setCouponError] = useState('');
  const [discount, setDiscount] = useState(0);
  const [checkingCoupon, setCheckingCoupon] = useState(false);

  const calculateItemPrice = (item) => {
    const perPagePrice = Number(item.product?.per_page_price) || 0;
    const pages = Number(item.product?.pages) || 0;
    const doublePrice = perPagePrice * pages;
    if (item.page_type === 'single') {
      return ((doublePrice * 1.1) + 60).toFixed(2);
    }
    return ((doublePrice*.66) + 60).toFixed(2);
  };

  const total = cart.reduce((acc, item) => 
    acc + (calculateItemPrice(item) * item.quantity), 0
  );
  const deliveryCharge = total > 500 ? 0 : 40;
  const processingCharge = 8;
  const tax = total * 0.04;
  const discountedTotal = Math.max(0, total - discount);
  const finalTotal = discountedTotal + deliveryCharge + processingCharge + tax;

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

  const handlePaymentMethodChange = (e) => {
    setPaymentMethod(e.target.value);
  };

  const createRazorpayOrder = (amount) => {
    const options = {
      key: import.meta.env.VITE_RAZORPAY_KEY_ID,
      amount: Math.round(amount * 100),
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
        try {
          const fullAddress = `${formData.fullName}\n${formData.streetAddress}\n${formData.landmark ? formData.landmark + '\n' : ''}${formData.city}, ${formData.state} - ${formData.pinCode}\nPhone: ${formData.phoneNumber}`;
          const razorpayInfo = {
            razorpay_payment_id: response.razorpay_payment_id,
            razorpay_order_id: response.razorpay_order_id,
            razorpay_signature: response.razorpay_signature,
          };
          const order = await placeOrderWithSupabase({
            address: fullAddress,
            cart,
            total: finalTotal,
            razorpayInfo,
            clearCart,
            paymentMethod: 'online',
          });
          navigate('/order-success', { state: { address: fullAddress, order } });
        } catch (err) {
          setError('Order placement failed: ' + err.message);
        }
      },
    };

    const rzp = new window.Razorpay(options);
    rzp.open();
  };

  async function handleApplyCoupon(e) {
    e.preventDefault();
    setCouponError('');
    setCheckingCoupon(true);
    setDiscount(0);
    setAppliedCoupon(null);
    try {
      const { data, error } = await supabase
        .from('coupons')
        .select('*')
        .eq('code', couponCode.trim())
        .eq('is_active', true)
        .maybeSingle();
      if (error || !data) {
        setCouponError('Invalid or expired coupon code.');
        setCheckingCoupon(false);
        return;
      }
      if (data.expiry_date && new Date(data.expiry_date) < new Date()) {
        setCouponError('This coupon has expired.');
        setCheckingCoupon(false);
        return;
      }
      if (data.min_order_value && total < data.min_order_value) {
        setCouponError(`Minimum order value for this coupon is ₹${data.min_order_value}`);
        setCheckingCoupon(false);
        return;
      }
      if (data.max_uses && data.times_used >= data.max_uses) {
        setCouponError('This coupon has reached its usage limit.');
        setCheckingCoupon(false);
        return;
      }
      let discountValue = 0;
      if (data.discount_type === 'percent') {
        discountValue = Math.round((total * data.discount_value) / 100);
      } else {
        discountValue = Math.round(data.discount_value);
      }
      setDiscount(discountValue);
      setAppliedCoupon(data);
      setCouponError('');
      showToast('Coupon applied!');
    } catch (err) {
      setCouponError('Error applying coupon.');
    }
    setCheckingCoupon(false);
  }

  function handleRemoveCoupon() {
    setCouponCode('');
    setAppliedCoupon(null);
    setDiscount(0);
    setCouponError('');
    showToast('Coupon removed');
  }

  const handlePlaceOrder = async () => {
    const requiredFields = ['fullName', 'phoneNumber', 'streetAddress', 'city', 'state', 'pinCode'];
    const emptyFields = requiredFields.filter(field => !formData[field]);
    
    if (emptyFields.length > 0) {
      setError('Please fill in all required fields');
      return;
    }

    if (!/^\d{10}$/.test(formData.phoneNumber)) {
      setError('Please enter a valid 10-digit phone number');
      return;
    }

    if (!/^\d{6}$/.test(formData.pinCode)) {
      setError('Please enter a valid 6-digit PIN code');
      return;
    }

    try {
      const fullAddress = `${formData.fullName}\n${formData.streetAddress}\n${formData.landmark ? formData.landmark + '\n' : ''}${formData.city}, ${formData.state} - ${formData.pinCode}\nPhone: ${formData.phoneNumber}`;

      if (paymentMethod === 'cod') {
        const order = await placeOrderWithSupabase({
          address: fullAddress,
          cart,
          total: finalTotal,
          razorpayInfo: {},
          clearCart,
          paymentMethod: 'cod',
        });
        navigate('/order-success', { state: { address: fullAddress, order } });
      } else {
        if (!window.Razorpay) {
          setError('Payment gateway is loading. Please try again in a moment.');
          return;
        }
        createRazorpayOrder(finalTotal);
      }
    } catch (error) {
      console.error('Order placement error:', error);
      setError('Failed to place order. Please try again.');
    }
  };

  return (
    <div className="checkout-container">
      <div className="checkout-layout">
        {/* Left Section - Forms */}
        <div className="checkout-left">
          {/* Delivery Address */}
          <div className="section-card">
            <div className="section-header">
              <span className="section-icon">🏠</span>
              <h2>Delivery Address</h2>
            </div>
            
            <div className="form-grid">
              <div className="input-group">
                <input
                  type="text"
                  name="fullName"
                  className="form-input"
                  value={formData.fullName}
                  onChange={handleChange}
                  placeholder="Full Name *"
                  required
                />
              </div>
              
              <div className="input-group">
                <input
                  type="tel"
                  name="phoneNumber"
                  className="form-input"
                  value={formData.phoneNumber}
                  onChange={handleChange}
                  placeholder="Phone Number (10 digits) *"
                  required
                />
              </div>
              
              <div className="input-group full-width">
                <textarea
                  name="streetAddress"
                  className="form-textarea"
                  value={formData.streetAddress}
                  onChange={handleChange}
                  placeholder="Street Address *"
                  rows="3"
                  required
                />
              </div>
              
              <div className="input-group">
                <input
                  type="text"
                  name="city"
                  className="form-input"
                  value={formData.city}
                  onChange={handleChange}
                  placeholder="City *"
                  required
                />
              </div>
              
              <div className="input-group">
                <input
                  type="text"
                  name="state"
                  className="form-input"
                  value={formData.state}
                  onChange={handleChange}
                  placeholder="State *"
                  required
                />
              </div>
              
              <div className="input-group">
                <input
                  type="text"
                  name="pinCode"
                  className="form-input"
                  value={formData.pinCode}
                  onChange={handleChange}
                  placeholder="PIN Code (6 digits) *"
                  required
                />
              </div>
              
              <div className="input-group">
                <input
                  type="text"
                  name="landmark"
                  className="form-input"
                  value={formData.landmark}
                  onChange={handleChange}
                  placeholder="Landmark (Optional)"
                />
              </div>
            </div>
            
            {error && (
              <div className="error-alert">
                {error}
              </div>
            )}
          </div>

          {/* Order Items */}
          <div className="section-card">
            <div className="section-header">
              <span className="section-icon">🛍️</span>
              <h2>Order Items ({cart.length})</h2>
            </div>
            
            <div className="order-items-list">
              {cart.map((item) => (
                <div key={item.id} className="order-item">
                  <div className="item-image">
                    <img src={item.product?.images} alt={item.product?.name} />
                  </div>
                  
                  <div className="item-details">
                    <div className="item-header">
                      <h3 className="item-name">{item.product?.name}</h3>
                      <div className="item-price">₹{calculateItemPrice(item)}</div>
                    </div>
                    
                    <div className="item-meta">
                      <div className="meta-grid">
                        <span className="meta-item">
                          <span className="meta-icon">🔖</span>
                          Code: {item.product?.code}
                        </span>
                        <span className="meta-item">
                          <span className="meta-icon">📄</span>
                          Pages: {item.product?.pages}
                        </span>
                        <span className="meta-item">
                          <span className="meta-icon">📊</span>
                          Print Type: {item.page_type === 'single' ? 'Single Side' : 'Double Side'}
                        </span>
                      </div>
                    </div>
                    
                    <div className="item-footer">
                      <div className="quantity-info">
                        <span>Quantity: {item.quantity}</span>
                      </div>
                      <div className="item-total">
                        <span>Item Total: ₹{(calculateItemPrice(item) * item.quantity).toFixed(2)}</span>
                      </div>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>

        {/* Right Section - Summary */}
        <div className="checkout-right">
          {/* Free Delivery Banner */}
          <div className="delivery-banner">
            🚚 Order above ₹500 gets free delivery!
          </div>

          {/* Price Details */}
          <div className="summary-card">
            <div className="summary-header">
              <span className="summary-icon">💰</span>
              <h3>Price Details</h3>
            </div>
            
            <div className="price-breakdown">
              <div className="price-row">
                <span>Price ({cart.length} items)</span>
                <span>₹{total.toFixed(2)}</span>
              </div>
              
              {appliedCoupon && (
                <div className="price-row discount-row">
                  <span>Coupon Discount</span>
                  <span>-₹{discount}</span>
                </div>
              )}
              
              <div className="price-row">
                <span>Delivery Charges</span>
                <span className={deliveryCharge === 0 ? 'free-delivery' : ''}>
                  {deliveryCharge === 0 ? 'Free' : `₹${deliveryCharge}`}
                </span>
              </div>
              
              <div className="price-row">
                <span>Processing Charge</span>
                <span>₹{processingCharge.toFixed(2)}</span>
              </div>
              
              <div className="price-row">
                <span>Tax (4% GST)</span>
                <span>₹{tax.toFixed(2)}</span>
              </div>
              
              <div className="price-total">
                <div className="price-row">
                  <span>Total</span>
                  <span>₹{finalTotal.toFixed(2)}</span>
                </div>
              </div>
            </div>
          </div>

          {/* Coupon Section */}
          <div className="summary-card">
            <form className="coupon-section" onSubmit={handleApplyCoupon}>
              <input
                type="text"
                className="coupon-input"
                placeholder="Enter coupon code"
                value={couponCode}
                onChange={e => setCouponCode(e.target.value.toUpperCase())}
                disabled={!!appliedCoupon}
              />
              {!appliedCoupon ? (
                <button
                  type="submit"
                  className="coupon-btn apply-btn"
                  disabled={checkingCoupon || !couponCode.trim()}
                >
                  {checkingCoupon ? 'Checking...' : 'Apply'}
                </button>
              ) : (
                <button
                  type="button"
                  className="coupon-btn remove-btn"
                  onClick={handleRemoveCoupon}
                >
                  Remove
                </button>
              )}
            </form>
            
            {appliedCoupon && (
              <div className="coupon-success">
                ✅ Coupon <strong>{appliedCoupon.code}</strong> applied! You saved <strong>₹{discount}</strong>.
              </div>
            )}
            {couponError && (
              <div className="coupon-error">
                ❌ {couponError}
              </div>
            )}
          </div>

          {/* Payment Method */}
          <div className="summary-card">
            <div className="summary-header">
              <span className="summary-icon">💳</span>
              <h3>Payment Method</h3>
            </div>
            
            <div className="payment-methods">
              <label className={`payment-option ${paymentMethod === 'online' ? 'selected' : ''}`}>
                <input
                  type="radio"
                  name="paymentMethod"
                  value="online"
                  checked={paymentMethod === 'online'}
                  onChange={handlePaymentMethodChange}
                />
                <div className="payment-content">
                  <span className="payment-icon online">💳</span>
                  <span>Online Payment</span>
                </div>
              </label>
              
              <label className={`payment-option ${paymentMethod === 'cod' ? 'selected' : ''}`}>
                <input
                  type="radio"
                  name="paymentMethod"
                  value="cod"
                  checked={paymentMethod === 'cod'}
                  onChange={handlePaymentMethodChange}
                />
                <div className="payment-content">
                  <span className="payment-icon cod">💵</span>
                  <span>Cash on Delivery</span>
                </div>
              </label>
            </div>
          </div>

          {/* Place Order Button */}
          <button className="place-order-btn" onClick={handlePlaceOrder}>
            Place Order
          </button>
        </div>
      </div>
    </div>
  );
};

export default OrderdetailPage;