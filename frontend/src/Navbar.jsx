import React from 'react'
import './index.css'

 import { Link } from "react-router-dom";

function Navbar() {
    return (  
        <nav class="navbar navbar-expand-lg border-bottom " >
        <div class="container p-2">
          <Link class="navbar-brand" to="/">
          <a href='#'><img src='media/image/newlogo.png' alt='logo' className='img' style={{width:"20%"}}></img></a>
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
                <Link class="nav-link active" aria-current="page" to="about" state={{color:"white"}} >
                  About us
                </Link>
              </li>
              <li class="nav-item ">
                <Link class="nav-link active" to="contact" >
                  Contact
                </Link>
              </li>
              <li class="nav-item">
                <Link class="nav-link active" to="signin">
                  SignIn
                </Link>
              </li>
              <li class="nav-item">
                <Link class="nav-link active" to="signup">
                  Signup
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