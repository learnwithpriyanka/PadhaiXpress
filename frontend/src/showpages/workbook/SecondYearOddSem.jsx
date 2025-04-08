import React from 'react';
import { useCart } from '../../cartcomponent/CartContext'; // Ensure CartContext is properly set up
import Year from './Year';

const SecondYearOddSemData = [
    { id: 1, code: "23MT1001", name: "LINEAR ALGEBRA & CALCULUS FOR ENGINEERS" },
    { id: 2, code: "23CS03HF", name: "ADVANCED ALGORITHMS & DATA STRUCTURES" },
    { id: 3, code: "23EC2106R", name: "PROCESSORS AND CONTROLLERS" },
    { id: 4, code: "23EE2230F", name: "ESSENTIALS OF AUTONOMOUS SYSTEMS" },
    { id: 5, code: "23EC2223F", name: "FUNDAMENTALS OF ROBOTICS" },
    { id: 6, code: "23CY1002", name: "PHYSICAL CHEMISTRY AND THERMODYNAMICS (KLH)" },
    { id: 7, code: "23MT2004", name: "MATHEMATICAL PROGRAMMING" },
    { id: 8, code: "23MT2005", name: "PROBABILITY, STATISTICS & QUEUEING THEORY" },
    { id: 9, code: "23MT2014", name: "THEORY OF COMPUTATION" },
    { id: 10, code: "23AD2001O", name: "ARTIFICIAL INTELLIGENCE AND MACHINE LEARNING" },
    { id: 11, code: "23EC2210A", name: "NETWORK PROTOCOLS AND SECURITY" },
    { id: 12, code: "23CS2104A", name: "OPERATING SYSTEMS" },
    { id: 13, code: "23CS2104E", name: "OPERATING SYSTEMS" },
    { id: 14, code: "23CS2104R", name: "OPERATING SYSTEMS" },
    { id: 15, code: "23CS2103A", name: "ADVANCED OBJECT ORIENTED PROGRAMMING" },
    { id: 16, code: "23CS2103R", name: "ADVANCED OBJECT ORIENTED PROGRAMMING" },
    { id: 17, code: "23CS2205A", name: "DESIGN AND ANALYSIS OF ALGORITHMS" },
    { id: 18, code: "23CS2205R", name: "DESIGN AND ANALYSIS OF ALGORITHMS" },
    { id: 19, code: "23PH1010", name: "ELECTROMAGNETISM" },
    { id: 20, code: "23EC2221F", name: "EMBEDDED SYSTEM DESIGN" },
    { id: 21, code: "23EC2222F", name: "DIGITAL VLSI DESIGN" },
    { id: 22, code: "23EC2223F", name: "FUNDAMENTALS OF ROBOTICS" },
    { id: 23, code: "23EC2224F", name: "DEEP NETWORK ARCHITECTURES" },
    { id: 24, code: "23EC2226F", name: "WIRELESS COMMUNICATIONS" },
    { id: 25, code: "23EC2241F", name: "FUNDAMENTALS OF NANOTECHNOLOGY" },
    { id: 26, code: "23EC2209A", name: "ELECTROMAGNETIC WAVES & TRANSMISSION LINES" },
    { id: 27, code: "23EC2209R", name: "ELECTROMAGNETIC WAVES & TRANSMISSION LINES" },
    { id: 28, code: "23EC2208A", name: "DIGITAL COMMUNICATION" },
    { id: 29, code: "23EC2208E", name: "DIGITAL COMMUNICATION" },
    { id: 30, code: "23EC2208R", name: "DIGITAL COMMUNICATION" },
    { id: 31, code: "23EC2211A", name: "VLSI DESIGN" },
    { id: 32, code: "23EC2211R", name: "VLSI DESIGN" },
    { id: 33, code: "23EE2204R", name: "ELECTRICAL POWER GENERATION, TRANSMISSION & DISTRIBUTION" },
    { id: 34, code: "23EE2102", name: "ELECTRICAL MACHINES" },
    { id: 35, code: "23EE2207R", name: "CONTROL SYSTEMS" },
    { id: 36, code: "23EE2205A", name: "POWER ELECTRONICS" },
    { id: 37, code: "23EE2205R", name: "POWER ELECTRONICS" },
    { id: 38, code: "23IN05HF", name: "IOT IN HEALTH CARE" },
    { id: 39, code: "23IN2203", name: "WIRELESS TECHNOLOGIES FOR INTERNET OF THINGS" },
    { id: 40, code: "23AD2102A", name: "DATABASE MANAGEMENT SYSTEMS" },
    { id: 41, code: "23AD2102R", name: "DATABASE MANAGEMENT SYSTEMS" },
    { id: 42, code: "23MB4067", name: "INDUSTRIAL MANAGEMENT & PRODUCTION PLANNING" },
    { id: 43, code: "23ME2221F", name: "SUPPLY CHAIN AND QUALITY MANAGEMENT" },
    { id: 44, code: "23MT2010", name: "COMPUTATIONS IN APPLIED MECHANICS & STATISTICS" },
    { id: 45, code: "23ME3113A", name: "MANUFACTURING TECHNOLOGY" },
    { id: 46, code: "23ME3113R", name: "MANUFACTURING TECHNOLOGY" },
    { id: 47, code: "23ME2209A", name: "KINEMATICS & DYNAMICS OF MACHINES" },
    { id: 48, code: "23ME2209R", name: "KINEMATICS & DYNAMICS OF MACHINES" },
    { id: 49, code: "23ME3112", name: "THERMAL SYSTEMS ENGINEERING" },
    { id: 50, code: "23CS3202", name: "NATURE INSPIRED SOFT COMPUTING" },
    { id: 51, code: "23CE2232F", name: "BUILDING MATERIALS, PLANNING & DRAWING" },
    { id: 52, code: "23MB4062", name: "CONSTRUCTION PROJECT MANAGEMENT" },
    { id: 53, code: "23CE2209R", name: "TRANSPORTATION ENGINEERING" },
    { id: 54, code: "23CE2206", name: "STRUCTURAL ANALYSIS" },
    { id: 55, code: "23CE2208R", name: "GEOTECHNICAL ENGINEERING" },
    { id: 56, code: "23CE2207", name: "CONCRETE TECHNOLOGY" },
    { id: 57, code: "23BT2207A", name: "BIOANALYTICAL TECHNIQUES" },
    { id: 58, code: "23BT2207R", name: "BIOANALYTICAL TECHNIQUES" },
    { id: 59, code: "23BT3214", name: "BIOINFORMATICS" },
    { id: 60, code: "23MT2009", name: "BIOSTATISTICS" },
    { id: 61, code: "23BT2206", name: "MOLECULAR BIOLOGY" },
    { id: 62, code: "23BT2209A", name: "BIOCHEMICAL REACTION ENGINEERING" },
    { id: 63, code: "23BT2209R", name: "BIOCHEMICAL REACTION ENGINEERING" },
    { id: 64, code: "23BT2105A", name: "IMMUNOLOGY" },
    { id: 65, code: "23BT2105R", name: "IMMUNOLOGY" },
    { id: 66, code: "23AD2103R", name: "SYSTEM DESIGN AND INTRODUCTION TO CLOUD" },
    { id: 67, code: "23AD2204A", name: "DATA MANAGEMENT AND WAREHOUSING" },
    { id: 68, code: "23AD2204R", name: "DATA MANAGEMENT AND WAREHOUSING" },
    { id: 69, code: "23AD2205A", name: "DEEP LEARNING" },
    { id: 70, code: "23AD2205R", name: "DEEP LEARNING" }
].map((item) => ({
    ...item,
    image: "/media/image/klimage.png", // Add the image path here
    price: "500" // Add the price here
}));

function SecondYearOddSem() {
    const { cart, dispatch } = useCart();

    return (
        <Year
            data={SecondYearOddSemData}
            placeholder="Search for Second Year Odd Semester workbooks..."
            cart={cart}
            dispatch={dispatch}
        />
    );
}

export default SecondYearOddSem;