import React from 'react'
import ContactMe from './ContactMe'
import Footer from '../../Footer'   
import './Contact.css'


function ContactPage() {
    return (  
        <div className="contact-page">
            <ContactMe/>
            <Footer/>
        </div>
    );
}

export default ContactPage;