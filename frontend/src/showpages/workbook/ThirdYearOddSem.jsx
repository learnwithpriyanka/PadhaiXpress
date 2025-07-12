import React from 'react';
import { useCart } from '../../cartcomponent/CartContext';
import Year from './Year';


// export const ThirdYearOddSemData = [
//     { id: "TY1", code: "22PH4101", name: "QUANTUM PHYSICS FOR ENGINEERS" },
//     { id: "TY2", code: "22PH4102", name: "APPLIED PHYSICS" },
//     { id: "TY3", code: "222CS2221F", name: "UX DESIGN" },
//     { id: "TY4", code: "22CS2224F", name: "CRYPT ANALYSIS & CYBER DEFENSE" },
//     { id: "TY5", code: "22CS2227F", name: "DATA ANALYTICS AND VISUALIZATION" },
//     { id: "TY6", code: "22CS2228F", name: "CROSS-PLATFORM USER EXPERIENCE DESIGN" },
//     { id: "TY7", code: "22CS2247F", name: "CRYPTOGRAPHY AND SECURITY" },
//     { id: "TY8", code: "22CS2247M", name: "CRYPTOGRAPHY AND SECURITY" },
//     { id: "TY9", code: "22CS2233F", name: "INTRODUCTION TO BLOCKCHAIN AND CRYPTO CURRENCIES" },
//     { id: "TY10", code: "22CS2234F", name: "NETWORK & INFRASTRUCTURE SECURITY" },
//     { id: "TY11", code: "22CS2235F", name: "COMPILER DESIGN" },
//     { id: "TY12", code: "22CS2235M", name: "COMPILER DESIGN" },
//     { id: "TY13", code: "22CS2237F", name: "QUANTUM COMPUTING" },
//     { id: "TY14", code: "22CS2239F", name: "SOFTWARE VERIFICATION & VALIDATION" },
//     { id: "TY15", code: "22CS2229F", name: "APPLICATION DEVELOPMENT ON CLOUD" },
//     { id: "TY16", code: "22CS2230F", name: "SOLUTIONS ARCHITECTING ON CLOUD" },
//     { id: "TY17", code: "22CS2231F", name: "VISUAL PROGRAMING" },
//     { id: "TY18", code: "22CS2240F", name: ".NET PROGRAMMING (EPAM)" },
//     { id: "TY19", code: "22CS2241F", name: "FRONT END WEB DEVELOPMENT (EPAM)" },
//     { id: "TY20", code: "22CS2242F", name: "SOFTWARE TESTING (EPAM)" },
//     { id: "TY21", code: "22CS2243F", name: "CLOUD DEVOPS (EPAM)" },
//     { id: "TY22", code: "22CY1001", name: "ENGINEERING CHEMISTRY" },
//     { id: "TY23", code: "22CY1004", name: "ORGANIC ELECTRONICS" },
//     { id: "TY24", code: "22EC3213A", name: "CONTROL SYSTEMS" },
//     { id: "TY25", code: "22EC3213R", name: "CONTROL SYSTEMS" },
//     { id: "TY26", code: "22AIP3305A", name: "DEEP LEARNING" },
//     { id: "TY27", code: "22AIP3305R", name: "DEEP LEARNING" },
//     { id: "TY28", code: "22CSB3304A", name: "DIGITAL FORENSICS" },
//     { id: "TY29", code: "22CSB3304R", name: "DIGITAL FORENSICS" },
//     { id: "TY30", code: "22DCS3303A", name: "5G WIRELESS TECHNOLOGIES" },
//     { id: "TY31", code: "22DSB3303A", name: "BIG DATA ANALYTICS" },
//     { id: "TY32", code: "22DSB3303R", name: "BIG DATA ANALYTICS" },
//     { id: "TY33", code: "22EDS3303A", name: "EMBEDDED AND REAL-TIME SYSTEMS" },
//     { id: "TY34", code: "22EDS3303R", name: "EMBEDDED AND REAL-TIME SYSTEMS" },
//     { id: "TY35", code: "22SMD3303R", name: "CONTINUOUS DELIVERY & DEVOPS" },
//     { id: "TY36", code: "22VLS3303R", name: "VLSI PHYSICAL DESIGN AUTOMATION" },
//     { id: "TY37", code: "22VLS3303A", name: "VLSI PHYSICAL DESIGN AUTOMATION" },
//     { id: "TY38", code: "22EE3209R", name: "AI TECHNIQUES FOR ELECTRICAL ENGINEERING" },
//     { id: "TY39", code: "22EE3208R", name: "POWER SYSTEM PROTECTION & CONTROL" },
//     { id: "TY40", code: "22ASS3309A", name: "AUTONOMOUS ELECTRIC MOBILITY-SYSTEMS AND APPLICATIONS" },
//     { id: "TY41", code: "22CEC3305R", name: "CLOUD & SERVERLESS COMPUTING" },
//     { id: "TY42", code: "22GET3304R", name: "GRID INTEGRATION OF RENEWABLE ENERGY SOURCES" },
//     { id: "TY43", code: "22ME3112", name: "THERMAL SYSTEMS ENGINEERING" },
//     { id: "TY44", code: "22ME3214R", name: "MACHINE DESIGN" },
//     { id: "TY45", code: "22EGD3304A", name: "SUSTAINABLE DESIGN & SOCIAL INNOVATION IN ENGINEERING DESIGN" },
//     { id: "TY46", code: "22EGD3304R", name: "SUSTAINABLE DESIGN & SOCIAL INNOVATION IN ENGINEERING DESIGN" },
//     { id: "TY47", code: "22SMF3304R", name: "SUSTAINABLE DESIGN & SOCIAL INNOVATION IN SMART MANUFACTURING" },
//     { id: "TY48", code: "22ME3215", name: "DIGITAL MANUFACTURING & ROBOTICS" }
// ].map((item) => ({
//     ...item,
//     image: "/media/image/klimage.png", // Add the image path here
//     price: "500", // Add the price here
//     pages:"250",
//     pageType: "double"

// }));

function ThirdYearOddSem() {
    const { cart } = useCart();

    return (
        <Year
            year="Third"
            sem="Odd"
            placeholder="Search for Third Year Odd Semester workbooks..."
            cart={cart}
        />
    );
}

export default ThirdYearOddSem;