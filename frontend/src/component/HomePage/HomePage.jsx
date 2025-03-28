import React from 'react'
import Hero from './hero';
 import Footer from '../../Footer';
import Hero1 from './hero1';


function Homepage() {
    return ( 
        <div>
           <Hero1/>
            <Hero/>
            <Footer/>
        </div>
     );
}

export default Homepage;