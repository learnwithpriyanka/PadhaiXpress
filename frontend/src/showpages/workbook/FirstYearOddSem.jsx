import React from 'react';
import Year from './Year'; // Ensure the correct import path for Year
import { useCart } from '../../cartcomponent/CartContext';

const FirstYearOddSemData = [
    { id: "FY1", code: "23MT1001", name: "LINEAR ALGEBRA & CALCULUS FOR ENGINEERS" },
    { id: "FY2", code: "24SC1203", name: "DATA STRUCTURES" },
    { id: "FY3", code: "23EC1203", name: "BASIC ELECTRICAL AND ELECTRONIC CIRCUITS" },
    { id: "FY4", code: "23EC1202", name: "DIGITAL DESIGN AND COMPUTER ARCHITECTURE" },
    { id: "FY5", code: "23MET1005", name: "MATERIAL SCIENCE AND METALLURGY" },
    { id: "FY6", code: "24SC1203", name: "DATA STRUCTURES USING PYTHON" },
    { id: "FY7", code: "22CE1201", name: "ENGINEERING GEOLOGY" },
    { id: "FY8", code: "23MT2003", name: "MATHEMATICAL MODELLING & NUMERICAL METHODS" },
    { id: "FY9", code: "24AD1201", name: "ARTIFICIAL INTELLIGENCE" }
].map((item) => ({
    ...item,
    image: "/media/image/klimage.png", // Add the image path here
    price: "500" // Add the price here
}));

function FirstYearOddSem() {
    const { cart, dispatch } = useCart(); // Ensure CartContext is properly set up

    return (
        <Year
            data={FirstYearOddSemData}
            placeholder="Search for First Year Odd Semester workbooks..."
            cart={cart}
            dispatch={dispatch}
        />
    );
}

export default FirstYearOddSem;