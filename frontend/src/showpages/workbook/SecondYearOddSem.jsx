import React from 'react';
import { useCart } from '../../cartcomponent/CartContext'; // Ensure CartContext is properly set up
import Year from './Year';

 export const SecondYearOddSemData = [
    { id: "SY1", code: "23MT1001", name: "LINEAR ALGEBRA & CALCULUS FOR ENGINEERS" },
    { id: "SY2", code: "23CS03HF", name: "ADVANCED ALGORITHMS & DATA STRUCTURES" },
    { id: "SY3", code: "23EC2106R", name: "PROCESSORS AND CONTROLLERS" },
    { id: "SY4", code: "23EE2230F", name: "ESSENTIALS OF AUTONOMOUS SYSTEMS" },
    { id: "SY5", code: "23EC2223F", name: "FUNDAMENTALS OF ROBOTICS" },
    { id: "SY6", code: "23CY1002", name: "PHYSICAL CHEMISTRY AND THERMODYNAMICS (KLH)" },
    { id: "SY7", code: "23MT2004", name: "MATHEMATICAL PROGRAMMING" },
    { id: "SY8", code: "23MT2005", name: "PROBABILITY, STATISTICS & QUEUEING THEORY" },
    { id: "SY9", code: "23MT2014", name: "THEORY OF COMPUTATION" },
    { id: "SY10", code: "23AD2001O", name: "ARTIFICIAL INTELLIGENCE AND MACHINE LEARNING" },
    { id: "SY11", code: "23EC2210A", name: "NETWORK PROTOCOLS AND SECURITY" },
    { id: "SY12", code: "23CS2104A", name: "OPERATING SYSTEMS" },
    { id: "SY13", code: "23CS2104E", name: "OPERATING SYSTEMS" },
    { id: "SY14", code: "23CS2104R", name: "OPERATING SYSTEMS" },
    { id: "SY15", code: "23CS2103A", name: "ADVANCED OBJECT ORIENTED PROGRAMMING" },
    { id: "SY16", code: "23CS2103R", name: "ADVANCED OBJECT ORIENTED PROGRAMMING" },
    { id: "SY17", code: "23CS2205A", name: "DESIGN AND ANALYSIS OF ALGORITHMS" },
    { id: "SY18", code: "23CS2205R", name: "DESIGN AND ANALYSIS OF ALGORITHMS" },
    { id: "SY19", code: "23PH1010", name: "ELECTROMAGNETISM" },
    { id: "SY20", code: "23EC2221F", name: "EMBEDDED SYSTEM DESIGN" },
    { id: "SY21", code: "23EC2222F", name: "DIGITAL VLSI DESIGN" },
    { id: "SY22", code: "23EC2223F", name: "FUNDAMENTALS OF ROBOTICS" },
    { id: "SY23", code: "23EC2224F", name: "DEEP NETWORK ARCHITECTURES" },
    { id: "SY24", code: "23EC2226F", name: "WIRELESS COMMUNICATIONS" },
    { id: "SY25", code: "23EC2241F", name: "FUNDAMENTALS OF NANOTECHNOLOGY" },
    { id: "SY26", code: "23EC2209A", name: "ELECTROMAGNETIC WAVES & TRANSMISSION LINES" },
    { id: "SY27", code: "23EC2209R", name: "ELECTROMAGNETIC WAVES & TRANSMISSION LINES" },
    { id: "SY28", code: "23EC2208A", name: "DIGITAL COMMUNICATION" },
    { id: "SY29", code: "23EC2208E", name: "DIGITAL COMMUNICATION" },
    { id: "SY30", code: "23EC2208R", name: "DIGITAL COMMUNICATION" },
    { id: "SY31", code: "23EC2211A", name: "VLSI DESIGN" },
    { id: "SY32", code: "23EC2211R", name: "VLSI DESIGN" },
    { id: "SY33", code: "23EE2204R", name: "ELECTRICAL POWER GENERATION, TRANSMISSION & DISTRIBUTION" },
    { id: "SY34", code: "23EE2102", name: "ELECTRICAL MACHINES" },
    { id: "SY35", code: "23EE2207R", name: "CONTROL SYSTEMS" },
    { id: "SY36", code: "23EE2205A", name: "POWER ELECTRONICS" },
    { id: "SY37", code: "23EE2205R", name: "POWER ELECTRONICS" },
    { id: "SY38", code: "23IN05HF", name: "IOT IN HEALTH CARE" },
    { id: "SY39", code: "23IN2203", name: "WIRELESS TECHNOLOGIES FOR INTERNET OF THINGS" },
    { id: "SY40", code: "23AD2102A", name: "DATABASE MANAGEMENT SYSTEMS" },
    { id: "SY41", code: "23AD2102R", name: "DATABASE MANAGEMENT SYSTEMS" },
    { id: "SY42", code: "23MB4067", name: "INDUSTRIAL MANAGEMENT & PRODUCTION PLANNING" },
    { id: "SY43", code: "23ME2221F", name: "SUPPLY CHAIN AND QUALITY MANAGEMENT" },
    { id: "SY44", code: "23MT2010", name: "COMPUTATIONS IN APPLIED MECHANICS & STATISTICS" },
    { id: "SY45", code: "23ME3113A", name: "MANUFACTURING TECHNOLOGY" },
    { id: "SY46", code: "23ME3113R", name: "MANUFACTURING TECHNOLOGY" },
    { id: "SY47", code: "23ME2209A", name: "KINEMATICS & DYNAMICS OF MACHINES" },
    { id: "SY48", code: "23ME2209R", name: "KINEMATICS & DYNAMICS OF MACHINES" },
    { id: "SY49", code: "23ME3112", name: "THERMAL SYSTEMS ENGINEERING" },
    { id: "SY50", code: "23CS3202", name: "NATURE INSPIRED SOFT COMPUTING" },
    { id: "SY51", code: "23CE2232F", name: "BUILDING MATERIALS, PLANNING & DRAWING" },
    { id: "SY52", code: "23MB4062", name: "CONSTRUCTION PROJECT MANAGEMENT" },
    { id: "SY53", code: "23CE2209R", name: "TRANSPORTATION ENGINEERING" },
    { id: "SY54", code: "23CE2206", name: "STRUCTURAL ANALYSIS" },
    { id: "SY55", code: "23CE2208R", name: "GEOTECHNICAL ENGINEERING" },
    { id: "SY56", code: "23CE2207", name: "CONCRETE TECHNOLOGY" },
    { id: "SY57", code: "23BT2207A", name: "BIOANALYTICAL TECHNIQUES" },
    { id: "SY58", code: "23BT2207R", name: "BIOANALYTICAL TECHNIQUES" },
    { id: "SY59", code: "23BT3214", name: "BIOINFORMATICS" },
    { id: "SY60", code: "23MT2009", name: "BIOSTATISTICS" },
    { id: "SY61", code: "23BT2206", name: "MOLECULAR BIOLOGY" },
    { id: "SY62", code: "23BT2209A", name: "BIOCHEMICAL REACTION ENGINEERING" },
    { id: "SY63", code: "23BT2209R", name: "BIOCHEMICAL REACTION ENGINEERING" },
    { id: "SY64", code: "23BT2105A", name: "IMMUNOLOGY" },
    { id: "SY65", code: "23BT2105R", name: "IMMUNOLOGY" },
    { id: "SY66", code: "23AD2103R", name: "SYSTEM DESIGN AND INTRODUCTION TO CLOUD" },
    { id: "SY67", code: "23AD2204A", name: "DATA MANAGEMENT AND WAREHOUSING" },
    { id: "SY68", code: "23AD2204R", name: "DATA MANAGEMENT AND WAREHOUSING" },
    { id: "SY69", code: "23AD2205A", name: "DEEP LEARNING" },
    { id: "SY70", code: "23AD2205R", name: "DEEP LEARNING" }
].map((item) => ({
    ...item,
    image: "/media/image/klimage.png", // Add the image path here
    price: "500" // Add the price here
    ,pages:"200",
    pageType:"double"
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