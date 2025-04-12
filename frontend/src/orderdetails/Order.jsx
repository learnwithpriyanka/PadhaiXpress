import React, { useEffect, useState } from 'react';
import axios from 'axios';
import './Order.css';

const Order = () => {
  const [orderHistory, setOrderHistory] = useState([]);

  useEffect(() => {
    const fetchOrderHistory = async () => {
      try {
        const response = await axios.get('http://localhost:8080/api/orders', {
          headers: {
            Authorization: `Bearer ${localStorage.getItem('token')}`,
          },
        });
        setOrderHistory(response.data.orders);
      } catch (error) {
        console.error('Error fetching order history:', error);
      }
    };

    fetchOrderHistory();
  }, []);

  return (
    <div className="order-history">
      <h2>Order History</h2>
      {orderHistory.length > 0 ? (
        orderHistory.map((order) => (
          <div key={order.id} className="order-item">
            <h3>Order ID: {order.id}</h3>
            <p>Date: {new Date(order.date).toLocaleDateString()}</p>
            <p>Total: ₹{order.total}</p>
            <div className="order-products">
              <h4>Products:</h4>
              {order.products.map((product) => (
                <div key={product.id} className="product-item">
                  <p>{product.name} - Quantity: {product.quantity}</p>
                </div>
              ))}
            </div>
          </div>
        ))
      ) : (
        <p>No orders found.</p>
      )}
    </div>
  );
};

export default Order;