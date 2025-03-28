import react from 'react';
import "./heropage.css";
function Recyclebenifit(){
    return(
        <div class="recycling-benefits">
        <h2 class="section-title">Recycling Benefits</h2>
        <div class="benefits-container">
            <div class="benefit-card highlight-card">
                <img src="/media/image/logo.webp" alt="Padhai Xpress" class="benefit-icon"></img>
                <p class="benefit-title">Padhai Xpress</p>
            </div>
            <div class="benefit-card">
                <img src="/media/image/reduce-waste.webp" alt="Reduce Waste" class="benefit-icon"></img>
                <p class="benefit-title">Reduce Waste</p>
                <p class="benefit-description">Donate Books</p>
            </div>
            <div class="benefit-card">
                <img src="/media/image/sustainability.webp" alt="Support Sustainability" class="benefit-icon"></img>
                <p class="benefit-title">Support Sustainability</p>
                <p class="benefit-description">Recycle with Us</p>
            </div>
            <div class="benefit-card">
                <img src="/media/image/conserve.webp" alt="Conserve Resources" class="benefit-icon"></img>
                <p class="benefit-title">Conserve Resources</p>
                <p class="benefit-description">Contribute to a Greener Future</p>
            </div>
        </div>
    </div>
    )}
    export default Recyclebenifit;