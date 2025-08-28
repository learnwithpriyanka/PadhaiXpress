// frontend/src/admin/AdminDashboard.jsx
import React, { useEffect, useState } from 'react';
import { supabase } from '../supabaseClient';
import { Link,useNavigate } from 'react-router-dom';
import OrderStatusProgressBar from '../component/OrderStatusProgressBar';
import { Calendar, Package, Eye, Trash2, Clock, IndianRupee, ShoppingCart } from 'lucide-react';
import styles from './AdminDashboard.module.css';

import ProductManager from './ProductManager';
import AdminSidebar from './AdminSidebar';

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
  const [deletingOrderId, setDeletingOrderId] = useState(null);
  const navigate = useNavigate();
  const [books, setBooks] = useState([]);
  const [bookLoading, setBookLoading] = useState(true);
  const [bookError, setBookError] = useState('');
  const [showAddBook, setShowAddBook] = useState(false);
  const [addingBook, setAddingBook] = useState(false);
  const [deletingBookId, setDeletingBookId] = useState(null);
  const [newBook, setNewBook] = useState({ name: '', code: '', price: '', pages: '', image: '' });

  useEffect(() => {
    fetchOrders();
    fetchBooks();
  }, []);

  const fetchOrders = async () => {
    setLoading(true);
    setError('');
    const { data, error } = await supabase
      .from('orders')
      .select(`*, 
        order_items(*, product:product_id(*)),
        delivered_by_user:delivered_by (name, email)
      `)
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
    // Show confirmation dialog
    const isConfirmed = window.confirm(
      `Are you sure you want to delete Order #${orderId}? This action cannot be undone and will remove the order from both admin dashboard and user history.`
    );

    if (!isConfirmed) {
      return;
    }

    try {
      setDeletingOrderId(orderId);
      setError('');

      console.log('Starting deletion for order:', orderId);

      // Method 1: Try to delete order directly (Supabase should handle foreign key constraints)
      const { data: deletedOrder, error: orderError } = await supabase
        .from('orders')
        .delete()
        .eq('id', orderId)
        .select();

      console.log('Direct order deletion result:', { deletedOrder, orderError });

      if (orderError) {
        console.error('Direct deletion failed, trying step-by-step approach:', orderError);
        
        // Method 2: Step-by-step deletion if direct deletion fails
        // First delete order items
        const { error: itemsError } = await supabase
          .from('order_items')
          .delete()
          .eq('order_id', orderId);

        if (itemsError) {
          console.error('Error deleting order items:', itemsError);
          throw new Error(`Failed to delete order items: ${itemsError.message}`);
        }

        console.log('Order items deleted successfully');

        // Then delete the order
        const { error: finalOrderError } = await supabase
          .from('orders')
          .delete()
          .eq('id', orderId);

        if (finalOrderError) {
          console.error('Error deleting order after items:', finalOrderError);
          throw new Error(`Failed to delete order: ${finalOrderError.message}`);
        }

        console.log('Order deleted successfully via step-by-step method');
      } else {
        console.log('Order deleted successfully via direct method');
      }

      // Refresh the orders list
      await fetchOrders();

      // Show success message
      alert(`Order #${orderId} has been successfully deleted.`);

    } catch (error) {
      console.error('Error deleting order:', error);
      setError(`Failed to delete order: ${error.message}`);
      
      // Show error alert for better visibility
      alert(`Error deleting order: ${error.message}`);
    } finally {
      setDeletingOrderId(null);
    }
  };

  const fetchBooks = async () => {
    setBookLoading(true);
    setBookError('');
    const { data, error } = await supabase.from('products').select('*').order('created_at', { ascending: false });
    if (error) setBookError('Failed to fetch books');
    setBooks(data || []);
    setBookLoading(false);
  };

  const handleAddBook = async (e) => {
    e.preventDefault();
    setAddingBook(true);
    setBookError('');
    // Basic validation
    if (!newBook.name || !newBook.code || !newBook.price || !newBook.pages) {
      setBookError('Please fill all required fields.');
      setAddingBook(false);
      return;
    }
    const { data, error } = await supabase.from('products').insert([
      {
        name: newBook.name,
        code: newBook.code,
        price: Number(newBook.price),
        pages: Number(newBook.pages),
        image: newBook.image || null,
      }
    ]);
    if (error) {
      setBookError('Failed to add book: ' + error.message);
    } else {
      setShowAddBook(false);
      setNewBook({ name: '', code: '', price: '', pages: '', image: '' });
      fetchBooks();
    }
    setAddingBook(false);
  };

  const handleDeleteBook = async (bookId) => {
    if (!window.confirm('Are you sure you want to delete this book?')) return;
    setDeletingBookId(bookId);
    setBookError('');
    const { error } = await supabase.from('products').delete().eq('id', bookId);
    if (error) {
      setBookError('Failed to delete book: ' + error.message);
    } else {
      fetchBooks();
    }
    setDeletingBookId(null);
  };

  // Test function to verify delete button is working
  const testDeleteButton = (orderId) => {
    console.log('Delete button clicked for order:', orderId);
    alert(`Delete button clicked for Order #${orderId}. Proceeding with deletion...`);
    deleteOrder(orderId);
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

  const getPaymentStatusText = (order) => {
    if (order.payment_method === 'cod') {
      return `Cash on Delivery - Pay ₹${order.total.toFixed(2)} on delivery`;
    } else if (order.payment_method === 'online') {
      return 'Online Payment - Paid';
    } else {
      // For orders without payment_method, we can't determine payment type
      // So we'll show a generic message
      // return 'Payment Method: Not specified';
     return  `Cash on Delivery - Pay ₹${order.total.toFixed(2)} on delivery`;
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
  const calculateItemPrice = (item) => {
    const perPagePrice = Number(item.product?.per_page_price) || 0;
    const pages = Number(item.product?.pages) || 0;
    const doublePrice = perPagePrice * pages;
    if (item.page_type === 'single') {
      return (doublePrice * 1.1)+60;
    }
    return (doublePrice * .66)+60;
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
    <div style={{ display: 'flex' }}>
      <AdminSidebar />
      <div style={{ marginLeft: 220, width: '100%' }}>
      {/* Header */}
      <div className={styles.header}>
        <div className={styles.headerContent}>
          <div>
            <div className={styles.title}>Admin Dashboard</div>
            <div className={styles.subtitle}>Manage and track all orders</div>
          </div>

          <div className={styles.totalOrders}>
            <Link to="/admin-dashboard/product-manager">Product Manager</Link>
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
                  {/* Payment Status */}
                  <div style={{ 
                    marginTop: '8px',
                    padding: '4px 8px',
                    borderRadius: '4px',
                    fontSize: '0.9rem',
                    fontWeight: '600',
                    backgroundColor: getPaymentStatusColor(order) === '#f59e0b' ? '#fef3c7' : 
                                   getPaymentStatusColor(order) === '#10b981' ? '#d1fae5' : '#f3f4f6',
                    color: getPaymentStatusColor(order),
                    display: 'inline-block'
                  }}>
                    {getPaymentStatusText(order)}
                  </div>
                </div>
                <div>
                  <span className={getStatusBadgeClass(order.status)}>{order.status}</span>
                </div>
                <button onClick={() => handleViewDetails(order.id)} className={styles.viewDetailsBtn}>
                  <Eye style={{width:18,height:18,marginRight:6,verticalAlign:'middle'}} /> View Details
                </button>
              </div>

              {/* Delivery Info Section */}
              {order.delivered_by_user && (
                <div style={{
                  background: '#e0f2fe',
                  border: '1px solid #bae6fd',
                  borderRadius: '8px',
                  padding: '10px 16px',
                  margin: '12px 0',
                  fontWeight: 500,
                  color: '#0369a1',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '10px',
                  fontSize: '0.98rem'
                }}>
                  <span style={{fontWeight:600}}>Delivered By:</span>
                  <span>{order.delivered_by_user.name} ({order.delivered_by_user.email})</span>
                </div>
              )}

              {/* Delivery Address Section */}
              {order.address && (
                <div style={{
                  background: 'linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%)',
                  border: '1px solid #e2e8f0',
                  borderRadius: '12px',
                  padding: '16px',
                  margin: '16px 0',
                  position: 'relative',
                  overflow: 'hidden'
                }}>
                  <div style={{
                    position: 'absolute',
                    top: '0',
                    left: '0',
                    width: '4px',
                    height: '100%',
                    background: 'linear-gradient(135deg, #ea580c 0%, #c2410c 100%)'
                  }}></div>
                  <div style={{
                    display: 'flex',
                    alignItems: 'flex-start',
                    gap: '12px'
                  }}>
                    <div style={{
                      background: 'linear-gradient(135deg, #ea580c 0%, #c2410c 100%)',
                      color: 'white',
                      width: '32px',
                      height: '32px',
                      borderRadius: '50%',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      flexShrink: 0,
                      boxShadow: '0 2px 8px rgba(234, 88, 12, 0.3)'
                    }}>
                      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                        <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/>
                        <circle cx="12" cy="10" r="3"/>
                      </svg>
                    </div>
                    <div style={{ flex: 1 }}>
                      <div style={{
                        fontSize: '0.875rem',
                        fontWeight: '600',
                        color: '#374151',
                        marginBottom: '4px',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '6px'
                      }}>
                        <span>📍</span>
                        Delivery Address
                      </div>
                      <div style={{
                        fontSize: '0.875rem',
                        color: '#4b5563',
                        lineHeight: '1.5',
                        whiteSpace: 'pre-line',
                        fontFamily: 'monospace',
                        background: 'white',
                        padding: '8px 12px',
                        borderRadius: '6px',
                        border: '1px solid #e5e7eb',
                        marginTop: '4px'
                      }}>
                        {order.address}
                      </div>
                    </div>
                  </div>
                </div>
              )}

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
                        src={item.product?.images} 
                        alt={item.product?.name}
                        className={styles.productImage}
                      />
                      <div className={styles.productDetails}>
                        <div className={styles.productName}>{item.product?.name}</div>
                        <div className={styles.productMeta}>
                          <span>Code: <span style={{fontWeight:500}}>{item.product?.code}</span></span>
                          <span>Base Price: <span style={{fontWeight:500}}>₹{calculateItemPrice(item)}</span></span>
                          <span>Pages: <span style={{fontWeight:500}}>{item.product?.pages}</span></span>
                          <span>Print Type: <span style={{fontWeight:500}}>{item.page_type === 'single' ? 'Single Side' : 'Double Side'}</span></span>
                        </div>
                      </div>
                      <div>
                        <div className={styles.productQty}>Qty: {item.quantity}</div>
                        <div className={styles.productTotal}>₹{(Number(calculateItemPrice(item)) * item.quantity ).toFixed(2)}</div>
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
                <button 
                  onClick={() => {
                    console.log('Delete button clicked for order:', order.id);
                    if (window.confirm(`Delete Order #${order.id}?`)) {
                        deleteOrder(order.id);
                    }
                  }} 
                  className={styles.deleteBtn}
                  disabled={deletingOrderId === order.id}
                  style={{
                    opacity: deletingOrderId === order.id ? 0.6 : 1,
                    cursor: deletingOrderId === order.id ? 'not-allowed' : 'pointer'
                  }}
                >
                  {deletingOrderId === order.id ? (
                    <>
                      <div style={{
                        width: 16,
                        height: 16,
                        border: '2px solid #fff',
                        borderTop: '2px solid transparent',
                        borderRadius: '50%',
                        animation: 'spin 1s linear infinite',
                        display: 'inline-block',
                        marginRight: 6
                      }}></div>
                      Deleting...
                    </>
                  ) : (
                    <>
                      <Trash2 style={{width:18,height:18,marginRight:6,verticalAlign:'middle'}} /> 
                      Delete Order
                    </>
                  )}
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
    </div>
  );
};

export default AdminDashboard;
