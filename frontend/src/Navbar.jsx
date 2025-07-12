import React, {useContext,useState,useRef,useEffect} from 'react'
import './index.css'

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
    <nav className="navbar navbar-expand-lg border-bottom" style={{ background: 'white', color: 'black' }}>
      <div className="container p-2">
        <Link className="navbar-brand" to="/" state={{ color: "black" }}>
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
          className="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span className="navbar-toggler-icon" style={{ color: 'black' }}></span>
        </button>
        <div className="collapse navbar-collapse" id="navbarSupportedContent">
          <form className="d-flex" role="search">
            <ul className="navbar-nav me-auto mb-2 mb-lg-0">
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
                    <i className="fa-solid fa-user" style={{ background: "#f3f4f6", width: "33px", height: "33px", borderRadius: "50%", alignItems: "center", fontSize: "24px", color: 'black' }}></i> {/* Profile Icon */}
                  </button>
                  {showDropdown && (
                    <ul className="dropdown-menu">
                      {userRole === 'admin' && (
                        <li>
                          <Link className="dropdown-item" to="/admin-dashboard" style={{ color: 'black' }}>
                            Admin Dashboard
                          </Link>
                        </li>
                      )}
                      {userRole === 'printer' && (
                        <li>
                          <Link className="dropdown-item" to="/printer-dashboard" style={{ color: 'black' }}>
                            Printer Dashboard
                          </Link>
                        </li>
                      )}
                      <li>
                        <Link className="dropdown-item" to="/profile" style={{ color: 'black' }}>
                          Profile
                        </Link>
                      </li>
                      <li>
                        <Link className="dropdown-item" to="/orders" style={{ color: 'black' }}>
                          Order History
                        </Link>
                      </li>
                      <li>
                        <button className="dropdown-item" onClick={logout} style={{ color: 'black' }}>
                          Logout
                        </button>
                      </li>
                    </ul>
                  )}
                </li>
              )}
              <li className="nav-item" >
                <Link className="nav-link active" to="cart" style={{ color: "yellow" }}>
                  Cart ({totalItems})
                </Link>
              </li>
            </ul>
          </form>
        </div>
      </div>
    </nav>
  );
}

export default Navbar;