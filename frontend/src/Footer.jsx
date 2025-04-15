import React from 'react'
import './index.css'
import { Link } from 'react-router-dom';

function Footer() {
    return (
        <footer>
            <div className='cont'>
            
            <div className="logo">
                    <Link className="navbar-brand" to="/">
                        <div className='px' style={{ display: 'flex', color: 'white', fontSize: '30px', fontWeight: 'bold' }}>
                            <div className='px4'>
                                <h3 style={{ backgroundColor: "green", padding: "10px", marginRight: "15px", borderRadius: "50%", fontWeight: "800" }}>PX</h3>
                            </div>
                            <div>
                                <h3 className='px2' style={{ marginTop: "10px" }}>PadhaiXpress</h3>
                            </div>
                        </div>
                    </Link>
                    <p id='slogan'>Your One-Stop Hub for Study Materials!</p>
                </div>
                <div className='so'>
                    <h4 className='head'>Connect with us</h4>
                    <div className="social">
                        <a href='#' >facebook<i class="fa-brands fa-facebook"></i></a>
                        <br></br>
                        <a href='#'>instagram<i class="fa-brands fa-instagram"></i></a>
                        <br></br>
                        <a href='#'>twitter<i class="fa-brands fa-square-twitter"></i></a>
                        <br></br>
                        <a href='#'>whatsapp<i class="fa-brands fa-whatsapp"></i></a>
                        <br></br>

                    </div>
                </div>
                <div className='company-section'>
                    <h4 className='head'>Company</h4>
                    <div className="company">
                        <p><Link to="/about">About</Link></p>
                        <p><Link to="/signup">Sign Up</Link></p>
                        <p><Link to="/contact">Contact</Link></p>
                    </div>
                </div>


                <div className='support'></div>



            </div>
        </footer>
    );
}

export default Footer;