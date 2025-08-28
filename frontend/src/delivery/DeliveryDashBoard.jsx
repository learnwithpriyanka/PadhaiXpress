import React, { useEffect, useState } from "react";
import { supabase } from "../supabaseClient";
import { Link } from "react-router-dom";

const DeliveryDashboard = () => {
  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [outOfDeliveryMarked, setOutOfDeliveryMarked] = useState({}); // { orderId: true/false }

  useEffect(() => {
    const fetchOrders = async () => {
      setLoading(true);
      
      // Use a single query with proper joins
      const { data: orders, error } = await supabase
        .from("orders")
        .select(`
          id, status, address, user_id, created_at, total,payment_method,
          users!user_id (id, name, email),
          order_items (
            id, quantity, price, page_type, product_id
          )
        `)
        .in("status", ["printed", "out-for-delivery"]);

      if (error) {
        setError(error.message);
        console.error("Orders fetch error:", error);
        setLoading(false);
        return;
      }

      // Fetch products separately to handle the text-based product_id
      const productIds = [];
      (orders || []).forEach(order => {
        if (order.order_items && Array.isArray(order.order_items)) {
          order.order_items.forEach(item => {
            if (item.product_id && !productIds.includes(item.product_id)) {
              productIds.push(item.product_id);
            }
          });
        }
      });

      let products = {};
      if (productIds.length > 0) {
        const { data: productsData, error: productsError } = await supabase
          .from("products")
          .select("id, name, code, pages, image")
          .in("id", productIds);
        
        if (productsError) {
          console.error("Products fetch error:", productsError);
        } else {
          productsData.forEach(product => {
            products[product.id] = product;
          });
        }
      }

      // Merge products with order items
      const ordersWithProducts = (orders || []).map(order => ({
        ...order,
        order_items: order.order_items ? order.order_items.map(item => ({
          ...item,
          product: products[item.product_id] || null
        })) : []
      }));

      console.log("Fetched orders with items:", ordersWithProducts);
      setOrders(ordersWithProducts);
      
      // Reset out-of-delivery state for new orders
      const initialMarked = {};
      ordersWithProducts.forEach(order => {
        initialMarked[order.id] = order.status === "out-for-delivery";
      });
      setOutOfDeliveryMarked(initialMarked);
      
      setLoading(false);
    };

    fetchOrders();

    // Set up real-time subscription for new orders
    const subscription = supabase
      .channel('delivery-orders')
      .on('postgres_changes', 
        { 
          event: '*', 
          schema: 'public', 
          table: 'orders',
          filter: 'status=in.(printed,out-for-delivery)' // This correctly listens for printed orders
        }, 
        (payload) => {
          console.log('Order status changed:', payload);
          // Add a small delay to ensure database is updated
          setTimeout(() => {
            console.log('Refreshing orders after status change...');
            fetchOrders();
          }, 500);
        }
      )
      .subscribe();

    return () => {
      subscription.unsubscribe();
    };
  }, []);

  // Add periodic refresh every 10 seconds
  useEffect(() => {
    const interval = setInterval(() => {
      console.log('Periodic refresh triggered...');
      const fetchOrders = async () => {
        const { data: orders, error } = await supabase
          .from("orders")
          .select(`
            id, status, address, user_id, created_at, total,payment_method,
            users!user_id (id, name, email),
            order_items (
              id, quantity, price, page_type, product_id
            )
          `)
          .in("status", ["printed", "out-for-delivery"]);

        if (error) {
          console.error("Periodic refresh orders error:", error);
          return;
        }

        // Fetch products separately to handle the text-based product_id
        const productIds = [];
        (orders || []).forEach(order => {
          if (order.order_items && Array.isArray(order.order_items)) {
            order.order_items.forEach(item => {
              if (item.product_id && !productIds.includes(item.product_id)) {
                productIds.push(item.product_id);
              }
            });
          }
        });

        let products = {};
        if (productIds.length > 0) {
          const { data: productsData, error: productsError } = await supabase
            .from("products")
            .select("id, name, code, pages, image")
            .in("id", productIds);
          
          if (productsError) {
            console.error("Products fetch error:", productsError);
          } else {
            productsData.forEach(product => {
              products[product.id] = product;
            });
          }
        }

        // Merge products with order items
        const ordersWithProducts = (orders || []).map(order => ({
          ...order,
          order_items: order.order_items ? order.order_items.map(item => ({
            ...item,
            product: products[item.product_id] || null
          })) : []
        }));

        console.log("Periodic refresh - Orders with items:", ordersWithProducts);
        setOrders(ordersWithProducts);
        
        const initialMarked = {};
        ordersWithProducts.forEach(order => {
          initialMarked[order.id] = order.status === "out-for-delivery";
        });
        setOutOfDeliveryMarked(initialMarked);
      };
      
      fetchOrders();
    }, 10000); // 10 seconds

    return () => clearInterval(interval);
  }, []);

  // Manual refresh function
  const handleRefresh = async () => {
    setLoading(true);
    
    const { data: orders, error } = await supabase
      .from("orders")
      .select(`
        id, status, address, user_id, created_at, total,payment_method,
        users!user_id (id, name, email),
        order_items (
          id, quantity, price, page_type, product_id
        )
      `)
      .in("status", ["printed", "out-for-delivery"]);

    if (error) {
      setError(error.message);
      console.error("Manual refresh orders error:", error);
      setLoading(false);
      return;
    }

    // Fetch products separately to handle the text-based product_id
    const productIds = [];
    (orders || []).forEach(order => {
      if (order.order_items && Array.isArray(order.order_items)) {
        order.order_items.forEach(item => {
          if (item.product_id && !productIds.includes(item.product_id)) {
            productIds.push(item.product_id);
          }
        });
      }
    });

    let products = {};
    if (productIds.length > 0) {
      const { data: productsData, error: productsError } = await supabase
        .from("products")
        .select("id, name, code, pages, image")
        .in("id", productIds);
      
      if (productsError) {
        console.error("Products fetch error:", productsError);
      } else {
        productsData.forEach(product => {
          products[product.id] = product;
        });
      }
    }

    // Merge products with order items
    const ordersWithProducts = (orders || []).map(order => ({
      ...order,
      order_items: order.order_items ? order.order_items.map(item => ({
        ...item,
        product: products[item.product_id] || null
      })) : []
    }));

    console.log("Manual refresh - Orders with items:", ordersWithProducts);
    setOrders(ordersWithProducts);
    
    const initialMarked = {};
    ordersWithProducts.forEach(order => {
      initialMarked[order.id] = order.status === "out-for-delivery";
    });
    setOutOfDeliveryMarked(initialMarked);
    
    setLoading(false);
  };

  const markAsDelivered = async (orderId) => {
    const user = (await supabase.auth.getUser()).data.user;
    const { error } = await supabase
      .from("orders")
      .update({ status: "delivered", delivered_by: user.id })
      .eq("id", orderId);
    if (error) {
      alert("Failed to update order: " + error.message);
    } else {
      setOrders((prev) => prev.filter((order) => order.id !== orderId));
    }
  };

  const handleMarkOutOfDelivery = async (orderId) => {
    const { error } = await supabase
      .from("orders")
      .update({ status: "out-for-delivery" })
      .eq("id", orderId);
    
    if (error) {
      alert("Failed to update order: " + error.message);
    } else {
      setOutOfDeliveryMarked(prev => ({ ...prev, [orderId]: true }));
      
      // Refresh orders with the same improved query structure
      const { data: orders, error: refreshError } = await supabase
        .from("orders")
        .select(`
          id, status, address, user_id, created_at, total,payment_method,
          users!user_id (id, name, email),
          order_items (
            id, quantity, price, page_type, product_id
          )
        `)
        .in("status", ["printed", "out-for-delivery"]);

      if (refreshError) {
        console.error("Orders refresh error:", refreshError);
        return;
      }

      // Fetch products separately to handle the text-based product_id
      const productIds = [];
      (orders || []).forEach(order => {
        if (order.order_items && Array.isArray(order.order_items)) {
          order.order_items.forEach(item => {
            if (item.product_id && !productIds.includes(item.product_id)) {
              productIds.push(item.product_id);
            }
          });
        }
      });

      let products = {};
      if (productIds.length > 0) {
        const { data: productsData, error: productsError } = await supabase
          .from("products")
          .select("id, name, code, pages, image")
          .in("id", productIds);
        
        if (productsError) {
          console.error("Products fetch error:", productsError);
        } else {
          productsData.forEach(product => {
            products[product.id] = product;
          });
        }
      }

      // Merge products with order items
      const ordersWithProducts = (orders || []).map(order => ({
        ...order,
        order_items: order.order_items ? order.order_items.map(item => ({
          ...item,
          product: products[item.product_id] || null
        })) : []
      }));

      setOrders(ordersWithProducts);
    }
  };

  const markPrinted = async (orderId) => {
    const { error } = await supabase
      .from('orders')
      .update({ status: 'printed' })
      .eq('id', orderId);
      
    if (error) {
      console.error('Error marking order as printed:', error);
      alert('Failed to mark order as printed: ' + error.message);
    } else {
      console.log(`Order ${orderId} marked as printed`);
      // Refresh the orders list
      fetchOrders();
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
    loadingContainer: {
      display: 'flex',
      justifyContent: 'center',
      alignItems: 'center',
      height: '300px',
      fontSize: '1.2rem',
      color: '#64748b'
    },
    spinner: {
      width: '40px',
      height: '40px',
      border: '4px solid #e2e8f0',
      borderTop: '4px solid #667eea',
      borderRadius: '50%',
      animation: 'spin 1s linear infinite',
      marginRight: '15px'
    },
    errorContainer: {
      backgroundColor: '#fee2e2',
      border: '1px solid #fecaca',
      borderRadius: '8px',
      padding: '16px',
      color: '#dc2626',
      textAlign: 'center',
      fontSize: '1.1rem'
    },
    emptyState: {
      textAlign: 'center',
      padding: '60px 20px',
      backgroundColor: '#ffffff',
      borderRadius: '12px',
      boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)',
      color: '#64748b',
      fontSize: '1.2rem'
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
    customerInfo: {
      backgroundColor: '#f8fafc',
      padding: '12px',
      borderRadius: '8px',
      border: '1px solid #e2e8f0'
    },
    addressInfo: {
      backgroundColor: '#f0f9ff',
      padding: '12px',
      borderRadius: '8px',
      border: '1px solid #bae6fd'
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
      marginBottom: '6px'
    },
    itemContainer: {
      display: 'flex',
      alignItems: 'flex-start',
      gap: '12px'
    },
    itemImage: {
      width: '50px',
      height: '50px',
      objectFit: 'cover',
      borderRadius: '6px',
      border: '1px solid #e2e8f0',
      flexShrink: 0
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
    deliverButton: {
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
    deliverButtonHover: {
      backgroundColor: '#059669',
      transform: 'translateY(-1px)',
      boxShadow: '0 4px 12px rgba(16, 185, 129, 0.3)'
    },
    markOutBtn: {
      backgroundColor: '#ef4444',
      color: 'white',
      border: 'none',
      padding: '10px 20px',
      borderRadius: '8px',
      fontSize: '1rem',
      fontWeight: '600',
      cursor: 'pointer',
      marginBottom: '12px',
      marginTop: '8px',
      transition: 'background 0.2s',
      width: '100%',
      letterSpacing: '0.5px',
      textTransform: 'uppercase',
    },
    markOutBtnMarked: {
      backgroundColor: '#22c55e',
      color: 'white',
      border: 'none',
      padding: '10px 20px',
      borderRadius: '8px',
      fontSize: '1rem',
      fontWeight: '600',
      cursor: 'pointer',
      marginBottom: '12px',
      marginTop: '8px',
      transition: 'background 0.2s',
      width: '100%',
      letterSpacing: '0.5px',
      textTransform: 'uppercase',
    }
  };

  if (loading) {
    return (
      <div style={styles.container}>
        <div style={styles.loadingContainer}>
          <div style={styles.spinner}></div>
          Loading orders...
        </div>
        <style jsx>{`
          @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
          }
        `}</style>
      </div>
    );
  }
  const calculateItemPrice = (item) => {
    const pages = Number(item.product?.pages) || 0;
    const doublePrice =  pages;
    if (item.page_type === 'single') {
      return (doublePrice * 1)+50;
    }
    return (doublePrice * .66)+60;
  };

  if (error) {
    return (
      <div style={styles.container}>
        <div style={styles.errorContainer}>
          <strong>Error:</strong> {error}
        </div>
      </div>
    );
  }

  return (
    <div style={styles.container}>
      <div style={{display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '30px'}}>
        <h2 style={styles.header}>🚚 Delivery Dashboard</h2>
        <button 
          onClick={handleRefresh}
          disabled={loading}
          style={{
            backgroundColor: '#3b82f6',
            color: 'white',
            border: 'none',
            padding: '10px 20px',
            borderRadius: '8px',
            fontSize: '1rem',
            fontWeight: '600',
            cursor: loading ? 'not-allowed' : 'pointer',
            opacity: loading ? 0.6 : 1,
            display: 'flex',
            alignItems: 'center',
            gap: '8px'
          }}
        >
          🔄 {loading ? 'Refreshing...' : 'Refresh'}
        </button>
      </div>

      <div style={{ textAlign: 'center', marginBottom: '20px' }}>
        <button 
          onClick={() => window.open('/admin-dashboard/custom-workbooks', '_blank')}
          style={{
            display: 'inline-block',
            padding: '10px 16px',
            backgroundColor: '#4CAF50',
            color: 'white',
            border: 'none',
            borderRadius: '8px',
            fontWeight: '600',
            boxShadow: '0 2px 4px rgba(0,0,0,0.1)',
            transition: 'all 0.3s ease',
            cursor: 'pointer'
          }}
        >
          View Custom Workbook Orders (New Tab)
        </button>
      </div>

      {orders.length === 0 ? (
        <div style={styles.emptyState}>
          <div style={{fontSize: '4rem', marginBottom: '16px'}}>📦</div>
          <p>No orders out for delivery at the moment.</p>
          <p style={{fontSize: '1rem', color: '#94a3b8'}}>Check back later for new deliveries!</p>
        </div>
      ) : (
        <div style={styles.ordersGrid}>
          {orders.map((order) => {
            console.log("Rendering order:", order);
            console.log("Order customer:", order.customer);
            console.log("Order items:", order.order_items);

            return (
              <div 
                key={order.id} 
                style={styles.orderCard}
                onMouseEnter={(e) => {
                  Object.assign(e.currentTarget.style, styles.orderCardHover);
                }}
                onMouseLeave={(e) => {
                  e.currentTarget.style.transform = 'translateY(0)';
                  e.currentTarget.style.boxShadow = styles.orderCard.boxShadow;
                }}
              >
                <div style={styles.orderHeader}>
                  <span style={styles.orderId}>Order #{order.id}</span>
                  <span style={styles.statusBadge}>{order.status === 'printed' ? 'Printed' : 'Out for Delivery'}</span>
                </div>

                <div style={styles.infoSection}>
                  <label style={styles.infoLabel}>👤 Customer</label>
                  <div style={{...styles.infoValue, ...styles.customerInfo}}>
                    {order.users && order.users.name && order.users.email
                      ? `${order.users.name} (${order.users.email})`
                      : <span style={styles.errorText}>Customer info missing! Order ID: {order.id}</span>
                    }
                  </div>
                </div>

                <div style={styles.infoSection}>
                  <label style={styles.infoLabel}>📍 Delivery Address</label>
                  <div style={{...styles.infoValue, ...styles.addressInfo}}>
                    {order.address || <span style={styles.errorText}>Address missing!</span>}
                  </div>
                </div>

                <div style={styles.infoSection}>
                  <label style={styles.infoLabel}>💳 Payment Method</label>
                  <div style={{...styles.infoValue, background: '#f1f5f9', borderRadius: '8px', padding: '10px', border: '1px solid #e2e8f0'}}>
                    {order.payment_method === 'online' ? (
                      <span style={{ color: '#16a34a', fontWeight: 'bold' }}>Paid</span>
                    ) : order.payment_method ? (
                      <>
                        {order.payment_method} <span style={{ color: '#16a34a', fontWeight: 'bold' }}>₹{order.total}</span>
                      </>
                    ) : (
                      <span style={styles.errorText}>Not specified</span>
                    )}
                  </div>
                </div>

                <div style={styles.infoSection}>
                  <label style={styles.infoLabel}>📦 Order Items</label>
                  <div style={styles.itemsList}>
                    {order.order_items && Array.isArray(order.order_items) && order.order_items.length > 0 ? (
                      <ul style={styles.itemsUl}>
                        {order.order_items.map((item) => {
                          console.log("Rendering item:", item);
                          return (
                            <li key={item.id} style={styles.itemsLi}>
                              <div style={styles.itemContainer}>
                                <img 
                                  src={'/media/image/klimage.png'} 
                                  alt={item.product?.name || 'Product'} 
                                  style={styles.itemImage}
                                  onError={(e) => {
                                    e.target.src = '/media/image/placeholder.jpg';
                                  }}
                                />
                                <div style={styles.itemDetails}>
                                  <div style={styles.itemName}>
                                    {item.product?.name || `Product ID: ${item.product_id}`}
                                  </div>
                                  <div style={styles.itemCode}>
                                    (Code: {item.product?.code || 'N/A'})
                                  </div>
                                  <div style={styles.itemSpecs}>
                                    <span style={styles.itemSpec}>Pages: {item.product?.pages || 'N/A'}</span>
                                    <span style={styles.itemSpec}>Quantity: {item.quantity || 'N/A'}</span>
                                    <span style={styles.itemSpec}>Price: ₹{calculateItemPrice(item) || 'N/A'}</span>
                                    <span style={styles.itemSpec}>Print: {item.page_type || 'N/A'}</span>
                                  </div>
                                </div>
                              </div>
                              {!item.product && (
                                <span style={styles.errorText}>
                                  Product info missing for product_id: {item.product_id}
                                </span>
                              )}
                            </li>
                          );
                        })}
                      </ul>
                    ) : (
                      <div>
                        <span style={styles.errorText}>
                          No order items found! 
                          {order.order_items ? 
                            ` Items array length: ${order.order_items.length}` : 
                            ' Items array is null/undefined'
                          }
                        </span>
                        <div style={{fontSize: '0.8rem', color: '#64748b', marginTop: '4px'}}>
                          Order ID: {order.id} | Status: {order.status} | Total Items: {order.order_items?.length || 0}
                        </div>
                        <div style={{fontSize: '0.8rem', color: '#64748b', marginTop: '2px'}}>
                          Last updated: {new Date().toLocaleTimeString()}
                        </div>
                      </div>
                    )}
                  </div>
                </div>

                <button
                  style={outOfDeliveryMarked[order.id] ? styles.markOutBtnMarked : styles.markOutBtn}
                  onClick={() => handleMarkOutOfDelivery(order.id)}
                  disabled={outOfDeliveryMarked[order.id]}
                >
                  {outOfDeliveryMarked[order.id] ? 'Out-of-Delivery Marked' : 'Mark Out-of-Delivery'}
                </button>
                <button 
                  style={styles.deliverButton}
                  onMouseEnter={(e) => {
                    Object.assign(e.currentTarget.style, styles.deliverButtonHover);
                  }}
                  onMouseLeave={(e) => {
                    e.currentTarget.style.backgroundColor = styles.deliverButton.backgroundColor;
                    e.currentTarget.style.transform = 'translateY(0)';
                    e.currentTarget.style.boxShadow = 'none';
                  }}
                  onClick={() => markAsDelivered(order.id)}
                >
                  ✅ Mark as Delivered
                </button>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
};

export default DeliveryDashboard;
