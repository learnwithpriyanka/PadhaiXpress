// src/component/OrderStatusProgressBar.jsx

import React from 'react';

import './OrderStatusProgressBar.css';



const statusSteps = [

  { key: 'placed', label: 'Placed' },

  { key: 'printed', label: 'Printed' },

  { key: 'out-for-delivery', label: 'Out for Delivery' },

  { key: 'delivered', label: 'Delivered' }

];



const OrderStatusProgressBar = ({ status }) => {

  const currentStep = statusSteps.findIndex(step => step.key === status);



  return (

    <div className="order-status-progress-bar">

      {statusSteps.map((step, idx) => (

        <div key={step.key} className="step-container">

          <div className={`step-circle ${idx <= currentStep ? 'active' : ''}`}>

            {idx + 1}

          </div>

          <div className="step-label">{step.label}</div>

          {idx < statusSteps.length - 1 && (

            <div className={`step-line ${idx < currentStep ? 'active' : ''}`}></div>

          )}

        </div>

      ))}

    </div>

  );

};



export default OrderStatusProgressBar;