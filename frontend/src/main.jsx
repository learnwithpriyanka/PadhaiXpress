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
import ShoppingCart from './cartcomponent/ShoppingCart.jsx';
import { CartProvider } from './cartcomponent/CartContext';

import FirstYearOddSem from './showpages/workbook/FirstYearOddSem';
import FirstYearEvenSem from './showpages/workbook/FirstYearEvenSem';
import SecondYearOddSem from './showpages/workbook/SecondYearOddSem';
import SecondYearEvenSem from './showpages/workbook/SecondYearEvenSem';
import ThirdYearOddSem from './showpages/workbook/ThirdYearOddSem';
import ThirdYearEvenSem from './showpages/workbook/ThirdYearEvenSem';
import FourthYearOddSem from './showpages/workbook/FourthYearOddSem';
import FourthYearEvenSem from './showpages/workbook/FourthYearEvenSem';
import Year1 from './showpages/workbook/Year1.jsx';
import ForgotPassword from './component/signIn/ForgotPassword.jsx';
import ProfilePage from './profile/ProfilePage.jsx';
import { AuthProvider } from "./context/AuthContext";
import OrderdetailPage from './orderdetails/OrderdetailPage.jsx';
import Order from './orderdetails/Order.jsx';
import PrivateRoute from './PrivateRoute/PrivateRoute.jsx';

createRoot(document.getElementById('root')).render(
  <AuthProvider>
    <CartProvider>
      <BrowserRouter>
        <Navbar />
        <Routes>
          <Route path="/" element={<Homepage />}></Route>
          <Route path="about" element={<AboutPage />}></Route>
          <Route path="contact" element={<ContactPage />}></Route>
          <Route path="signin" element={<SignInPage />}></Route>
          <Route path="signup" element={<SignupPage />}></Route>
          <Route path='cart' element={<ShoppingCart />}></Route>
          <Route path="*" element={<NotFound />}></Route>
          <Route path="/profile" element={<ProfilePage />}></Route>
          <Route path='/orders' element={<Order />}></Route>
          
          <Route path='/orderdetails' element={
            <PrivateRoute>
              <OrderdetailPage />
            </PrivateRoute>
          }></Route>

          {/* navigation route */}

          <Route path="/workbook" element={<WorkbookPage />}>
            <Route index element={<Year1 />} />
            <Route path="year1/firstyearoddsem" element={<FirstYearOddSem />} />
            <Route path="year1/firstyearevensem" element={<FirstYearEvenSem />} />
            <Route path="year1/secondyearoddsem" element={<SecondYearOddSem />} />
            <Route path="year1/secondyearevensem" element={<SecondYearEvenSem />} />
            <Route path="year1/thirdyearoddsem" element={<ThirdYearOddSem />} />
            <Route path="year1/thirdyearevensem" element={<ThirdYearEvenSem />} />
            <Route path="year1/fourthyearoddsem" element={<FourthYearOddSem />} />
            <Route path="year1/fourthyearevensem" element={<FourthYearEvenSem />} />
          </Route>
          <Route path="/notes" element={<NotesPage />}></Route>
          <Route path="/recycle" element={<RecycleaPage />}></Route>
          <Route path="/project" element={<ProjectPage />}></Route>


          <Route path='/forgot-password' element={<ForgotPassword />} />

        </Routes>



      </BrowserRouter>
    </CartProvider>
  </AuthProvider>
);
