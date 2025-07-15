import React, { useState, useEffect } from 'react';
import { useCart } from '../cartcomponent/CartContext';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import './Order.css';
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
    const basePrice = Number(item.product?.price) || 0;
    return item.page_type === "single" ? basePrice * 2 : basePrice;
  };

  const total = cart.reduce((acc, item) => 
    acc + (calculateItemPrice(item) * item.quantity), 0
  );
  const deliveryCharge = total > 1000 ? 0 : 50;
  const tax = total * 0.18; // 18% GST
  // Coupon discount applied to subtotal (before delivery/tax)
  const discountedTotal = Math.max(0, total - discount);
  const finalTotal = discountedTotal + deliveryCharge + tax;

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
        {/* Coupon input UI */}
        <div className="coupon-section" style={{ marginBottom: 18, background: '#f8fafc', borderRadius: 10, padding: 16, boxShadow: '0 1px 6px rgba(0,0,0,0.04)' }}>
          <form onSubmit={handleApplyCoupon} style={{ display: 'flex', gap: 8, alignItems: 'center' }}>
            <input
              type="text"
              placeholder="Enter coupon code"
              value={couponCode}
              onChange={e => setCouponCode(e.target.value.toUpperCase())}
              disabled={!!appliedCoupon}
              style={{ flex: 1, padding: '0.7rem', borderRadius: 6, border: '1px solid #e5e7eb', fontSize: '1rem', fontWeight: 500 }}
            />
            {!appliedCoupon ? (
              <button
                type="submit"
                disabled={checkingCoupon || !couponCode.trim()}
                style={{ background: '#2563eb', color: '#fff', border: 'none', borderRadius: 6, padding: '0.7rem 1.5rem', fontWeight: 600, fontSize: '1rem', cursor: 'pointer' }}
              >
                {checkingCoupon ? 'Checking...' : 'Apply'}
              </button>
            ) : (
              <button
                type="button"
                onClick={handleRemoveCoupon}
                style={{ background: '#ef4444', color: '#fff', border: 'none', borderRadius: 6, padding: '0.7rem 1.5rem', fontWeight: 600, fontSize: '1rem', cursor: 'pointer' }}
              >
                Remove
              </button>
            )}
          </form>
          {appliedCoupon && (
            <div style={{ color: '#22c55e', marginTop: 6, fontWeight: 600 }}>
              Coupon <b>{appliedCoupon.code}</b> applied! You saved <b>₹{discount}</b>.
            </div>
          )}
          {couponError && (
            <div style={{ color: '#ef4444', marginTop: 6, fontWeight: 500 }}>{couponError}</div>
          )}
        </div>
        <div className="price-details">
          <h2>Price Details</h2>
          <div className="price-row">
            <span>Price ({cart.length} items)</span>
            <span>₹{total.toFixed(2)}</span>
          </div>
          {appliedCoupon && (
            <div className="price-row" style={{ color: '#22c55e', fontWeight: 600 }}>
              <span>Coupon Discount</span>
              <span>-₹{discount}</span>
            </div>
          )}
          <div className="price-row">
            <span>Delivery Charges</span>
            <span>{deliveryCharge === 0 ? 'Free' : `₹${deliveryCharge}`}</span>
          </div>
          <div className="price-row">
            <span>Tax (18% GST)</span>
            <span>₹{tax.toFixed(2)}</span>
          </div>
          <div className="price-row" style={{ fontWeight: 700, fontSize: '1.1rem' }}>
            <span>Total</span>
            <span>₹{finalTotal.toFixed(2)}</span>
          </div>
        </div>

          {/* Payment Method Selection */}
          <div className="payment-method-section">
            <h3>Payment Method</h3>
            <div className="payment-options">
              <label className="payment-option">
                <input
                  type="radio"
                  name="paymentMethod"
                  value="online"
                  checked={paymentMethod === 'online'}
                  onChange={handlePaymentMethodChange}
                />
                <div className="payment-option-content">
                  <i className="fa-solid fa-credit-card"></i>
                  <span>Online Payment</span>
                </div>
              </label>
              <label className="payment-option">
                <input
                  type="radio"
                  name="paymentMethod"
                  value="cod"
                  checked={paymentMethod === 'cod'}
                  onChange={handlePaymentMethodChange}
                />
                <div className="payment-option-content">
                  <i className="fa-solid fa-money-bill-wave"></i>
                  <span>Cash on Delivery</span>
                </div>
              </label>
            </div>
          </div>

          <button className="place-order" onClick={handlePlaceOrder}>
            {paymentMethod === 'cod' ? 'Place Order (Pay on Delivery)' : 'Place Order'}
          </button>
        </div>
    </div>
  );
};

export default OrderdetailPage;