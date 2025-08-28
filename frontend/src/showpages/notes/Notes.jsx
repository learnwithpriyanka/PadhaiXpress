// NotesPage.jsx
import { motion } from 'framer-motion';
import './NotesPage.css';
import { Link } from 'react-router-dom'

export default function NotesPage() {
  return (
    <>

      <div className='notesp'>



        <div className='notes-header'>
          <Link to='/firstyearnotes' className='notes-1st'>
            <button>First Year</button>
            <h6>Explore</h6>
            <h3 className='card-info'><i class="fa-solid fa-arrow-right-long"></i></h3>
          </Link>
          

          <Link to='/secondyearnotes' className='notes-2nd'>
            <button>Second Year</button>
            <h6>Explore</h6>
            <h3 className='card-info'><i class="fa-solid fa-arrow-right-long"></i></h3>
          </Link>
          <Link to='/thirdyearnotes' className='notes-3rd'>
            <button>Third Year</button>
            <h6>Explore</h6>
            <h3 className='card-info'><i class="fa-solid fa-arrow-right-long"></i></h3>
          </Link>
          
          <Link to='/fourthyearnotes' className='notes-4th'>
            <button>Fourth Year</button>
            <h6>Explore</h6>
            <h3 className='card-info'><i class="fa-solid fa-arrow-right-long"></i></h3>
          </Link>
        </div>
      </div>
    </>

  );
}
