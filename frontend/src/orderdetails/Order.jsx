import React, { useEffect, useState } from 'react';
import { supabase } from '../supabaseClient';
import OrderStatusProgressBar from '../component/OrderStatusProgressBar';
import { useNavigate } from 'react-router-dom';

const Order = () => {
  const [orderHistory, setOrderHistory] = useState([]);
  const [loading, setLoading] = useState({});
  const navigate = useNavigate();

  useEffect(() => {
    const fetchOrderHistory = async () => {
      const user = (await supabase.auth.getUser()).data.user;
      if (!user) return;

      // Fetch orders with product details for each order item
      const { data: orders, error } = await supabase
        .from('orders')
        .select('*, order_items(*, product:product_id(*))')
        .eq('user_id', user.id)
        .order('created_at', { ascending: false });

      if (!error) setOrderHistory(orders);
    };

    fetchOrderHistory();
  }, []);

  const handleViewDetails = (orderId) => {
    navigate(`/viewdetails/${orderId}`);
  };

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

  const handlePayNow = async (order) => {
    setLoading(prev => ({ ...prev, [order.id]: true }));
    
    try {
      // Load Razorpay script
      await loadRazorpayScript();
      
      if (!window.Razorpay) {
        alert('Payment gateway is loading. Please try again in a moment.');
        return;
      }

      const options = {
        key: 'rzp_test_YoGzNbhZznaSoq',
        amount: Math.round(order.total * 100), // in paise
        currency: 'INR',
        name: 'PadhaiXpress',
        description: `Payment for Order #${order.id}`,
        receipt: `receipt_${Date.now()}`,
        theme: { color: '#3399cc' },
        handler: async function (response) {
          try {
            // Update order payment method and add payment details
            const { error: updateError } = await supabase
              .from('orders')
              .update({
                payment_method: 'online',
                razorpay_payment_id: response.razorpay_payment_id,
                razorpay_order_id: response.razorpay_order_id,
                razorpay_signature: response.razorpay_signature,
              })
              .eq('id', order.id);

            if (updateError) {
              alert('Payment successful but order update failed. Please contact support.');
              return;
            }

            alert('Payment successful! Your order has been updated.');
            // Refresh order history
            const { data: orders, error } = await supabase
              .from('orders')
              .select('*, order_items(*, product:product_id(*))')
              .eq('user_id', (await supabase.auth.getUser()).data.user.id)
              .order('created_at', { ascending: false });

            if (!error) setOrderHistory(orders);
          } catch (err) {
            alert('Payment successful but order update failed. Please contact support.');
          }
        },
      };

      const rzp = new window.Razorpay(options);
      rzp.open();
    } catch (error) {
      alert('Failed to initiate payment. Please try again.');
    } finally {
      setLoading(prev => ({ ...prev, [order.id]: false }));
    }
  };

  const getPaymentStatusText = (order) => {
    if (order.payment_method === 'cod') {
      return `Cash on Delivery - Pay ₹${order.total} on delivery`;
    } else if (order.payment_method === 'online') {
      return 'Online Payment - Paid';
    } else {
      // For orders without payment_method, we can't determine payment type
      // So we'll show a generic message
      return 'Payment Method: Not specified';
    }
  };

  const getPaymentStatusColor = (order) => {
    if (order.payment_method === 'cod') {
      return '#f59e0b'; // Orange for COD
    } else if (order.payment_method === 'online') {
      return '#10b981'; // Green for online payment
    } else {
      return '#6b7280'; // Gray for unspecified
    }
  };

  return (
    <div className="order-history">
      <h2>Order History</h2>
      {orderHistory.length > 0 ? (
        orderHistory.map((order) => (
          <div key={order.id} className="order-item">
            <div className="order-header">
              <div>
                <h3>Order ID: {order.id}</h3>
                <p>Date: {new Date(order.created_at).toLocaleDateString()}</p>
                <p>Total: ₹{order.total}</p>
                <p>Status: {order.status}</p>
                <p>Delivery By: {order.delivery_time ? new Date(order.delivery_time).toLocaleString() : 'TBD'}</p>
                <p style={{ 
                  color: getPaymentStatusColor(order), 
                  fontWeight: '600',
                  fontSize: '0.9rem',
                  marginTop: '8px',
                  padding: '4px 8px',
                  backgroundColor: getPaymentStatusColor(order) === '#f59e0b' ? '#fef3c7' : 
                                 getPaymentStatusColor(order) === '#10b981' ? '#d1fae5' : '#f3f4f6',
                  borderRadius: '4px',
                  display: 'inline-block'
                }}>
                  {getPaymentStatusText(order)}
                </p>
                {/* Pay Now Button for COD Orders */}
                {order.payment_method === 'cod' && (
                  <button
                    onClick={() => handlePayNow(order)}
                    disabled={loading[order.id]}
                    style={{
                      marginTop: '12px',
                      padding: '8px 16px',
                      backgroundColor: '#10b981',
                      color: 'white',
                      border: 'none',
                      borderRadius: '6px',
                      cursor: loading[order.id] ? 'not-allowed' : 'pointer',
                      fontWeight: '600',
                      fontSize: '14px',
                      transition: 'background-color 0.2s ease',
                      opacity: loading[order.id] ? 0.7 : 1
                    }}
                    onMouseOver={(e) => !loading[order.id] && (e.target.style.backgroundColor = '#059669')}
                    onMouseOut={(e) => !loading[order.id] && (e.target.style.backgroundColor = '#10b981')}
                  >
                    {loading[order.id] ? 'Processing...' : '💳 Pay Now'}
                  </button>
                )}
              </div>
              <button 
                onClick={() => handleViewDetails(order.id)} 
                className="view-details-btn"
                style={{
                  height: '40px',
                  padding: '8px 16px',
                  backgroundColor: '#007bff',
                  color: 'white',
                  border: 'none',
                  borderRadius: '6px',
                  cursor: 'pointer',
                  fontWeight: '600',
                  fontSize: '14px',
                  transition: 'background-color 0.2s ease'
                }}
                onMouseOver={(e) => e.target.style.backgroundColor = '#0056b3'}
                onMouseOut={(e) => e.target.style.backgroundColor = '#007bff'}
              >
                View Details
              </button>
            </div>
            <OrderStatusProgressBar status={order.status} />
          </div>
        ))
      ) : (
        <p>No orders found.</p>
      )}
    </div>
  );
};

export default Order;