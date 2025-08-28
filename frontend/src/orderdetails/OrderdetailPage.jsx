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

  // Set all orders to 'placed' status regardless of payment method
  const orderStatus = 'placed';

  // 1. Create order
  const { data: order, error: orderError } = await supabase
    .from('orders')
    .insert([{
      user_id: user.id,
      address,
      total,
      status: orderStatus,
      payment_method: paymentMethod, // Uncommented to store payment method
      ...razorpayInfo // { razorpay_payment_id, razorpay_order_id, razorpay_signature } - will be null for COD
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
  const [paymentMethod, setPaymentMethod] = useState('online'); // 'online' or 'cod'
  const [error, setError] = useState('');
  // Coupon state
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
  const processingCharge = 8; // Fixed processing charge
  const tax = total * 0.04; // 5% GST
  // Coupon discount applied to subtotal (before delivery/tax)
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

  // Move Razorpay logic inside the component
  const createRazorpayOrder = (amount) => {
    const options = {
      key: import.meta.env.VITE_RAZORPAY_KEY_ID,
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

  // Coupon apply handler
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
      // Check expiry
      if (data.expiry_date && new Date(data.expiry_date) < new Date()) {
        setCouponError('This coupon has expired.');
        setCheckingCoupon(false);
        return;
      }
      // Check min order value
      if (data.min_order_value && total < data.min_order_value) {
        setCouponError(`Minimum order value for this coupon is ₹${data.min_order_value}`);
        setCheckingCoupon(false);
        return;
      }
      // Check max uses
      if (data.max_uses && data.times_used >= data.max_uses) {
        setCouponError('This coupon has reached its usage limit.');
        setCheckingCoupon(false);
        return;
      }
      // Calculate discount
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

      if (paymentMethod === 'cod') {
        // Handle Cash on Delivery
        const order = await placeOrderWithSupabase({
          address: fullAddress,
          cart,
          total: finalTotal,
          razorpayInfo: {}, // Empty object for COD
          clearCart,
          paymentMethod: 'cod',
        });
        navigate('/order-success', { state: { address: fullAddress, order } });
      } else {
        // Handle online payment
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
    <div className="order-details-container">
      <div className="order-details-main">
        {/* Header */}
        <div className="order-details-header">
          <h1>📋 Checkout</h1>
          <p>Complete your order details and payment</p>
        </div>

        <div className="order-details-content">
          {/* Left Column - Form and Items */}
          <div className="order-details-left">
            {/* Delivery Address Section */}
            <div className="form-section">
              <h2>📍 Delivery Address</h2>
              <div className="form-grid">
                <div className="form-field">
                  <label htmlFor="fullName">Full Name *</label>
                  <input
                    type="text"
                    name="fullName"
                    id="fullName"
                    className="form-input"
                    value={formData.fullName}
                    onChange={handleChange}
                    placeholder="Enter your full name"
                  />
                </div>
                <div className="form-field">
                  <label htmlFor="phoneNumber">Phone Number *</label>
                  <input
                    type="tel"
                    name="phoneNumber"
                    id="phoneNumber"
                    className="form-input"
                    value={formData.phoneNumber}
                    onChange={handleChange}
                    placeholder="10-digit mobile number"
                  />
                </div>
                <div className="form-field" style={{ gridColumn: '1 / -1' }}>
                  <label htmlFor="streetAddress">Street Address *</label>
                  <textarea
                    name="streetAddress"
                    id="streetAddress"
                    className="form-textarea"
                    value={formData.streetAddress}
                    onChange={handleChange}
                    placeholder="Enter your complete street address"
                    rows="3"
                  />
                </div>
                <div className="form-field">
                  <label htmlFor="city">City *</label>
                  <input
                    type="text"
                    name="city"
                    id="city"
                    className="form-input"
                    value={formData.city}
                    onChange={handleChange}
                    placeholder="Enter city name"
                  />
                </div>
                <div className="form-field">
                  <label htmlFor="state">State *</label>
                  <input
                    type="text"
                    name="state"
                    id="state"
                    className="form-input"
                    value={formData.state}
                    onChange={handleChange}
                    placeholder="Enter state name"
                  />
                </div>
                <div className="form-field">
                  <label htmlFor="pinCode">PIN Code *</label>
                  <input
                    type="text"
                    name="pinCode"
                    id="pinCode"
                    className="form-input"
                    value={formData.pinCode}
                    onChange={handleChange}
                    placeholder="6-digit PIN code"
                  />
                </div>
                <div className="form-field">
                  <label htmlFor="landmark">Landmark (Optional)</label>
                  <input
                    type="text"
                    name="landmark"
                    id="landmark"
                    className="form-input"
                    value={formData.landmark}
                    onChange={handleChange}
                    placeholder="Nearby landmark"
                  />
                </div>
              </div>
              {error && (
                <div className="error-message">
                  ⚠️ {error}
                </div>
              )}
            </div>

            {/* Order Items Section */}
            <div className="form-section">
              <h2>🛒 Order Items ({cart.length})</h2>
              <div style={{ display: 'flex', flexDirection: 'column', gap: '20px' }}>
                {cart.map((item) => (
                  <div key={item.id} className="order-item-card">
                    <div className="order-item-image">
                      <img 
                        src={item.product?.images} 
                        alt={item.product?.name}
                      />
                    </div>
                    <div className="order-item-details">
                      <h3 className="order-item-title">{item.product?.name}</h3>
                      <div className="order-item-tags">
                        <span className="order-item-tag">Code: {item.product?.code}</span>
                        <span className="order-item-tag">Pages: {item.product?.pages}</span>
                        <span className="order-item-tag">{item.page_type === 'single' ? 'Single Side' : 'Double Side'}</span>
                      </div>
                      <div className="order-item-price-row">
                        <span className="order-item-tag">Quantity: {item.quantity}</span>
                        <span className="order-item-tag" style={{ color: '#059669', fontWeight: 600, fontSize: '1.1rem', background: 'none' }}>
                          ₹{calculateItemPrice(item)}
                        </span>
                      </div>
                      <div className="order-item-total">
                        <span style={{ fontSize: '1rem', fontWeight: 600, color: '#059669' }}>
                          Item Total: ₹{(calculateItemPrice(item) * item.quantity).toFixed(2)}
                        </span>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>

          {/* Right Column - Price Details and Payment */}
          <div className="order-details-right">
            {/* Free Delivery Banner */}
            <div className="free-delivery-banner">
              🚚 Order above ₹500 gets free delivery!
            </div>

            {/* Price Details */}
            <div className="price-card">
              <h3>💰 Price Details</h3>
              <div>
                <div className="price-row">
                  <span>Price ({cart.length} items)</span>
                  <span>₹{total.toFixed(2)}</span>
                </div>
                {appliedCoupon && (
                  <div className="price-row" style={{ color: '#059669', fontWeight: 600 }}>
                    <span>Coupon Discount</span>
                    <span>-₹{discount}</span>
                  </div>
                )}
                <div className="price-row">
                  <span>Delivery Charges</span>
                  <span style={{ color: deliveryCharge === 0 ? '#059669' : undefined, fontWeight: 500 }}>
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
            <div className="price-card">
              <h3>🎫 Apply Coupon</h3>
              <form className="coupon-form" onSubmit={handleApplyCoupon}>
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
                    className="coupon-button"
                    disabled={checkingCoupon || !couponCode.trim()}
                  >
                    {checkingCoupon ? 'Checking...' : 'Apply'}
                  </button>
                ) : (
                  <button
                    type="button"
                    className="coupon-button coupon-remove"
                    onClick={handleRemoveCoupon}
                  >
                    Remove
                  </button>
                )}
              </form>
              {appliedCoupon && (
                <div className="coupon-success">
                  ✅ Coupon <b>{appliedCoupon.code}</b> applied! You saved <b>₹{discount}</b>.
                </div>
              )}
              {couponError && (
                <div className="coupon-error">
                  ❌ {couponError}
                </div>
              )}
            </div>

            {/* Payment Method Section */}
            <div className="price-card">
              <h3>💳 Payment Method</h3>
              <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                <label className={`payment-option${paymentMethod === 'online' ? ' selected' : ''}`}>
                  <input
                    type="radio"
                    name="paymentMethod"
                    value="online"
                    checked={paymentMethod === 'online'}
                    onChange={handlePaymentMethodChange}
                  />
                  <div className="payment-option-content">
                    <i className="fa-solid fa-credit-card online"></i>
                    <span>Online Payment</span>
                  </div>
                </label>
                <label className={`payment-option${paymentMethod === 'cod' ? ' selected' : ''}`}>
                  <input
                    type="radio"
                    name="paymentMethod"
                    value="cod"
                    checked={paymentMethod === 'cod'}
                    onChange={handlePaymentMethodChange}
                  />
                  <div className="payment-option-content">
                    <i className="fa-solid fa-money-bill-wave cod"></i>
                    <span>Cash on Delivery</span>
                  </div>
                </label>
              </div>
            </div>

            {/* Place Order Button */}
            <button 
              className="place-order-button"
              onClick={handlePlaceOrder}
            >
              {paymentMethod === 'cod' ? '🛒 Place Order (Pay on Delivery)' : '💳 Place Order'}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default OrderdetailPage;