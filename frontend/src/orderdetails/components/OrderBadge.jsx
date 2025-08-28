import React from 'react';

const OrderBadge = ({ orderType }) => {
  return (
    <div className={`order-badge ${orderType}`}>
      <div className="badge-icon">
        {orderType === 'custom' ? '📚' : '📖'}
      </div>
      <div className="badge-text">
        {orderType === 'custom' ? 'CUSTOM WORKBOOK' : 'LAB WORKBOOK'}
      </div>
    </div>
  );
};

export default OrderBadge;