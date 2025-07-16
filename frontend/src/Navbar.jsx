import React, {useContext,useState,useRef,useEffect} from 'react'
import './index.css'
import './Navbar.css'; // Add a new CSS file for modern responsive styles

import { Link } from "react-router-dom";
import { useCart } from './cartcomponent/CartContext';
import { AuthContext } from './context/AuthContext';
import { supabase } from './supabaseClient';

function Navbar() {
  const { isLoggedIn, logout } = useContext(AuthContext);
  const [showDropdown, setShowDropdown] = useState(false);
  const dropdownRef = useRef(null); // Ref for the dropdown menu
  const { cart } = useCart();
  const totalItems = cart.reduce((acc, item) => acc + item.quantity, 0);
  const [userRole, setUserRole] = useState('');

  
  const toggleDropdown = (e) => {
   
    e.preventDefault(); // Prevent default action of the button
    setShowDropdown((prev) => !prev); // Toggle the dropdown menu
  };

  const handleClickOutside = (e) => {
    if (dropdownRef.current && !dropdownRef.current.contains(e.target)) {
      setShowDropdown(false); // Close the dropdown if clicked outside
    }
  };

  useEffect(() => {
    document.addEventListener("click", handleClickOutside);
    return () => {
      document.removeEventListener("click", handleClickOutside);
    };
  }, []);

  useEffect(() => {
    const fetchUserRole = async () => {
      try {
        const { data: { user } } = await supabase.auth.getUser();
        if (!user) return;
        const { data, error } = await supabase
          .from('users')
          .select('role')
          .eq('id', user.id)
          .single();
        if (!error && data && data.role) {
          setUserRole(data.role);
        }
      } catch (err) {
        // Ignore errors for now
      }
    };
    if (isLoggedIn) {
      fetchUserRole();
    } else {
      setUserRole('');
    }
  }, [isLoggedIn]);


  return (
    <nav className="navbar-modern">
      <div className="navbar-container">
        <Link className="navbar-brand-modern" to="/" state={{ color: "black" }}>
          <div className='px' style={{ display: 'flex', color: 'black', fontSize: '30px', fontWeight: 'bold', marginLeft: '-50px' }}>
            <div className='px4' style={{ width: "70px", height: "20px", borderColor: "black", borderRadius: "50%" }}>
              <h3 style={{ backgroundColor: "green", padding: "10px", marginRight: "15px", borderRadius: "50%", fontWeight: "800", color: 'white' }}>PX</h3>
            </div>
            <div>
              <h3 className='px2 ' style={{ marginTop: "10px", color: 'black' }}>PadhaiXpress</h3>
            </div>
          </div>
        </Link>
        <button
          className="navbar-toggle-modern"
          type="button"
          aria-label="Toggle navigation"
          onClick={() => setShowDropdown((prev) => !prev)}
        >
          <span className="navbar-toggle-icon" />
        </button>
        <div className={`navbar-links-modern${showDropdown ? ' open' : ''}`}>
          <ul className="navbar-list-modern">
            <li className="nav-item ">
              <Link className="nav-link active" to="/" style={{ color: 'black' }}>
                Home
              </Link>
            </li>
            <li className="nav-item">
              <Link className="nav-link active" aria-current="page" to="about" state={{ color: "black" }} style={{ color: 'black' }}>
                About us
              </Link>
            </li>
            <li className="nav-item ">
              <Link className="nav-link active" to="contact" style={{ color: 'black' }}>
                Contact
              </Link>
            </li>
            {!isLoggedIn && (
              <li className="nav-item">
                <Link className="nav-link active" to="signup" style={{ color: 'black' }}>
                  Signup
                </Link>
              </li>
            )}
            {!isLoggedIn && (
              <li className="nav-item">
                <Link className="nav-link active" to="signin" style={{ color: 'black' }}>
                  SignIn
                </Link>
              </li>
            )}
            {isLoggedIn && (
              <li className="nav-item dropdown" ref={dropdownRef}>
                <button
                  className="nav-link active dropdown-toggle"
                  onClick={toggleDropdown}
                  style={{ color: 'black', background: 'transparent' }}
                >
                  <div className="profile-icon-container">
                    <i className="fa-solid fa-user profile-icon"></i>
                  </div> {/* Profile Icon */}
                </button>
                {showDropdown && (
                  <div className="modern-dropdown-menu">
                    <div className="dropdown-header">
                      <div className="user-info">
                        <div className="user-avatar">
                          <i className="fa-solid fa-user"></i>
                        </div>
                        <div className="user-details">
                          <span className="user-role">{userRole === 'admin' ? 'Administrator' : userRole === 'printer' ? 'Printer' : 'Student'}</span>
                          <span className="user-status">Online</span>
                        </div>
                      </div>
                    </div>
                    
                    <div className="dropdown-divider"></div>
                    
                    <div className="dropdown-items">
                      {userRole === 'admin' && (
                        <Link className="dropdown-item-modern" to="/admin-dashboard">
                          <i className="fa-solid fa-chart-line"></i>
                          <span>Admin Dashboard</span>
                        </Link>
                      )}
                      {userRole === 'printer' && (
                        <Link className="dropdown-item-modern" to="/printer-dashboard">
                          <i className="fa-solid fa-print"></i>
                          <span>Printer Dashboard</span>
                        </Link>
                      )}
                      <Link className="dropdown-item-modern" to="/profile">
                        <i className="fa-solid fa-user-circle"></i>
                        <span>Profile</span>
                      </Link>
                      <Link className="dropdown-item-modern" to="/orders">
                        <i className="fa-solid fa-history"></i>
                        <span>Order History</span>
                      </Link>
                      <li className="nav-item ">
                        <Link className="nav-link active" to="/cancellation" style={{ color: 'black' }}>
                          Cancellation & Refund Policy
                        </Link>
                      </li>
                    </div>
                    
                    <div className="dropdown-divider"></div>
                    
                    <button className="dropdown-item-modern logout-item" onClick={logout}>
                      <i className="fa-solid fa-sign-out-alt"></i>
                      <span>Logout</span>
                    </button>
                  </div>
                )}
              </li>
            )}
            <li className="nav-item" >
              <Link className="nav-link active cart-link" to="cart">
                <div className="cart-icon-container">
                  <i className="fa-solid fa-shopping-cart cart-icon"></i>
                  <span className="cart-count">{totalItems}</span>
                </div>
              </Link>
            </li>
          </ul>
        </div>
      </div>
    </nav>
  );
}

export default Navbar;