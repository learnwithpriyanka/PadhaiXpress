import React,{useContext,useState} from 'react';
import { useCart } from './CartContext';
import { Link, useNavigate } from 'react-router-dom';
import { AuthContext } from '../context/AuthContext'; // Import AuthContext if needed
import './Cart.css'; // Assuming you have a CSS file for styling

const ShoppingCart = () => {
  const { cart, dispatch } = useCart();
  const navigate = useNavigate(); // Initialize useNavigate
  const { isLoggedIn } = useContext(AuthContext); // Get the login status from AuthContext
  const [message, setMessage] = useState('');

  const total = cart.reduce((acc, item) => acc + item.price * item.quantity, 0);

  const handleBuyNow = () => {
    if (!isLoggedIn) {
      setMessage('Please sign in first to continue shopping...');
      setTimeout(() => {
        navigate('/signin', { 
          state: { from: '/cart' }
        });
      }, 4000); // Wait 2 seconds before redirecting
    } else {
      navigate('/orderdetails');
    }
  };

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
              <button onClick={() => dispatch({ type: 'REMOVE', payload: item.id })} className='deletebutton'>Delete</button>
            </div>
          </div>
        </div>
      ))}
      <div className="total">Total:  ₹{total.toFixed(2)}</div>
      {message && (
        <div className="auth-message">
          {message}
        </div>
      )}
      <div className="buttons">
       <button className='continueShopping'> <Link to="/workbook/year1/firstyearoddsem" > Go back to Continue Shopping</Link></button>
        <button className='buynow' onClick={handleBuyNow}>Buy Now</button>
      </div>
    </div>
  );
};

export default ShoppingCart;