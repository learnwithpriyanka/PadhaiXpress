// frontend/src/printer/PrinterDashboard.jsx
import React, { useEffect, useState } from 'react';
import { supabase } from '../supabaseClient';
import './PrinterDashboard.css';
import { createClient } from '@supabase/supabase-js';
import { Link } from 'react-router-dom';

const PrinterDashboard = () => {
  const [orders, setOrders] = useState([]);
  const [checkedItems, setCheckedItems] = useState({}); // { orderId: Set of checked item ids }

  useEffect(() => {
    fetchOrders();
  }, []);

  const fetchOrders = async () => {
    const { data } = await supabase
      .from('orders')
      .select('*, order_items(*, product:product_id(*))')
      .eq('status', 'placed');
    setOrders(data);
    // Reset checked items when orders change
    const initialChecked = {};
    (data || []).forEach(order => {
      initialChecked[order.id] = new Set();
    });
    setCheckedItems(initialChecked);
  };

  const markPrinted = async (orderId) => {
    await supabase.from('orders').update({ status: 'printed' }).eq('id', orderId);
    fetchOrders();
  };

  const handleCheck = (orderId, itemId, checked) => {
    setCheckedItems(prev => {
      const newChecked = { ...prev };
      const set = new Set(newChecked[orderId] || []);
      if (checked) {
        set.add(itemId);
      } else {
        set.delete(itemId);
      }
      newChecked[orderId] = set;
      return newChecked;
    });
  };

  // Helper to get signed URL for PDF
  const getSignedPdfUrl = async (pdfUrl) => {
    try {
      const url = new URL(pdfUrl);
      const pathParts = url.pathname.split('/');
      // Find the bucket name (assume it's always after 'object')
      const objectIdx = pathParts.findIndex(p => p === 'object');
      const bucket = pathParts[objectIdx + 1];
      const filePath = pathParts.slice(objectIdx + 2).join('/');
      console.log('PDF Download - Bucket:', bucket, 'FilePath:', filePath);
      if (!bucket || !filePath) {
        alert('Could not extract bucket or file path for PDF.');
        return pdfUrl;
      }
      const { data, error } = await supabase.storage.from(bucket).createSignedUrl(filePath, 60);
      if (error || !data?.signedUrl) {
        alert('Could not generate signed URL for PDF.');
        return pdfUrl;
      }
      return data.signedUrl;
    } catch (e) {
      alert('Error preparing PDF download: ' + e.message);
      return pdfUrl;
    }
  };

  const styles = {
    container: {
      maxWidth: '1200px',
      margin: '0 auto',
      padding: '20px',
      fontFamily: '"Segoe UI", Tahoma, Geneva, Verdana, sans-serif',
      backgroundColor: '#f8fafc',
      minHeight: '100vh'
    },
    header: {
      textAlign: 'center',
      marginBottom: '30px',
      color: '#1e293b',
      fontSize: '2.5rem',
      fontWeight: '700',
      background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
      WebkitBackgroundClip: 'text',
      WebkitTextFillColor: 'transparent',
      backgroundClip: 'text'
    },
    ordersGrid: {
      display: 'grid',
      gap: '20px',
      gridTemplateColumns: 'repeat(auto-fit, minmax(400px, 1fr))'
    },
    orderCard: {
      backgroundColor: '#ffffff',
      borderRadius: '12px',
      boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)',
      padding: '24px',
      transition: 'transform 0.2s ease, box-shadow 0.2s ease',
      border: '1px solid #e2e8f0',
      position: 'relative',
      overflow: 'hidden'
    },
    orderCardHover: {
      transform: 'translateY(-2px)',
      boxShadow: '0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)'
    },
    orderHeader: {
      display: 'flex',
      justifyContent: 'space-between',
      alignItems: 'center',
      marginBottom: '16px',
      paddingBottom: '12px',
      borderBottom: '2px solid #f1f5f9'
    },
    orderId: {
      fontSize: '1.1rem',
      fontWeight: '600',
      color: '#1e293b'
    },
    statusBadge: {
      backgroundColor: '#fef3c7',
      color: '#d97706',
      padding: '4px 12px',
      borderRadius: '20px',
      fontSize: '0.8rem',
      fontWeight: '500',
      textTransform: 'uppercase',
      letterSpacing: '0.5px'
    },
    infoSection: {
      marginBottom: '16px'
    },
    infoLabel: {
      fontSize: '0.9rem',
      fontWeight: '600',
      color: '#475569',
      marginBottom: '4px',
      display: 'block'
    },
    infoValue: {
      fontSize: '1rem',
      color: '#1e293b',
      lineHeight: '1.4'
    },
    itemsList: {
      backgroundColor: '#fefefe',
      borderRadius: '8px',
      padding: '12px',
      border: '1px solid #e2e8f0'
    },
    itemsUl: {
      listStyle: 'none',
      padding: '0',
      margin: '8px 0 0 0'
    },
    itemsLi: {
      padding: '12px 0',
      borderBottom: '1px solid #f1f5f9',
      fontSize: '0.95rem',
      color: '#475569',
      marginBottom: '6px',
      display: 'flex',
      alignItems: 'center',
      gap: '12px'
    },
    itemDetails: {
      flex: 1,
      lineHeight: '1.4'
    },
    itemName: {
      fontWeight: '600',
      color: '#1e293b',
      fontSize: '1rem'
    },
    itemCode: {
      color: '#64748b',
      fontSize: '0.9rem'
    },
    itemSpecs: {
      color: '#64748b',
      fontSize: '0.85rem',
      marginTop: '4px',
      display: 'flex',
      flexWrap: 'wrap',
      gap: '8px'
    },
    itemSpec: {
      backgroundColor: '#f1f5f9',
      padding: '2px 8px',
      borderRadius: '4px',
      fontSize: '0.8rem'
    },
    errorText: {
      color: '#dc2626',
      fontWeight: '500',
      fontSize: '0.9rem'
    },
    markPrintedBtn: {
      backgroundColor: '#10b981',
      color: 'white',
      border: 'none',
      padding: '12px 24px',
      borderRadius: '8px',
      fontSize: '1rem',
      fontWeight: '600',
      cursor: 'pointer',
      transition: 'all 0.2s ease',
      marginTop: '16px',
      width: '100%',
      textTransform: 'uppercase',
      letterSpacing: '0.5px'
    },
    markPrintedBtnDisabled: {
      backgroundColor: '#a7f3d0',
      color: '#6b7280',
      border: 'none',
      padding: '12px 24px',
      borderRadius: '8px',
      fontSize: '1rem',
      fontWeight: '600',
      cursor: 'not-allowed',
      marginTop: '16px',
      width: '100%',
      textTransform: 'uppercase',
      letterSpacing: '0.5px',
      opacity: 0.7
    },
    emptyState: {
      textAlign: 'center',
      padding: '60px 20px',
      backgroundColor: '#ffffff',
      borderRadius: '12px',
      boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)',
      color: '#64748b',
      fontSize: '1.2rem'
    }
  };

  return (
    <div style={styles.container}>
      <div style={styles.header}>🖨️ Printer Dashboard</div>
      <div style={{ textAlign: 'center', marginBottom: '20px' }}>
        <Link 
          to="/admin-dashboard/custom-workbooks" 
          style={{
            display: 'inline-block',
            padding: '10px 20px',
            backgroundColor: '#4CAF50',
            color: 'white',
            textDecoration: 'none',
            borderRadius: '8px',
            fontWeight: '600',
            boxShadow: '0 2px 4px rgba(0,0,0,0.1)',
            transition: 'all 0.3s ease'
          }}
        >
          View Custom Workbook Orders
        </Link>
      </div>
      {orders.length === 0 ? (
        <div style={styles.emptyState}>
          <div style={{fontSize: '4rem', marginBottom: '16px'}}>📦</div>
          <p>No orders to print at the moment.</p>
        </div>
      ) : (
        <div style={styles.ordersGrid}>
          {orders.map(order => {
            const allChecked = order.order_items.length > 0 && checkedItems[order.id]?.size === order.order_items.length;
            return (
              <div 
                key={order.id} 
                style={styles.orderCard}
                onMouseEnter={e => Object.assign(e.currentTarget.style, styles.orderCardHover)}
                onMouseLeave={e => {
                  e.currentTarget.style.transform = 'translateY(0)';
                  e.currentTarget.style.boxShadow = styles.orderCard.boxShadow;
                }}
              >
                <div style={styles.orderHeader}>
                  <span style={styles.orderId}>Order #{order.id}</span>
                  <span style={styles.statusBadge}>Status: {order.status}</span>
                </div>
                <div style={styles.infoSection}>
                  <label style={styles.infoLabel}>Order Date</label>
                  <div style={styles.infoValue}>{order.created_at ? new Date(order.created_at).toLocaleString() : '-'}</div>
                </div>
                <div style={styles.infoSection}>
                  <label style={styles.infoLabel}>Order Items</label>
                  <div style={styles.itemsList}>
                    <ul style={styles.itemsUl}>
                      {order.order_items.map(item => (
                        <li key={item.id} style={styles.itemsLi}>
                          <input
                            type="checkbox"
                            checked={checkedItems[order.id]?.has(item.id) || false}
                            onChange={e => handleCheck(order.id, item.id, e.target.checked)}
                            style={{marginRight: '10px', width: '18px', height: '18px'}}
                          />
                          <div style={styles.itemDetails}>
                            <div style={styles.itemName}>{item.product?.name || item.product_id}</div>
                            {/* PDF download link if available */}
                            {item.product?.image && item.product.image.toLowerCase().endsWith('.pdf') && (
                              <button
                                type="button"
                                onClick={async () => {
                                  const url = await getSignedPdfUrl(item.product.image);
                                  window.open(url, '_blank');
                                }}
                                style={{ display: 'inline-block', margin: '6px 0', color: '#2563eb', fontWeight: 500, textDecoration: 'underline', fontSize: '0.95rem', background: 'none', border: 'none', cursor: 'pointer', padding: 0 }}
                              >
                                📄 Download PDF
                              </button>
                            )}
                            <div style={styles.itemCode}>Code: {item.product?.code || '-'}</div>
                            <div style={styles.itemSpecs}>
                              <span style={styles.itemSpec}>Pages: {item.product?.pages || '-'}</span>
                              <span style={styles.itemSpec}>Quantity: {item.quantity}</span>
                              <span style={styles.itemSpec}>Page Type: {item.page_type}</span>

                            </div>
                          </div>
                        </li>
                      ))}
                    </ul>
                  </div>
                </div>
                <button
                  style={allChecked ? styles.markPrintedBtn : styles.markPrintedBtnDisabled}
                  onClick={() => markPrinted(order.id)}
                  disabled={!allChecked}
                >
                  Mark as Printed
                </button>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
};

export default PrinterDashboard;
