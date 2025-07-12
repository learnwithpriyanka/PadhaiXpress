import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { supabase } from '../supabaseClient';
import OrderStatusProgressBar from '../component/OrderStatusProgressBar';

const ViewOrderDetailsPage = () => {
  const { orderid } = useParams();
  const [order, setOrder] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    const fetchOrder = async () => {
      setLoading(true);
      setError('');
      const { data, error } = await supabase
        .from('orders')
        .select('*, order_items(*, product:product_id(*))')
        .eq('id', orderid)
        .single();
      if (error || !data) {
        setError('Order not found');
        setOrder(null);
      } else {
        setOrder(data);
      }
      setLoading(false);
    };
    fetchOrder();
  }, [orderid]);

  if (loading) return <div>Loading...</div>;
  if (error) return <div style={{ color: 'red' }}>{error}</div>;
  if (!order) return null;

  return (
    <div className="order-history" style={{ maxWidth: 800, margin: '32px auto', background: '#fff', borderRadius: 16, padding: 24 }}>
      <h2>Order Details</h2>
      <div className="order-header">
        <div>
          <h3>Order ID: {order.id}</h3>
          <p>Date: {new Date(order.created_at).toLocaleDateString()}</p>
          <p>Total: ₹{order.total}</p>
          <p>Status: {order.status}</p>
          <p>Delivery By: {order.delivery_time ? new Date(order.delivery_time).toLocaleString() : 'TBD'}</p>
        </div>
      </div>
      <OrderStatusProgressBar status={order.status} />
      <div className="order-products">
        <h4>Products:</h4>
        {order.order_items.map((item) => (
          <div key={item.id} className="cart-item">
            <img src={item.product?.image} alt={item.product?.name} />
            <div>
              <h4>{item.product?.name}</h4>
              <p>Code: {item.product?.code}</p>
              <p>Base Price: ₹{item.product?.price} | Pages: {item.product?.pages}</p>
              <p>Print Type: {item.page_type === 'single' ? 'Single Side' : 'Double Side'}</p>
              <p>Quantity: {item.quantity}</p>
              <p>Item Total: ₹{(Number(item.product?.price) * item.quantity).toFixed(2)}</p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default ViewOrderDetailsPage; 