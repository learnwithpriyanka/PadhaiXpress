import React from "react";
import "./contact.css";
import MapComponent from "./MapComponent";

const ContactPage = () => {
  return (
    <>
    <div className="c">
    <div className="contac">  
      <div className="image">
       <h1 style={{fontSize:"60px"}}>Get in touch</h1>
       <p   style={{fontSize:"30px"}}>Have questions? We'd love to hear from you.</p>
      </div>
      <div className="row p-5">
      <div className="card1 col-3 p-">
        <i class="fa fa-map-marker p-5 mt-1 " aria-hidden="true" style={{fontSize:"80px",color:"#2D5F9A",marginLeft:"30px"}}></i>
        <h4>Our location</h4>
        </div>
        <div className="card1 col-3 p-5">
        <i class="fa fa-phone-square mt-1" aria-hidden="true" style={{fontSize:"80px",color:"#2D5F9A",marginLeft:"30px"}}></i>
        <h4>Contact us</h4>
        <p>+91 8294291858</p>


        </div>
        <div className="card1 col-3 p-5">
        <i class="fa fa-facebook-square" aria-hidden="true" style={{fontSize:"80px",color:"#2D5F9A",marginLeft:"30px"}}></i>
        <h4>Facebook</h4>
       <p><a href="https://www.facebook.com/" style={{color:"black"}}>See our posts</a></p> 




        </div>
        <div className="card1 col-3 p-5 ">
        <i class="fa fa-facebook-square" aria-hidden="true" style={{fontSize:"80px",color:"#2D5F9A",marginLeft:"30px"}}></i>
        <h4>Instagram</h4>
        <p><a href="https://www.instagram.com/" style={{color:"black"}}>See our Instagram</a> </p>

        </div>
      </div>
<div className="row">
      <div className="message col-6 p-5" style={{display:"flex",flexWrap:"wrap"}}>
        <form className="form ">
            <h3 style={{textAlign:"center", paddingTop:"10px", paddingBottom:"60px"}}>Send us a Message</h3>
            <label for="name">Enter your name</label><br></br>
            <input type="username" placeholder="Here enter your name " id="name" className="frm"></input>
            <br/>

            <label for="email">Email</label><br/>
            <input type="email" placeholder="enter Email " id="email" className="frm"></input >
            <br/>
            <label for="sub">Subject</label><br></br>
            <input type="text" placeholder="enter Subject " id="sub" className="frm"></input>
            <br/>
            <label for="mess">Message</label><br></br>
            <textarea placeholder="enter Message " rows="4" id="mess" className="frm" style={{height:"90px"}}></textarea>

            <div className="container">
            <button type="Submit" className="btn btn-primary mb-5" style={{color:"white" , backgroundColor:"#2D5F9A",border:"none", width:"80vh" ,height:"40px"}}>
                    <i class="fa fa-paper-plane p-2" aria-hidden="true"/> 
                    Send Message
            </button>
            </div>

        </form>
      </div>

      <div className="message col-6 p-5"    >
      <form className="form " style={{border:"2px solid black",height:"750px", borderRadius:"20px"}}>
            <MapComponent />

        </form>
      </div>
     
      </div>
    
    </div>
    </div>
    </>
   
  )
}

export default ContactPage;
