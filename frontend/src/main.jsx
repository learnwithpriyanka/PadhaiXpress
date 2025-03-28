import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'

import HomePage from './component/HomePage/HomePage.jsx'
import AboutPage from './component/About/AboutPage.jsx'

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <HomePage/>
    <AboutPage/>
  </StrictMode>,
)
