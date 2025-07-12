// frontend/src/admin/AdminDashboard.jsx
import React, { useEffect, useState } from 'react';
import { supabase } from '../supabaseClient';
import { useNavigate } from 'react-router-dom';
import OrderStatusProgressBar from '../component/OrderStatusProgressBar';
import { Calendar, Package, Eye, Trash2, Clock, IndianRupee, ShoppingCart } from 'lucide-react';
import styles from './AdminDashboard.module.css';

const statusOptions = [
  'placed',
  'printed',
  'out-for-delivery',
  'delivered'
];

const AdminDashboard = () => {
  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const navigate = useNavigate();

  useEffect(() => {
    fetchOrders();
  }, []);

  const fetchOrders = async () => {
    setLoading(true);
    setError('');
    const { data, error } = await supabase
      .from('orders')
      .select('*, order_items(*, product:product_id(*))')
      .order('created_at', { ascending: false });
    if (error) setError('Failed to fetch orders');
    setOrders(data || []);
    setLoading(false);
  };

  const updateOrder = async (orderId, updates) => {
    await supabase.from('orders').update(updates).eq('id', orderId);
    fetchOrders();
  };

  const deleteOrder = async (orderId) => {
    await supabase.from('orders').delete().eq('id', orderId);
    fetchOrders();
  };

  const handleViewDetails = (orderId) => {
    navigate(`/viewdetails/${orderId}`);
  };

  const getStatusBadgeClass = (status) => {
    if (status === 'placed') return styles.statusBadge + ' ' + styles.placed;
    if (status === 'printed') return styles.statusBadge + ' ' + styles.printed;
    if (status === 'out-for-delivery') return styles.statusBadge + ' ' + styles.outForDelivery;
    if (status === 'delivered') return styles.statusBadge + ' ' + styles.delivered;
    return styles.statusBadge;
  };

  if (loading) {
    return (
      <div className={styles.adminDashboard} style={{display:'flex',alignItems:'center',justifyContent:'center',minHeight:'100vh'}}>
        <div>
          <div style={{margin:'0 auto',width:48,height:48,border:'4px solid #2563eb',borderRadius:'50%',borderTop:'4px solid transparent',animation:'spin 1s linear infinite'}}></div>
          <p style={{marginTop:16,color:'#666'}}>Loading orders...</p>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className={styles.adminDashboard} style={{display:'flex',alignItems:'center',justifyContent:'center',minHeight:'100vh'}}>
        <div style={{background:'#fee2e2',border:'1px solid #fecaca',borderRadius:12,padding:32,maxWidth:400}}>
          <div style={{display:'flex',alignItems:'center'}}>
            <svg style={{height:24,width:24,color:'#ef4444'}} viewBox="0 0 20 20" fill="currentColor">
              <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clipRule="evenodd" />
            </svg>
            <div style={{marginLeft:12}}>
              <h3 style={{fontWeight:600,color:'#991b1b',fontSize:16}}>Error</h3>
              <p style={{color:'#991b1b',fontSize:14}}>{error}</p>
            </div>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className={styles.adminDashboard}>
      {/* Header */}
      <div className={styles.header}>
        <div className={styles.headerContent}>
          <div>
            <div className={styles.title}>Admin Dashboard</div>
            <div className={styles.subtitle}>Manage and track all orders</div>
          </div>
          <div className={styles.totalOrders}>Total Orders: {orders.length}</div>
        </div>
      </div>
      {/* Main Content */}
      <div className={styles.mainContent}>
        {orders.length > 0 ? (
          orders.map(order => (
            <div key={order.id} className={styles.orderCard}>
              {/* Order Header */}
              <div className={styles.orderHeader}>
                <div className={styles.orderMeta}>
                  <div className={styles.orderId}>Order #{order.id}</div>
                  <div className={styles.orderInfo}>
                    <span><Calendar style={{width:16,height:16,marginRight:4,verticalAlign:'middle'}} /> {new Date(order.created_at).toLocaleDateString()}</span>
                    <span><IndianRupee style={{width:16,height:16,marginRight:4,verticalAlign:'middle'}} /> {order.total}</span>
                    <span><Clock style={{width:16,height:16,marginRight:4,verticalAlign:'middle'}} /> {order.delivery_time ? new Date(order.delivery_time).toLocaleString() : 'TBD'}</span>
                  </div>
                </div>
                <div>
                  <span className={getStatusBadgeClass(order.status)}>{order.status}</span>
                </div>
                <button onClick={() => handleViewDetails(order.id)} className={styles.viewDetailsBtn}>
                  <Eye style={{width:18,height:18,marginRight:6,verticalAlign:'middle'}} /> View Details
                </button>
              </div>
              {/* Progress Bar */}
              <div className={styles.progressBarSection}>
                <OrderStatusProgressBar status={order.status} />
              </div>
              {/* Order Items */}
              <div className={styles.productList}>
                <div className={styles.productListTitle}><ShoppingCart style={{width:18,height:18,marginRight:6,verticalAlign:'middle'}} /> Order Items</div>
                <div className={styles.productsGrid}>
                  {order.order_items && order.order_items.map((item) => (
                    <div key={item.id} className={styles.productCard}>
                      <img 
                        src={item.product?.image} 
                        alt={item.product?.name}
                        className={styles.productImage}
                      />
                      <div className={styles.productDetails}>
                        <div className={styles.productName}>{item.product?.name}</div>
                        <div className={styles.productMeta}>
                          <span>Code: <span style={{fontWeight:500}}>{item.product?.code}</span></span>
                          <span>Base Price: <span style={{fontWeight:500}}>₹{item.product?.price}</span></span>
                          <span>Pages: <span style={{fontWeight:500}}>{item.product?.pages}</span></span>
                          <span>Print Type: <span style={{fontWeight:500}}>{item.page_type === 'single' ? 'Single Side' : 'Double Side'}</span></span>
                        </div>
                      </div>
                      <div>
                        <div className={styles.productQty}>Qty: {item.quantity}</div>
                        <div className={styles.productTotal}>₹{(Number(item.product?.price) * item.quantity).toFixed(2)}</div>
                      </div>
                    </div>
                  ))}
                </div>
              </div>
              {/* Order Actions */}
              <div className={styles.orderActions}>
                <div className={styles.actionGroup}>
                  <label>Status:</label>
                  <select
                    value={order.status}
                    onChange={e => updateOrder(order.id, { status: e.target.value })}
                    className={styles.statusSelect}
                  >
                    {statusOptions.map(opt => (
                      <option key={opt} value={opt}>{opt.replace('-', ' ')}</option>
                    ))}
                  </select>
                  <label>Delivery Time:</label>
                  <input
                    type="datetime-local"
                    value={order.delivery_time ? new Date(order.delivery_time).toISOString().slice(0,16) : ''}
                    onChange={e => updateOrder(order.id, { delivery_time: e.target.value })}
                    className={styles.deliveryInput}
                  />
                </div>
                <button onClick={() => deleteOrder(order.id)} className={styles.deleteBtn}>
                  <Trash2 style={{width:18,height:18,marginRight:6,verticalAlign:'middle'}} /> Delete Order
                </button>
              </div>
            </div>
          ))
        ) : (
          <div style={{textAlign:'center',padding:'48px 0'}}>
            <div style={{margin:'0 auto',width:96,height:96,color:'#a3a3a3'}}>
              <Package style={{width:'100%',height:'100%'}} />
            </div>
            <h3 style={{marginTop:16,fontSize:20,fontWeight:600,color:'#22223b'}}>No orders found</h3>
            <p style={{marginTop:8,color:'#666'}}>Orders will appear here once customers start placing them.</p>
          </div>
        )}
      </div>
    </div>
  );
};

export default AdminDashboard;
