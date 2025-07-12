import React from 'react';
import Year from './Year'; // Ensure the correct import path for Year
import { useCart } from '../../cartcomponent/CartContext';

//  export const FirstYearOddSemData = [
//     { id: "FY1", code: "23MT1001", name: "LINEAR ALGEBRA & CALCULUS FOR ENGINEERS" ,pages:"120"},
//     { id: "FY2", code: "24SC1203", name: "DATA STRUCTURES" ,pages:"150"},
//     { id: "FY3", code: "23EC1203", name: "BASIC ELECTRICAL AND ELECTRONIC CIRCUITS" ,pages:"130"},
//     { id: "FY4", code: "23EC1202", name: "DIGITAL DESIGN AND COMPUTER ARCHITECTURE", pages:"140"},
//     { id: "FY5", code: "23ME1201", name: "ENGINEERING MECHANICS" ,pages:"160"},  
    
//     { id: "FY6", code: "24SC1203", name: "DATA STRUCTURES USING PYTHON" ,pages:"180"},
//     { id: "FY7", code: "23CE1201", name: "ENGINEERING GEOLOGY" ,pages:"190"},
   
//     { id: "FY8", code: "23MT2003", name: "MATHEMATICAL MODELLING & NUMERICAL METHODS", pages:"210"},
//     { id: "FY9", code: "24AD1201", name: "ARTIFICIAL INTELLIGENCE" ,pages:"220"},
// ].map((item) => ({
//     ...item,
//     image: "/media/image/klimage.png", // Add the image path here
//     price: "500", // Add the price here
//     pageType:"double"
// }));

function FirstYearOddSem() {
    const { cart, dispatch } = useCart(); // Ensure CartContext is properly set up

    return (
        <Year
            year="First"
            sem="Odd"
            placeholder="Search for First Year Odd Semester workbooks..."
            cart={cart}
            
        />
    );
}

export default FirstYearOddSem;