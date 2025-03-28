import React from 'react'
import './homepage.css'
import { Link } from 'react-router-dom'

function Hero() {
    return ( 
        <>
        <div className='cards-containar'>

        <Link to='/workbook' className='card'>
                <img src='media/image/workbook1.png ' alt='img' className='card-img'></img>
                <h2 className='card-title'>Workbook</h2>
                <p className='card-info'>go though</p>
            </Link>

            <Link to='/project' className='card'>
                <img src='media/image/recycle.jpg' alt='img' className='card-img'></img>
                <h2 className='card-title'>Print Your Project</h2>
                <p className='card-info'>go though</p>
            </Link>

            <Link to='/recycle' className='card'>
                <img src='media/image/recycle.jpg' alt='img' className='card-img'></img>
                <h2 className='card-title'>Recycle</h2>
                <p className='card-info'>go though</p>
            </Link>

        
         <Link to='/notes' className='card'>
                <img  src='media/image/notes.jpg' alt='img' className='card-img'></img>
                <h2 className='card-title'>Notes</h2>
                <p className='card-info'>go though</p>
        </Link>

            

            

            
            
        </div>
        </> 

    
    );
}

export default Hero;