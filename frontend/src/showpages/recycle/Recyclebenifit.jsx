import react from 'react';
import "./heropage.css";
function Recyclebenifit(){
    return(
        <div className="recycling-benefits">
        <h2 className="section-title">Recycling Benefits</h2>
        <div className="benefits-container">
            <div className="benefit-card highlight-card">
                <img src="/media/image/logo.webp" alt="Padhai Xpress" className="benefit-icon"></img>
                <p className="benefit-title">Padhai Xpress</p>
            </div>
            <div className="benefit-card">
                <img src="/media/image/reduce-waste.webp" alt="Reduce Waste" className="benefit-icon"></img>
                <p className="benefit-title">Reduce Waste</p>
                <p className="benefit-description">Donate Books</p>
            </div>
            <div className="benefit-card">
                <img src="/media/image/sustainability.webp" alt="Support Sustainability" className="benefit-icon"></img>
                <p className="benefit-title">Support Sustainability</p>
                <p className="benefit-description">Recycle with Us</p>
            </div>
            <div className="benefit-card">
                <img src="/media/image/conserve.webp" alt="Conserve Resources" className="benefit-icon"></img>
                <p className="benefit-title">Conserve Resources</p>
                <p className="benefit-description">Contribute to a Greener Future</p>
            </div>
        </div>
    </div>
    )}
    export default Recyclebenifit;