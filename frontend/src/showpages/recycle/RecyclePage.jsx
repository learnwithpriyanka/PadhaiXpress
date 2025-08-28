import React from 'react';
import { Link } from 'react-router-dom';
import { FaRecycle, FaArrowRight } from 'react-icons/fa';
import Footer from '../../Footer';
import Card1 from './RecycleSection';
import Sustainable from './Sustainable';
import Donation from './Donation';
import Recyclebenifit from './Recyclebenifit';
import ProHero from '../project/ProHero';
import './RecyclePage.css';

function RecycleaPage() {
    return ( 
        <>
            <ProHero/>
            
            {/* Waste Collection CTA Section */}
            {/* <div className="waste-collection-cta">
                <div className="cta-content">
                    <div className="cta-icon">
                        <FaRecycle />
                    </div>
                    <div className="cta-text">
                        <h2>Turn Your Waste Paper Into Wealth</h2>
                        <p>Get instant price estimates and schedule doorstep collection with our AI-powered service</p>
                        <Link to="/waste-collection" className="cta-button">
                            Start Collection Request
                            <FaArrowRight />
                        </Link>
                    </div>
                </div>
            </div> */}
            
            {/* <Card1/>
            
            <Sustainable/>
            <Recyclebenifit/> */}
            <Footer/>
        </>
     );
}

export default RecycleaPage;