import React from "react";
import { Link } from "react-router-dom";
import "./heropage.css";
function Donation(){
    return(
        <div className="donate1">
        <div className="image-container1">
            <img src="/media/image/donate.webp" alt="Donate Book"></img>
        </div>
        <div className="text-container1">
            <p className="tagline1">Recycle in Action</p>
            <h2>Donate Your Books Today</h2>
            <p className="description1">Your used books can find new life through our recycling program. Donate them now and help us reduce waste and support a circular economy.</p>
        </div>
    </div>
    )}
    export default Donation;