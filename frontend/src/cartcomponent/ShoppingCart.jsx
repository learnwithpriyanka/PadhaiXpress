import React, { useState } from 'react';
import { useCart } from './CartContext';
import { Link, useNavigate } from 'react-router-dom';
import './Shoppingcart.css'; // Your new modern CSS file

const ShoppingCart = () => {
  const { cart, updateCartItem, removeFromCart } = useCart();
  const navigate = useNavigate();
  const [message, setMessage] = useState('');

  const handlePageTypeChange = (itemId, pageType) => {
    updateCartItem(itemId, { page_type: pageType });
  };

  const handleQuantityChange = (itemId, quantity) => {
    if (quantity < 1) return; // Prevent negative quantities
    updateCartItem(itemId, { quantity });
  };

  const handleRemove = (itemId) => {
    removeFromCart(itemId);
  };

  const calculateItemPrice = (item) => {
    const perPagePrice = Number(item.product?.per_page_price) || 0;
    const pages = Number(item.product?.pages) || 0;
    const doublePrice = perPagePrice * pages;
    if (item.page_type === 'single') {
      return ((doublePrice * 1.1)+ 60).toFixed(2);
    }
    return ((doublePrice*0.66)+60).toFixed(2);
  };

  const total = cart.reduce((acc, item) =>
    acc + (calculateItemPrice(item) * item.quantity), 0
  );

  const deliveryCharge = total > 500 ? 0 : 40
  0;

  const handleBuyNow = () => {
    if (!cart.length) {
      setMessage('Your cart is empty!');
      return;
    }
    navigate('/orderdetails');
  };

  return (
    <div className="cart">
      <div className="cart-container">
        {/* Header */}
        <div className="cart-header">
          <div className="cart-header-left">
            <div className="cart-icon-wrapper">
              <svg className="cart-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
              </svg>
            </div>
            <h2>Shopping Cart</h2>
          </div>
          <div className="cart-count">
            <svg className="cart-count-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 3h2l.4 2M7 13h10l4-8H5.4m0 0L7 13m0 0l-2.5 5M7 13l2.5 5m6-5v5a2 2 0 01-2 2H9a2 2 0 01-2-2v-5m6-5V6a2 2 0 00-2-2H9a2 2 0 00-2 2v2" />
            </svg>
            <span>{cart.length} item{cart.length !== 1 ? 's' : ''}</span>
          </div>
        </div>

        {cart.length === 0 ? (
          <div className="empty-cart">
            <div className="empty-cart-icon">
              <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
              </svg>
            </div>
            <h3>Your cart is empty</h3>
            <p>Start shopping to add items to your cart!</p>
            <button className="continueShopping">
              <Link to="/workbook">
                <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                </svg>
                Continue Shopping
              </Link>
            </button>
          </div>
        ) : (
          <>
            {/* Cart Items */}
            <div className="cart-items">
              {cart.map((item) => (
                <div key={item.id} className="cart-item">
                  <div className="cart-item-content ">
                    <img src={item.product?.images} alt={item.product?.name} />
                    
                    <div className="cart-item-details">
                      <h4>{item.product?.name}</h4>
                      
                      <div className="cart-item-info">
                        <p>Code: {item.product?.code}</p>
                        <p>Pages: {item.product?.pages}</p>
                      </div>

                      <div className="page-type-section">
                        <label className="page-type-label">Print Type:</label>
                        <select
                          value={item.page_type}
                          onChange={(e) => handlePageTypeChange(item.id, e.target.value)}
                          className="page-type-select"
                        >
                          <option value="double">Double Side</option>
                          <option value="single">Single Side</option>
                        </select>
                      </div>

                      <div className="cart-item-bottom">
                        <div className="item-price">
                          <div className="item-price-amount">₹{calculateItemPrice(item)}</div>
                          <div className="item-price-label">per item</div>
                        </div>

                        <div className="cart-controls">
                          <div className="quantity-controls">
                            <button
                              className="quantity-btn"
                              onClick={() => handleQuantityChange(item.id, item.quantity - 1)}
                              disabled={item.quantity <= 1}
                            >
                              <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M20 12H4" />
                              </svg>
                            </button>
                            <span className="quantity-display">{item.quantity}</span>
                            <button
                              className="quantity-btn"
                              onClick={() => handleQuantityChange(item.id, item.quantity + 1)}
                            >
                              <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
                              </svg>
                            </button>
                          </div>

                          <button
                            className="deletebutton"
                            onClick={() => handleRemove(item.id)}
                            title="Remove item"
                          >
                            <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                            </svg>
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              ))}
            </div>

            {/* Order Summary */}
            <div className="order-summary">
              <h3>Order Summary</h3>
              
              <div className="summary-details">
                <div className="summary-row">
                  <span>Subtotal</span>
                  <span>₹{total.toFixed(2)}</span>
                </div>
                <div className="summary-row">
                  <span>Delivery</span>
                  <span className={deliveryCharge === 0 ? 'free-delivery' : ''}>
                    {deliveryCharge === 0 ? 'Free' : `₹${deliveryCharge}`}
                  </span>
                </div>
                <div className="summary-row total">
                  <span>Total</span>
                  <span>₹{(total + deliveryCharge).toFixed(2)}</span>
                </div>
              </div>

              {deliveryCharge > 0 && (
                <div className="delivery-incentive">
                  <p>Add ₹{(500 - total).toFixed(2)} more to get free delivery!</p>
                </div>
              )}

              {message && (
                <div className="auth-message">
                  <p>{message}</p>
                </div>
              )}

              <div className="buttons">
                <button className="continueShopping">
                  <Link to="/workbook">
                    <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                    </svg>
                    Continue Shopping
                  </Link>
                </button>
                <button className="buynow" onClick={handleBuyNow}>
                  Proceed to Checkout
                </button>
              </div>
            </div>
          </>
        )}
      </div>
    </div>
  );
};

export default ShoppingCart;