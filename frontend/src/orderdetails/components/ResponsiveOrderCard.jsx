import React from 'react';
import OrderBadge from './OrderBadge';
import OrderInfo from './OrderInfo';
import OrderActions from './OrderActions';
import OrderStatusProgressBar from '../../component/OrderStatusProgressBar';

const ResponsiveOrderCard = ({ 
  order, 
  onViewDetails, 
  onPayNow, 
  loading, 
  getPaymentStatusText, 
  getPaymentStatusColor 
}) => {
  return (
    <div className="responsive-order-card">
      <div className="card-header">
        <OrderBadge orderType={order.orderType} />
      </div>
      
      <div className="card-content">
        <div className="content-main">
          <OrderInfo 
            order={order}
            getPaymentStatusText={getPaymentStatusText}
            getPaymentStatusColor={getPaymentStatusColor}
          />
          <OrderActions 
            order={order}
            onViewDetails={onViewDetails}
            onPayNow={onPayNow}
            loading={loading}
          />
        </div>
        
        <div className="content-progress">
          <div className="progress-wrapper">
            <h4 className="progress-title">Order Progress</h4>
            <OrderStatusProgressBar status={order.status} />
          </div>
        </div>
      </div>
      
      {/* Custom Order Summary */}
      {order.orderType === 'custom' && (
        <div className="custom-summary">
          <h4 className="summary-title">📋 Order Summary</h4>
          <div className="summary-grid">
            <div className="summary-item">
              <strong>Customer:</strong> {order.delivery_name}
            </div>
            <div className="summary-item">
              <strong>Phone:</strong> {order.phone}
            </div>
            <div className="summary-item">
              <strong>Address:</strong> {order.address}
            </div>
            {order.landmark && (
              <div className="summary-item">
                <strong>Landmark:</strong> {order.landmark}
              </div>
            )}
            <div className="summary-item">
              <strong>Pincode:</strong> {order.pincode}
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default ResponsiveOrderCard;