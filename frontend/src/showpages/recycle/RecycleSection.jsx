import React from "react";
import "./RecycleSection.css";

function RecycleSection() {
    return (
        <>
        <div className="recycle-container">
            <div className="recycle-card">
                <img src="/media/image/recycle.jpg" alt="Recycle with Us" />
                <h3 className="recycle-title">Recycle with Us</h3>
                <p className="recycle-text">Donate your used books and help reduce waste. We'll handle the rest.</p>
                <button className="recycle-btn" type="button">Donate Now</button>
            </div>

            <div className="recycle-card">
                <img src="/media/image/Eco-friendly.webp" alt="Eco-friendly" />
                <h3 className="recycle-title">Eco-friendly</h3>
                <p className="recycle-text">Discover how our recycling program benefits the environment and community.</p>
                <button className="recycle-btn" type="button">Get Involved</button>
            </div>

            <div className="recycle-card">
                <img src="/media/image/sustainable.png" alt="Sustainable Solutions" />
                <h3 className="recycle-title">Sustainable Solutions</h3>
                <p className="recycle-text">Our recycling services provide an easy way for you to contribute to a greener future.</p>
                <button className="recycle-btn" type="button">Recycle Now</button>
            </div>

            <div className="recycle-card">
                <img src="/media/image/recycle.jpg" alt="Simple Steps to Recycle" />
                <h3 className="recycle-title">Simple Steps to Recycle</h3>
                <p className="recycle-text">Follow our step-by-step guide to learn how you can participate in our book recycling program.</p>
                <button className="recycle-btn" type="button">Explore the Process</button>
            </div>

            
        </div>

<div className="recycle-header">
<h3>Recycling Made Easy</h3>
<p>At Padhaixpress, we believe in making a difference. Our book recycling initiative is just one way we're working to create a more sustainable future.</p>
</div>

</>
    );
}

export default RecycleSection;
