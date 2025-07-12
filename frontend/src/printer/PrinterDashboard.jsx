// frontend/src/printer/PrinterDashboard.jsx
import React, { useEffect, useState } from 'react';
import { supabase } from '../supabaseClient';

const PrinterDashboard = () => {
  const [orders, setOrders] = useState([]);

  useEffect(() => {
    fetchOrders();
  }, []);

  const fetchOrders = async () => {
    const { data } = await supabase
      .from('orders')
      .select('*, order_items(*)')
      .eq('status', 'placed');
    setOrders(data);
  };

  const markPrinted = async (orderId) => {
    await supabase.from('orders').update({ status: 'printed' }).eq('id', orderId);
    fetchOrders();
  };

  return (
    <div>
      <h2>Printer Dashboard</h2>
      {orders.map(order => (
        <div key={order.id}>
          <p>Order ID: {order.id}</p>
          <div>
            {order.order_items.map(item => (
              <div key={item.id}>
                <span>Product: {item.product_id}</span>
                <span>Quantity: {item.quantity}</span>
              </div>
            ))}
          </div>
          <button onClick={() => markPrinted(order.id)}>Mark as Printed</button>
        </div>
      ))}
    </div>
  );
};

export default PrinterDashboard;
