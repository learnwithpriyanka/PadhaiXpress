import React from 'react'
import Hero from './hero';
 import Footer from '../../Footer';
import Hero1 from './hero1';
import WhyChoose  from './WhyChoose';

function Homepage() {
    return ( 
        <div className="homepage-bg">
           <Hero1/>
            <Hero/>
            <WhyChoose/>
            <Footer/>
        </div>
     );
}

export default Homepage;