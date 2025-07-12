import React, { useState } from 'react';
import { useCart } from './CartContext';
import { Link, useNavigate } from 'react-router-dom';
import './Cart.css';

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
    const basePrice = Number(item.product?.price) || 0;
    return item.page_type === "single" ? basePrice * 2 : basePrice;
  };

  const total = cart.reduce((acc, item) =>
    acc + (calculateItemPrice(item) * item.quantity), 0
  );

  const handleBuyNow = () => {
    if (!cart.length) {
      setMessage('Your cart is empty!');
      return;
    }
    navigate('/orderdetails');
  };

  return (
    <div className="cart">
      <h2>Shopping Cart</h2>
      {cart.length === 0 ? (
        <div className="empty-cart">
          <p>Your cart is empty. Start shopping!</p>
        </div>
      ) : (
        cart.map((item) => (
          <div key={item.id} className="cart-item">
            <img src={item.product?.image} alt={item.product?.name} />
            <div>
              <h4>{item.product?.name}</h4>
              <p>Code: {item.product?.code}</p>
              <p>Base Price: ₹{item.product?.price} | Pages: {item.product?.pages}</p>
              <select
                value={item.page_type}
                onChange={(e) => handlePageTypeChange(item.id, e.target.value)}
                className="page-type-select"
              >
                <option value="double">Double Side</option>
                <option value="single">Single Side</option>
              </select>
              <p>Calculated Price: ₹{calculateItemPrice(item)}</p>
              <div className="cart-controls">
                <button 
                  onClick={() => handleQuantityChange(item.id, item.quantity - 1)} 
                  disabled={item.quantity <= 1}
                >
                  -
                </button>
                <span>{item.quantity}</span>
                <button onClick={() => handleQuantityChange(item.id, item.quantity + 1)}>
                  +
                </button>
                <button onClick={() => handleRemove(item.id)} className='deletebutton'>
                  Delete
                </button>
              </div>
            </div>
          </div>
        ))
      )}
      <div className="total">Total: ₹{total.toFixed(2)}</div>
      {message && (
        <div className="auth-message">
          {message}
        </div>
      )}
      <div className="buttons">
        <button className='continueShopping'>
          <Link to="/workbook/year1/firstyearoddsem"> Go back to Continue Shopping</Link>
        </button>
        <button className='buynow' onClick={handleBuyNow}>Buy Now</button>
      </div>
    </div>
  );
};

export default ShoppingCart;