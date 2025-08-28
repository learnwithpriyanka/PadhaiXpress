import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { supabase } from '../supabaseClient';
import OrderStatusProgressBar from '../component/OrderStatusProgressBar';

const CustomWorkbookOrderDetails = () => {
  const { orderid } = useParams();
  const [order, setOrder] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    const fetchOrder = async () => {
      setLoading(true);
      setError('');
      
      try {
        const { data, error } = await supabase
          .from('custom_workbook_orders')
          .select('*')
          .eq('id', orderid)
          .single();
          
        if (error || !data) {
          setError('Order not found');
          setOrder(null);
        } else {
          setOrder(data);
        }
      } catch (err) {
        console.error('Error fetching order:', err);
        setError('Failed to load order details');
        setOrder(null);
      } finally {
        setLoading(false);
      }
    };
    
    fetchOrder();
  }, [orderid]);

  const getStatusColor = (status) => {
    const statusColors = {
      'uploaded': '#2196F3',
      'in_print': '#FF9800',
      'printed': '#9C27B0',
      'out_for_delivery': '#3F51B5',
      'delivered': '#4CAF50',
      'cancelled': '#F44336'
    };
    return statusColors[status] || '#6b7280';
  };

  const formatDate = (dateString) => {
    const options = { 
      year: 'numeric', 
      month: 'long', 
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    };
    return new Date(dateString).toLocaleDateString('en-IN', options);
  };

  if (loading) {
    return (
      <div style={{ 
        maxWidth: 800, 
        margin: '32px auto', 
        background: 'linear-gradient(135deg, #fff7ed 0%, #fef3c7 100%)', 
        borderRadius: 16, 
        padding: 24,
        textAlign: 'center'
      }}>
        <div>Loading order details...</div>
      </div>
    );
  }

  if (error) {
    return (
      <div style={{ 
        maxWidth: 800, 
        margin: '32px auto', 
        background: '#fff', 
        borderRadius: 16, 
        padding: 24,
        textAlign: 'center',
        color: '#dc2626'
      }}>
        <div>❌ {error}</div>
      </div>
    );
  }

  if (!order) return null;

  return (
    <div style={{ 
      maxWidth: 800, 
      margin: '32px auto', 
      background: '#fff', 
      borderRadius: 16, 
      padding: 24,
      boxShadow: '0 4px 6px rgba(0, 0, 0, 0.1)'
    }}>
      <h2 style={{ 
        fontSize: '2rem', 
        fontWeight: 'bold', 
        color: '#333', 
        marginBottom: '2rem',
        textAlign: 'center',
        borderBottom: '3px solid #667eea',
        paddingBottom: '1rem'
      }}>
        📚 Custom Workbook Order Details
      </h2>

      {/* Order Header */}
      <div style={{
        background: '#f8fafc',
        border: '1px solid #e2e8f0',
        borderRadius: '12px',
        padding: '20px',
        marginBottom: '20px'
      }}>
        <h3 style={{ 
          fontSize: '1.5rem', 
          fontWeight: 'bold', 
          color: '#2d3748', 
          marginBottom: '15px'
        }}>
          Order ID: #{order.id}
        </h3>
        
        <div style={{
          display: 'grid',
          gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))',
          gap: '15px'
        }}>
          <div>
            <p style={{ margin: '8px 0', color: '#4a5568' }}>
              <strong>📅 Placed On:</strong> {formatDate(order.placed_at)}
            </p>
            <p style={{ margin: '8px 0', color: '#4a5568' }}>
              <strong>💰 Total Amount:</strong> ₹{order.total_amount.toFixed(2)}
            </p>
            <p style={{ margin: '8px 0', color: '#4a5568' }}>
              <strong>📄 Pages:</strong> {order.pages}
            </p>
          </div>
          <div>
            <p style={{ 
              margin: '8px 0', 
              color: getStatusColor(order.status),
              fontWeight: '600'
            }}>
              <strong>📊 Status:</strong> {order.status.replace('_', ' ').toUpperCase()}
            </p>
            <p style={{ margin: '8px 0', color: '#4a5568' }}>
              <strong>💳 Payment Method:</strong> {order.payment_method === 'cod' ? 'Cash on Delivery' : order.payment_method}
            </p>
            {order.updated_at && (
              <p style={{ margin: '8px 0', color: '#4a5568' }}>
                <strong>🔄 Last Updated:</strong> {formatDate(order.updated_at)}
              </p>
            )}
          </div>
        </div>
      </div>

      {/* Order Status Progress Bar */}
      <div style={{ marginBottom: '20px' }}>
        <OrderStatusProgressBar status={order.status} />
      </div>

      {/* Customer Information */}
      <div style={{
        background: '#f8fafc',
        border: '1px solid #e2e8f0',
        borderRadius: '12px',
        padding: '20px',
        marginBottom: '20px'
      }}>
        <h4 style={{ 
          fontSize: '1.25rem', 
          fontWeight: 'bold', 
          color: '#2d3748', 
          marginBottom: '15px',
          display: 'flex',
          alignItems: 'center',
          gap: '8px'
        }}>
          👤 Customer Information
        </h4>
        
        <div style={{
          display: 'grid',
          gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))',
          gap: '15px'
        }}>
          <div>
            <p style={{ margin: '8px 0', color: '#4a5568' }}>
              <strong>Name:</strong> {order.delivery_name}
            </p>
            <p style={{ margin: '8px 0', color: '#4a5568' }}>
              <strong>Phone:</strong> {order.phone}
            </p>
          </div>
          <div>
            <p style={{ margin: '8px 0', color: '#4a5568' }}>
              <strong>Pincode:</strong> {order.pincode}
            </p>
            {order.landmark && (
              <p style={{ margin: '8px 0', color: '#4a5568' }}>
                <strong>Landmark:</strong> {order.landmark}
              </p>
            )}
          </div>
        </div>
        
        <div style={{ marginTop: '15px' }}>
          <p style={{ margin: '8px 0', color: '#4a5568' }}>
            <strong>📮 Delivery Address:</strong>
          </p>
          <div style={{
            background: '#edf2f7',
            padding: '12px',
            borderRadius: '8px',
            border: '1px solid #e2e8f0',
            whiteSpace: 'pre-line',
            color: '#4a5568'
          }}>
            {order.address}
          </div>
        </div>
      </div>

      {/* File Information */}
      <div style={{
        background: '#f8fafc',
        border: '1px solid #e2e8f0',
        borderRadius: '12px',
        padding: '20px',
        marginBottom: '20px'
      }}>
        <h4 style={{ 
          fontSize: '1.25rem', 
          fontWeight: 'bold', 
          color: '#2d3748', 
          marginBottom: '15px',
          display: 'flex',
          alignItems: 'center',
          gap: '8px'
        }}>
          📄 Workbook File
        </h4>
        
        <div style={{
          display: 'flex',
          alignItems: 'center',
          gap: '15px',
          flexWrap: 'wrap'
        }}>
          <div style={{
            background: '#667eea',
            color: 'white',
            padding: '12px',
            borderRadius: '8px',
            fontSize: '2rem'
          }}>
            📚
          </div>
          
          <div style={{ flex: 1 }}>
            <p style={{ margin: '4px 0', color: '#4a5568' }}>
              <strong>File Type:</strong> PDF Document
            </p>
            <p style={{ margin: '4px 0', color: '#4a5568' }}>
              <strong>Pages:</strong> {order.pages} pages
            </p>
            <p style={{ margin: '4px 0', color: '#4a5568' }}>
              <strong>Status:</strong> File uploaded successfully
            </p>
          </div>
          
          <a 
            href={order.pdf_file_url} 
            target="_blank" 
            rel="noopener noreferrer"
            style={{
              padding: '10px 16px',
              backgroundColor: '#10b981',
              color: 'white',
              textDecoration: 'none',
              borderRadius: '8px',
              fontWeight: '600',
              fontSize: '14px',
              transition: 'background-color 0.2s ease',
              display: 'flex',
              alignItems: 'center',
              gap: '8px'
            }}
            onMouseOver={(e) => e.target.style.backgroundColor = '#059669'}
            onMouseOut={(e) => e.target.style.backgroundColor = '#10b981'}
          >
            📥 View/Download PDF
          </a>
        </div>
      </div>

      {/* Order Summary */}
      <div style={{
        background: '#f8fafc',
        border: '1px solid #e2e8f0',
        borderRadius: '12px',
        padding: '20px'
      }}>
        <h4 style={{ 
          fontSize: '1.25rem', 
          fontWeight: 'bold', 
          color: '#2d3748', 
          marginBottom: '15px',
          display: 'flex',
          alignItems: 'center',
          gap: '8px'
        }}>
          💰 Order Summary
        </h4>
        
        <div style={{
          background: '#edf2f7',
          padding: '15px',
          borderRadius: '8px',
          border: '1px solid #e2e8f0'
        }}>
          <div style={{
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center',
            marginBottom: '10px',
            paddingBottom: '10px',
            borderBottom: '1px solid #e2e8f0'
          }}>
            <span style={{ color: '#4a5568' }}>Page Cost ({order.pages} pages):</span>
            <span style={{ fontWeight: '600', color: '#2d3748' }}>
              ₹{(order.pages * 2).toFixed(2)}
            </span>
          </div>
          
          <div style={{
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center',
            marginBottom: '10px',
            paddingBottom: '10px',
            borderBottom: '1px solid #e2e8f0'
          }}>
            <span style={{ color: '#4a5568' }}>Binding Charge:</span>
            <span style={{ fontWeight: '600', color: '#2d3748' }}>₹50.00</span>
          </div>
          
          <div style={{
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center',
            fontSize: '1.1rem',
            fontWeight: 'bold',
            color: '#2d3748',
            paddingTop: '10px'
          }}>
            <span>Total Amount:</span>
            <span style={{ color: '#667eea', fontSize: '1.25rem' }}>
              ₹{order.total_amount.toFixed(2)}
            </span>
          </div>
        </div>
      </div>

      {/* Back Button */}
      <div style={{ 
        textAlign: 'center', 
        marginTop: '30px' 
      }}>
        <button 
          onClick={() => window.history.back()}
          style={{
            padding: '12px 24px',
            backgroundColor: '#667eea',
            color: 'white',
            border: 'none',
            borderRadius: '8px',
            cursor: 'pointer',
            fontWeight: '600',
            fontSize: '1rem',
            transition: 'background-color 0.2s ease',
            display: 'flex',
            alignItems: 'center',
            gap: '8px',
            margin: '0 auto'
          }}
          onMouseOver={(e) => e.target.style.backgroundColor = '#5a67d8'}
          onMouseOut={(e) => e.target.style.backgroundColor = '#667eea'}
        >
          ← Back to Orders
        </button>
      </div>
    </div>
  );
};

export default CustomWorkbookOrderDetails; 