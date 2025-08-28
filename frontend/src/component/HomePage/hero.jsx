import React from 'react'
import './homepage.css'
import { Link } from 'react-router-dom'

function Hero() {
    return ( 
        <>
       
        <div className='cards-containar'>

        <Link to='/workbook' className='card'>
                <img src='media/image/klimage.png ' alt='img' className='card-img'></img>
                <h2 className='card-title'>LAB WORKBOOK</h2>
                <h3 className='card-info'> <i className="fa-solid fa-arrow-right-long"></i></h3>
            </Link>

            <Link to='/project' className='card'>
                <img src='media/image/print.png' alt='img' className='card-img'></img>
                <h2 className='card-title'>Print Your Project</h2>
                <h3 className='card-info'><i className="fa-solid fa-arrow-right-long"></i></h3>
            </Link>

            <Link to='/recycle' className='card'>
                <img src='media/image/recycle.jpg' alt='img' className='card-img'></img>
                <h2 className='card-title'style={{marginTop:"-15px"}} >Recycle</h2>
                <h3 className='card-info'><i className="fa-solid fa-arrow-right-long"></i></h3>
            </Link>

        
         <Link to='/notes' className='card'>
                <img  src='media/image/note.png' alt='img' className='card-img'></img>
                {/* <h2 className='card-title'>Notes</h2> */}
                <h3 className='card-info' style={{marginTop:"0"}}><i className="fa-solid fa-arrow-right-long"></i></h3>
        </Link>

            
            
        </div>
        </> 

    
    );
}

export default Hero;