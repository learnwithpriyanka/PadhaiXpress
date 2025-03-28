import React from 'react'
import { createRoot } from 'react-dom/client'
  import './index.css'
  import './component/HomePage/homepage.css'
import { BrowserRouter, Routes, Route } from "react-router-dom";

import Navbar from './Navbar.jsx'

import Homepage from './component/HomePage/HomePage.jsx';
import AboutPage from './component/About/AboutPage.jsx';
import ContactPage from './component/Contact/ContactPage.jsx';
import SignupPage from './component/SignUp/SignupPage.jsx';
import NotFound from './NotFound.jsx';
import NotesPage from './showpages/notes/NotesPage.jsx';
import WorkbookPage from './showpages/workbook/WorkbookPage.jsx';
import RecycleaPage from './showpages/recycle/RecyclePage.jsx';
import ProjectPage from './showpages/project/ProjectPage.jsx';
import SignInPage from './component/SignIn/SignInPage.jsx' 


createRoot(document.getElementById('root')).render(
  <BrowserRouter>
  <Navbar/>
     <Routes>
      <Route path="/" element={<Homepage/>}></Route>
      
      <Route path="about" element={<AboutPage/>}></Route>
      
      
      <Route path="contact" element={<ContactPage/>}></Route>
      <Route path="signin" element={<SignInPage/>}></Route>

      <Route path="signup" element={<SignupPage/>}></Route>
      <Route path="*" element={<NotFound/>}></Route> 

      {/* navigation route */}
      <Route path="/notes" element={<NotesPage/>}></Route>
      <Route path="/workbook" element={<WorkbookPage/>}></Route>
      <Route path="/recycle" element={<RecycleaPage/>}></Route>
      <Route path="/project" element={<ProjectPage/>}></Route>
      


     </Routes> 

     

  </BrowserRouter>
);
