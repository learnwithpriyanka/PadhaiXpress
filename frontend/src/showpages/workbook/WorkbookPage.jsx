import React from 'react';
import Footer from '../../Footer';
import Year1 from './Year1';
import {  Routes, Route, Navigate } from 'react-router-dom';
import FirstYearOddSem from './FirstYearOddSem';
import FirstYearEvenSem from './FirstYearEvenSem';
import SecondYearOddSem from './SecondYearOddSem';
import SecondYearEvenSem from './SecondYearEvenSem';
import ThirdYearOddSem from './ThirdYearOddSem';
import ThirdYearEvenSem from './ThirdYearEvenSem';
import FourthYearOddSem from './FourthYearOddSem';
import FourthYearEvenSem from './FourthYearEvenSem';

function WorkbookPage() {
    return (
        <>
            <div>
                <Routes>
                    {/* Redirect from root to /workbook */}
                    <Route path="/" element={<Navigate to="/workbook/year1" />} />
                    <Route path="/year1" element={<Year1 />} />
                    <Route path="/year1/firstyearoddsem" element={<FirstYearOddSem />} />
                    <Route path="/year1/firstyearevensem" element={<FirstYearEvenSem />} />
                    <Route path="/year1/secondyearoddsem" element={<SecondYearOddSem />} />
                    <Route path="/year1/secondyearevensem" element={< SecondYearEvenSem/>} />    
                    <Route path="/year1/thirdyearoddsem" element={<ThirdYearOddSem />} />
                    <Route path="/year1/thirdyearevensem" element={<ThirdYearEvenSem />} />
                    <Route path="/year1/fourthyearoddsem" element={<FourthYearOddSem/>} />
                    <Route path="/year1/fourthyearevensem" element={<FourthYearEvenSem/>} />
                   
                </Routes>
                <Footer />
                </div>
        </>
    );
}

export default WorkbookPage;