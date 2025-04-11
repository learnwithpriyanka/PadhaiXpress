import React, {useContext,useState,useRef,useEffect} from 'react'
import './index.css'

import { Link } from "react-router-dom";
import { useCart } from './cartcomponent/CartContext';
import { AuthContext } from './context/AuthContext';

function Navbar() {
  const { isLoggedIn, logout } = useContext(AuthContext);
  const [showDropdown, setShowDropdown] = useState(false);
  const dropdownRef = useRef(null); // Ref for the dropdown menu
  const { cart } = useCart();
  const totalItems = cart.reduce((acc, item) => acc + item.quantity, 0);

  
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




  return (
    <nav class="navbar navbar-expand-lg border-bottom " >
      <div class="container p-2">
        <Link class="navbar-brand" to="/" state={{ color: "white" }}>
          {/* <a href='#'><img src='media/image/newlogo.png' alt='logo' className='img' style={{width:"20%"}}></img></a> */}
          <div className='px' style={{ display: 'flex', color: 'white', fontSize: '30px', fontWeight: 'bold', marginLeft: '-50px' }}>
            <div className='px4' style={{ width: "70px", height: "20px", borderColor: "white", borderRadius: "50%", }}>
              <h3 style={{ backgroundColor: "green", padding: "10px", marginRight: "15px", borderRadius: "50%", fontWeight: "800" }}>PX</h3>

            </div>
            <div>

              <h3 className='px2 ' style={{ marginTop: "10px" }}>PadhaiXpress</h3>
            </div>
          </div>
        </Link>
        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">

          <form class="d-flex" role="search">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
              <li class="nav-item ">
                <Link class="nav-link active" to="/">
                  Home
                </Link>
              </li>
              <li class="nav-item">
                <Link class="nav-link active" aria-current="page" to="about" state={{ color: "white" }} >
                  About us
                </Link>
              </li>
              <li class="nav-item ">
                <Link class="nav-link active" to="contact" >
                  Contact
                </Link>
              </li>
              {!isLoggedIn && (

                <li class="nav-item">

                  <Link class="nav-link active" to="signup">
                    Signup
                  </Link>
                </li>

              )}

              {!isLoggedIn && (
                <li class="nav-item">

                  <Link class="nav-link active" to="signin">
                    SignIn
                  </Link>
                </li>
              )}
              

{isLoggedIn && (
              <li className="nav-item dropdown"  ref={dropdownRef}> 
                <button
                  className="nav-link active dropdown-toggle"
                  onClick={toggleDropdown}
                >
                  <i className="fas fa-user-circle"></i> {/* Profile Icon */}
                </button>
                {showDropdown && (
                  <ul className="dropdown-menu">
                    <li>
                      <Link className="dropdown-item" to="/profile">
                        Profile
                      </Link>
                    </li>
                    <li>
                      <Link className="dropdown-item" to="/orders">
                        Orders
                      </Link>
                    </li>
                    <li>
                      <Link className="dropdown-item" to="/favourites">
                        Favourites
                      </Link>
                    </li>
                    <li>
                      <button className="dropdown-item" onClick={logout}>
                        Logout
                      </button>
                    </li>
                  </ul>
                )}
                </li>
              )}
              <li class="nav-item">
                <Link class="nav-link active" to="cart">
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