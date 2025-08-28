import React from 'react';

const OrderActions = ({ order, onViewDetails, onPayNow, loading }) => {
  return (
    <div className="order-actions">
      <button 
        onClick={() => onViewDetails(order)} 
        className={`view-details-btn ${order.orderType}`}
      >
        <span className="btn-icon">👁️</span>
        <span className="btn-text">View Details</span>
      </button>
      
      {/* Pay Now Button for COD Orders (only for regular orders) */}
      {order.orderType === 'regular' && order.payment_method === 'cod' && order.status !== 'delivered' && (
        <button
          className="pay-now-btn"
          onClick={() => onPayNow(order)}
          disabled={loading[order.id]}
        >
          <span className="btn-icon">💳</span>
          <span className="btn-text">{loading[order.id] ? 'Processing...' : 'Pay Now'}</span>
        </button>
      )}
    </div>
  );
};

export default OrderActions;