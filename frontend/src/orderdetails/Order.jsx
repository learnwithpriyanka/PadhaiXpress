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

      try {
        // Fetch regular orders with product details
        const { data: regularOrders, error: regularError } = await supabase
          .from('orders')
          .select('*, order_items(*, product:product_id(*))')
          .eq('user_id', user.id)
          .order('created_at', { ascending: false });

        // Fetch custom workbook orders
        const { data: customOrders, error: customError } = await supabase
          .from('custom_workbook_orders')
          .select('*')
          .eq('user_id', user.id)
          .order('placed_at', { ascending: false });

        if (regularError) console.error('Error fetching regular orders:', regularError);
        if (customError) console.error('Error fetching custom orders:', customError);

        // Combine and format orders
        const formattedRegularOrders = (regularOrders || []).map(order => ({
          ...order,
          orderType: 'regular',
          displayDate: order.created_at,
          displayTotal: order.total
        }));

        const formattedCustomOrders = (customOrders || []).map(order => ({
          ...order,
          orderType: 'custom',
          displayDate: order.placed_at,
          displayTotal: order.total_amount,
          status: order.status
        }));

        // Combine and sort by date (newest first)
        const allOrders = [...formattedRegularOrders, ...formattedCustomOrders]
          .sort((a, b) => new Date(b.displayDate) - new Date(a.displayDate));

        setOrderHistory(allOrders);
      } catch (error) {
        console.error('Error fetching order history:', error);
      }
    };

    fetchOrderHistory();
  }, []);

  const handleViewDetails = (order) => {
    if (order.orderType === 'custom') {
      navigate(`/custom-workbook-details/${order.id}`);
    } else {
      navigate(`/viewdetails/${order.id}`);
    }
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

      // Pre-update order to mark payment as processing
      await supabase
        .from('orders')
        .update({ 
          payment_method: 'processing',
          status: 'payment_processing'
        })
        .eq('id', order.id);

      const options = {
        key: import.meta.env.VITE_RAZORPAY_KEY_ID,
        amount: Math.round(order.total * 100), // in paise
        currency: 'INR',
        name: 'PadhaiXpress',
        description: `Payment for Order #${order.id}`,
        receipt: `receipt_${Date.now()}`,
        theme: { color: '#3399cc' },
        modal: {
          ondismiss: function() {
            // Reset order status if user cancels
            supabase
              .from('orders')
              .update({ 
                payment_method: 'cod',
                status: 'pending'
              })
              .eq('id', order.id);
            setLoading(prev => ({ ...prev, [order.id]: false }));
          }
        },
        prefill: {
          name: 'Customer',
          email: 'customer@example.com'
        },
        handler: async function (response) {
          // Use a more reliable approach with retry logic
          let retryCount = 0;
          const maxRetries = 3;
          
          const updateOrder = async () => {
            try {
              const { error: updateError } = await supabase
                .from('orders')
                .update({
                  payment_method: 'online',
                  razorpay_payment_id: response.razorpay_payment_id,
                  razorpay_order_id: response.razorpay_order_id,
                  razorpay_signature: response.razorpay_signature,
                  status: 'confirmed'
                })
                .eq('id', order.id);

              if (updateError) {
                throw updateError;
              }

              // Success - refresh order history
              const { data: orders, error } = await supabase
                .from('orders')
                .select('*, order_items(*, product:product_id(*))')
                .eq('user_id', (await supabase.auth.getUser()).data.user.id)
                .order('created_at', { ascending: false });

              if (!error) setOrderHistory(orders);
              
              alert('Payment successful! Your order has been updated.');
              setLoading(prev => ({ ...prev, [order.id]: false }));
              return true;
            } catch (err) {
              retryCount++;
              if (retryCount < maxRetries) {
                // Retry after a short delay
                setTimeout(updateOrder, 1000);
                return false;
              } else {
                alert('Payment successful but order update failed. Please contact support.');
                setLoading(prev => ({ ...prev, [order.id]: false }));
                return false;
              }
            }
          };

          updateOrder();
        },
      };

      const rzp = new window.Razorpay(options);
      rzp.open();
    } catch (error) {
      alert('Failed to initiate payment. Please try again.');
      setLoading(prev => ({ ...prev, [order.id]: false }));
    }
  };

  const getPaymentStatusText = (order) => {
    const total = order.orderType === 'custom' ? order.total_amount : order.total;
    
    if (order.payment_method === 'cod') {
      return `Cash on Delivery - Pay ₹${total.toFixed(2)} on delivery`;
    } else if (order.payment_method === 'online') {
      return 'Online Payment - Paid';
    } else {
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
      <h2>📋 Complete Order History</h2>
      {orderHistory.length > 0 ? (
        orderHistory.map((order) => (
          <div key={`${order.orderType}-${order.id}`} className="order-item">
            {/* Order Type Badge */}
            <div className={`order-type-badge ${order.orderType}`}>{order.orderType === 'custom' ? '📚 Custom Workbook' : '📖 Lab Workbook'}</div>
            <div className="order-header">
              <div>
                <h3>Order ID: #{order.id}</h3>
                <p>📅 Date: {new Date(order.displayDate).toLocaleDateString()}</p>
                <p>💰 Total: ₹{order.displayTotal.toFixed(2)}</p>
                <p>📊 Status: {order.status.replace('_', ' ').toUpperCase()}</p>
                {order.orderType === 'regular' && order.delivery_time && (
                  <p>🚚 Delivery By: {new Date(order.delivery_time).toLocaleString()}</p>
                )}
                {order.orderType === 'custom' && (
                  <p>📄 Pages: {order.pages}</p>
                )}
                <p className="order-payment-status" style={{ color: getPaymentStatusColor(order), backgroundColor: getPaymentStatusColor(order) === '#f59e0b' ? '#fef3c7' : getPaymentStatusColor(order) === '#10b981' ? '#d1fae5' : '#f3f4f6' }}>
                  {getPaymentStatusText(order)}
                </p>
                {/* Pay Now Button for COD Orders (only for regular orders) */}
                {order.orderType === 'regular' && order.payment_method === 'cod' && order.status !== 'delivered' && (
                  <button
                    className="pay-now-btn"
                    onClick={() => handlePayNow(order)}
                    disabled={loading[order.id]}
                  >
                    {loading[order.id] ? 'Processing...' : '💳 Pay Now'}
                  </button>
                )}
              </div>
              <button 
                onClick={() => handleViewDetails(order)} 
                className={`view-details-btn ${order.orderType}`}
              >
                👁️ View Details
              </button>
            </div>
            <OrderStatusProgressBar status={order.status} />
            {/* Order Summary for Custom Orders */}
            {order.orderType === 'custom' && (
              <div className="custom-order-summary">
                <h4>📋 Order Summary</h4>
                <p><strong>Customer:</strong> {order.delivery_name}</p>
                <p><strong>Phone:</strong> {order.phone}</p>
                <p><strong>Address:</strong> {order.address}</p>
                {order.landmark && <p><strong>Landmark:</strong> {order.landmark}</p>}
                <p><strong>Pincode:</strong> {order.pincode}</p>
              </div>
            )}
          </div>
        ))
      ) : (
        <div className="order-empty-state">
          <div className="order-empty-icon">📋</div>
          <h3>No Orders Found</h3>
          <p>You haven't placed any orders yet.</p>
          <div className="order-empty-actions">
            <button className="primary-button" onClick={() => navigate('/workbook')}>
              📖 Browse Lab Workbooks
            </button>
            <button className="secondary-button" onClick={() => navigate('/project')}>
              📚 Create Custom Workbook
            </button>
          </div>
        </div>
      )}
    </div>
  );
};

export default Order;