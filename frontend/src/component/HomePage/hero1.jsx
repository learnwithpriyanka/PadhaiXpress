// import React from 'react'

// function Hero1() {
//     return ( 
//         <div className='hd'>
//            <img src='media/image/frontImage.jpg' style={{width:"100vw",height:"70vh"}} alt='img' className='hero-img'></img>
            
        
//         </div>
//      );
// }

// export default Hero1;
import React from 'react';
import { ArrowRight, ShoppingBag, Recycle, FileText } from 'lucide-react';
import './Hero1.css';
import { useNavigate } from 'react-router-dom';

const Hero1 = () => {
  const navigate = useNavigate();
  return (
    <section className="hero-section">
      <div className="hero-container">
        <div className="hero-grid">
          {/* Content */}
          <div className="hero-content">
            <div className="hero-text">
              <h1 className="hero-title">
                Buy, Print & 
                <span className="hero-title-accent">Recycle</span>
                Educational Materials
              </h1>
              <p className="hero-description">
                Your one-stop marketplace for workbooks, print-ready PDFs, and eco-friendly book recycling. Quality education materials at affordable prices.
              </p>
            </div>

            {/* Quick Actions */}
            <div className="hero-actions">
              <div className="action-card" onClick={() => navigate('/workbook')} style={{ cursor: 'pointer' }}>
                <ShoppingBag className="action-icon action-icon-blue" />
                <div className="action-text">Buy Workbooks</div>
              </div>
              <div className="action-card" onClick={() => navigate('/project')} style={{ cursor: 'pointer' }}>
                <FileText className="action-icon action-icon-green" />
                <div className="action-text">Print PDFs</div>
              </div>
              <div className="action-card" onClick={() => navigate('/recycle')} style={{ cursor: 'pointer' }}>
                <Recycle className="action-icon action-icon-orange" />
                <div className="action-text">Recycle Books</div>
              </div>
            </div>

            {/* CTA Button */}
            <div className="hero-cta">
              <button className="cta-button" onClick={() => navigate('/workbook')}>
                Start Shopping
                <ArrowRight className="cta-arrow" />
              </button>
            </div>
          </div>

          {/* Hero Image */}
          <div className="hero-image-container">
            <img
              src="https://images.pexels.com/photos/159711/books-bookstore-book-reading-159711.jpeg?auto=compress&cs=tinysrgb&w=800"
              alt="Educational books and materials"
              className="hero-image"
            />
            {/* Floating Stats */}
            <div className="floating-stat floating-stat-left">
              <div className="stat-number">500+</div>
              <div className="stat-label">Workbooks</div>
            </div>
            <div className="floating-stat floating-stat-right">
              <div className="stat-number">Eco</div>
              <div className="stat-label">Friendly</div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default Hero1;