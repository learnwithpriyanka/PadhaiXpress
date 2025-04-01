import React from 'react'
import './index.css'

function Footer() {
    return (
        <footer>
            <div className='cont'>
                <div className="logo">
                    <a href='#'><img src='media/image/newlogo.png' alt='logo' className='img'></img></a>
                    <p id='slogan'>Your One-Stop Hub for Study Materials!</p>
                </div>
                <div className='so'>
                    <h4>Connect with us</h4>
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
                <div >
                    <h4 className='head'>Company</h4>
                    <div className="company">

                        <p> <a href='#'>about</a></p>
                        <p> <a href='#'>signup</a></p>
                        <p> <a href='#'>contact</a></p>

                    </div>
                </div>


                <div className='support'></div>



            </div>
        </footer>
    );
}

export default Footer;