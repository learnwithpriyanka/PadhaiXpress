import React from 'react';
import { useCart } from './CartContext';
import { Link } from 'react-router-dom';
import './Cart.css'; // Assuming you have a CSS file for styling

const ShoppingCart = () => {
  const { cart, dispatch } = useCart();

  const total = cart.reduce((acc, item) => acc + item.price * item.quantity, 0);

  return (
    <div className="cart">
      <h2>Shopping Cart</h2>
      {cart.map((item) => (
        <div key={item.id} className="cart-item">
          <img src={item.image} alt={item.name} />
          <div>
            <h4>{item.name}</h4>
            <p> ₹{item.price}</p>
            <div className="cart-controls">
              <button onClick={() => dispatch({ type: 'DECREASE', payload: item.id })}>-</button>
              <span>{item.quantity}</span>
              <button onClick={() => dispatch({ type: 'INCREASE', payload: item.id })}>+</button>
              <button onClick={() => dispatch({ type: 'REMOVE', payload: item.id })}>Delete</button>
            </div>
          </div>
        </div>
      ))}
      <div className="total">Total:  ₹{total.toFixed(2)}</div>
      <div className="buttons">
       <button className='continueShopping'> <Link to="/workbook/year1/firstyearoddsem" > Go back to Continue Shopping</Link></button>
        <button className='buynow'>Buy Now</button>
      </div>
    </div>
  );
};

export default ShoppingCart;