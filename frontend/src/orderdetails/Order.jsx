import React, { useEffect, useState } from 'react';
import { supabase } from '../supabaseClient';
import OrderStatusProgressBar from '../component/OrderStatusProgressBar';
import { useNavigate } from 'react-router-dom';

const Order = () => {
  const [orderHistory, setOrderHistory] = useState([]);
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
              </div>
              <button onClick={() => handleViewDetails(order.id)} style={{height: '40px'}}>
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