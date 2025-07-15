import React, { useState, useEffect } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import './Order.css';

const OrderSuccess = () => {
  const location = useLocation();
  const navigate = useNavigate();
  // Get real address and orderId from location.state
  const { address, order } = location.state || {};
  const orderId = order?.id ? String(order.id).toUpperCase() : 'N/A';

  const [showSecondaryAnimation, setShowSecondaryAnimation] = useState(false);

  useEffect(() => {
    const timer = setTimeout(() => setShowSecondaryAnimation(true), 800);
    return () => clearTimeout(timer);
  }, []);

  // Enhanced confetti with more variety and colors (reduced for modern look)
  const confetti = Array.from({ length: 16 }, (_, i) => {
    const emojis = ['🎉','✨','🎊','🥳','🌟','💫','🎈','🎁','🏆','💎','🌈','⭐'];
    const colors = ['#ff6b6b', '#4ecdc4', '#45b7d1', '#f9ca24', '#f0932b', '#eb4d4b', '#6c5ce7', '#a29bfe'];
    return (
      <span 
        key={i} 
        style={{ 
          fontSize: Math.random() * 8 + 16, 
          margin: '0 4px', 
          opacity: 0.85,
          color: colors[i % colors.length],
          animation: `confetti-fall ${1.3 + Math.random() * 0.6}s ${i * 0.05}s both`,
          display: 'inline-block',
          transform: `rotate(${Math.random() * 360}deg)`
        }}
      >
        {emojis[i % emojis.length]}
      </span>
    );
  });

  // Floating particles background
  const particles = Array.from({ length: 20 }, (_, i) => (
    <div
      key={i}
      className="particle"
      style={{
        left: `${Math.random() * 100}%`,
        animationDelay: `${Math.random() * 3}s`,
        animationDuration: `${3 + Math.random() * 2}s`
      }}
    />
  ));

  // If no address or order, show fallback message
  if (!address || !order) {
    return (
      <div className="order-success-container">
        <div className="order-success-card">
          <h1 style={{ color: '#dc2626', fontWeight: 700, fontSize: '1.5rem' }}>Order Not Found</h1>
          <p style={{ color: '#6b7280', margin: '1rem 0' }}>Sorry, we couldn't find your order details.</p>
          <button className="primary-button" onClick={() => navigate('/')}>Go to Home</button>
        </div>
      </div>
    );
  }

  return (
    <div
      className="order-success-container"
      style={{
        minHeight: '100vh',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        position: 'relative',
        overflow: 'hidden',
        background: 'linear-gradient(135deg, #fff7ed 0%, #fef3c7 100%)',
        padding: 0,
        fontFamily: "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif"
      }}
    >
      {/* Animated background */}
      <div className="animated-bg">
        {particles}
        <div className="gradient-orb orb-1" />
        <div className="gradient-orb orb-2" />
        <div className="gradient-orb orb-3" />
      </div>

      <div className="order-success-card">
        {/* Enhanced confetti */}
        <div className="confetti-container">
          {confetti}
        </div>

        {/* Main success icon with pulsing effect */}
        <div className="success-icon-container">
          <div className="success-icon">
            <div className="checkmark">✓</div>
          </div>
          <div className="success-rings">
            <div className="ring ring-1" />
            <div className="ring ring-2" />
            <div className="ring ring-3" />
          </div>
        </div>

        {/* Animated title */}
        <h1 className="success-title">
          <span className="title-word" style={{ animationDelay: '0.3s' }}>🎉</span>
          <span className="title-word" style={{ animationDelay: '0.4s' }}>Order</span>
          <span className="title-word" style={{ animationDelay: '0.5s' }}>Placed</span>
          <span className="title-word" style={{ animationDelay: '0.6s' }}>Successfully!</span>
        </h1>

        {/* Enhanced description */}
        <div className={`success-message ${showSecondaryAnimation ? 'show' : ''}`}>
          <p className="main-message">
            Your order is confirmed and will be delivered soon! 🚚
          </p>
          <p className="sub-message">
            Thank you for choosing <span className="brand-highlight">PadhaiXpress</span> -
            your trusted learning partner! 📚✨
          </p>
        </div>

        {/* Enhanced address card */}
        <div className={`address-card ${showSecondaryAnimation ? 'show' : ''}`}>
          <div className="address-header">
            <span className="address-icon">📍</span>
            <strong>Delivery Address</strong>
          </div>
          <div className="address-content">
            <pre>{address}</pre>
          </div>
        </div>

        {/* Action buttons with hover effects */}
        <div className={`action-buttons ${showSecondaryAnimation ? 'show' : ''}`}>
          <button 
            className="primary-button"
            onClick={() => navigate('/orders')}
          >
            <span className="button-icon">📋</span>
            View My Orders
            <div className="button-shine" />
          </button>
          <button 
            className="secondary-button"
            onClick={() => navigate('/workbook')}
          >
            <span className="button-icon">🛍️</span>
            Continue Shopping
          </button>
        </div>

        {/* Enhanced footer */}
        <div className={`footer-content ${showSecondaryAnimation ? 'show' : ''}`}>
          <div className="support-text">
            <span>Need help? </span>
            <a href="/contact" className="support-link">Contact Support 💬</a>
          </div>
          <div className="order-number">
            Order #{orderId}
          </div>
        </div>
      </div>
      {/* Animations and responsive styles are already included in the style tag */}
    </div>
  );
};

export default OrderSuccess;