import React from 'react';

const OrderInfo = ({ order, getPaymentStatusText, getPaymentStatusColor }) => {
  const getBackgroundColor = (color) => {
    if (color === '#f59e0b') return '#fef3c7';
    if (color === '#10b981') return '#d1fae5';
    return '#f3f4f6';
  };

  const statusColor = getPaymentStatusColor(order);

  return (
    <div className="order-info">
      <div className="order-details">
        <h3 className="order-id">Order ID: #{order.id}</h3>
        <div className="order-meta">
          <div className="meta-item">
            <span className="meta-icon">📅</span>
            <span className="meta-text">Date: {new Date(order.displayDate).toLocaleDateString()}</span>
          </div>
          <div className="meta-item">
            <span className="meta-icon">💰</span>
            <span className="meta-text">Total: ₹{order.displayTotal.toFixed(2)}</span>
          </div>
          <div className="meta-item">
            <span className="meta-icon">📊</span>
            <span className="meta-text">Status: {order.status.replace('_', ' ').toUpperCase()}</span>
          </div>
          {order.orderType === 'regular' && order.delivery_time && (
            <div className="meta-item">
              <span className="meta-icon">🚚</span>
              <span className="meta-text">Delivery By: {new Date(order.delivery_time).toLocaleString()}</span>
            </div>
          )}
          {order.orderType === 'custom' && (
            <div className="meta-item">
              <span className="meta-icon">📄</span>
              <span className="meta-text">Pages: {order.pages}</span>
            </div>
          )}
        </div>
        <div 
          className="payment-status" 
          style={{ 
            color: statusColor, 
            backgroundColor: getBackgroundColor(statusColor)
          }}
        >
          {getPaymentStatusText(order)}
        </div>
      </div>
    </div>
  );
};

export default OrderInfo;