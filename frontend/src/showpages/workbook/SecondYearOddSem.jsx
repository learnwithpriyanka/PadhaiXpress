import React from 'react';
import "./WorkBook.css";
import { useState } from 'react';

const SecondYearOddSemData = [
    { "id": 1, "code": "23CS02HF", "name": "EMBEDDED SYSTEMS DESIGN", "image": "/media/image/work.jpg" },
    { "id": 2, "code": "23CS03HF", "name": "ADVANCED ALGORITHMS & DATA STRUCTURES", "image": "/media/image/work.jpg" },
    { "id": 3, "code": "23EC2106R", "name": "PROCESSORS AND CONTROLLERS", "image": "/media/image/work.jpg" },
    { "id": 4, "code": "23EE2230F", "name": "ESSENTIALS OF AUTONOMOUS SYSTEMS", "image": "/media/image/work.jpg" },
    { "id": 5, "code": "23EC2223F", "name": "FUNDAMENTALS OF ROBOTICS", "image": "/media/image/work.jpg" },
    { "id": 6, "code": "23CY1002", "name": "PHYSICAL CHEMISTRY AND THERMODYNAMICS (KLH)", "image": "/media/image/work.jpg" },
    { "id": 7, "code": "23MT2004", "name": "MATHEMATICAL PROGRAMMING", "image": "/media/image/work.jpg" },
    { "id": 8, "code": "23MT2005", "name": "PROBABILITY, STATISTICS & QUEUEING THEORY", "image": "/media/image/work.jpg" },
    { "id": 9, "code": "23MT2014", "name": "THEORY OF COMPUTATION", "image": "/media/image/work.jpg" },
    { "id": 10, "code": "23AD2001O", "name": "ARTIFICIAL INTELLIGENCE AND MACHINE LEARNING", "image": "/media/image/work.jpg" },
    { "id": 11, "code": "23EC2210A", "name": "NETWORK PROTOCOLS AND SECURITY", "image": "/media/image/work.jpg" },
    { "id": 12, "code": "23CS2104A", "name": "OPERATING SYSTEMS", "image": "/media/image/work.jpg" },
    { "id": 13, "code": "23CS2104E", "name": "OPERATING SYSTEMS", "image": "/media/image/work.jpg" },
    { "id": 14, "code": "23CS2104R", "name": "OPERATING SYSTEMS", "image": "/media/image/work.jpg" },
    { "id": 15, "code": "23CS2103A", "name": "ADVANCED OBJECT ORIENTED PROGRAMMING", "image": "/media/image/work.jpg" },
    { "id": 16, "code": "23CS2103R", "name": "ADVANCED OBJECT ORIENTED PROGRAMMING", "image": "/media/image/work.jpg" },
    { "id": 17, "code": "23CS2205A", "name": "DESIGN AND ANALYSIS OF ALGORITHMS", "image": "/media/image/work.jpg" },
    { "id": 18, "code": "23CS2205R", "name": "DESIGN AND ANALYSIS OF ALGORITHMS", "image": "/media/image/work.jpg" },
    { "id": 19, "code": "23PH1010", "name": "ELECTROMAGNETISM", "image": "/media/image/work.jpg" },
    { "id": 20, "code": "23EC2221F", "name": "EMBEDDED SYSTEM DESIGN", "image": "/media/image/work.jpg" },
    { "id": 21, "code": "23EC2222F", "name": "DIGITAL VLSI DESIGN", "image": "/media/image/work.jpg" },
    { "id": 22, "code": "23EC2223F", "name": "FUNDAMENTALS OF ROBOTICS", "image": "/media/image/work.jpg" },
    { "id": 23, "code": "23EC2224F", "name": "DEEP NETWORK ARCHITECTURES", "image": "/media/image/work.jpg" },
    { "id": 24, "code": "23EC2226F", "name": "WIRELESS COMMUNICATIONS", "image": "/media/image/work.jpg" },
    { "id": 25, "code": "23EC2241F", "name": "FUNDAMENTALS OF NANOTECHNOLOGY", "image": "/media/image/work.jpg" },
    { "id": 26, "code": "23EC2209A", "name": "ELECTROMAGNETIC WAVES & TRANSMISSION LINES", "image": "/media/image/work.jpg" },
    { "id": 27, "code": "23EC2209R", "name": "ELECTROMAGNETIC WAVES & TRANSMISSION LINES", "image": "/media/image/work.jpg" },
    { "id": 28, "code": "23EC2208A", "name": "DIGITAL COMMUNICATION", "image": "/media/image/work.jpg" },
    { "id": 29, "code": "23EC2208E", "name": "DIGITAL COMMUNICATION", "image": "/media/image/work.jpg" },
    { "id": 30, "code": "23EC2208R", "name": "DIGITAL COMMUNICATION", "image": "/media/image/work.jpg" },
    { "id": 31, "code": "23EC2211A", "name": "VLSI DESIGN", "image": "/media/image/work.jpg" },
    { "id": 32, "code": "23EC2211R", "name": "VLSI DESIGN", "image": "/media/image/work.jpg" },
    { "id": 33, "code": "23EE2204R", "name": "ELECTRICAL POWER GENERATION, TRANSMISSION & DISTRIBUTION", "image": "/media/image/work.jpg" },
    { "id": 34, "code": "23EE2102", "name": "ELECTRICAL MACHINES", "image": "/media/image/work.jpg" },
    { "id": 35, "code": "23EE2207R", "name": "CONTROL SYSTEMS", "image": "/media/image/work.jpg" },
    { "id": 36, "code": "23EE2205A", "name": "POWER ELECTRONICS", "image": "/media/image/work.jpg" },
    { "id": 37, "code": "23EE2205R", "name": "POWER ELECTRONICS", "image": "/media/image/work.jpg" },
    { "id": 38, "code": "23IN05HF", "name": "IOT IN HEALTH CARE", "image": "/media/image/work.jpg" },
    { "id": 39, "code": "23IN2203", "name": "WIRELESS TECHNOLOGIES FOR INTERNET OF THINGS", "image": "/media/image/work.jpg" },
    { "id": 40, "code": "23AD2102A", "name": "DATABASE MANAGEMENT SYSTEMS", "image": "/media/image/work.jpg" },
    { "id": 41, "code": "23AD2102R", "name": "DATABASE MANAGEMENT SYSTEMS", "image": "/media/image/work.jpg" },
    { "id": 42, "code": "23MB4067", "name": "INDUSTRIAL MANAGEMENT & PRODUCTION PLANNING", "image": "/media/image/work.jpg" },
    { "id": 43, "code": "23ME2221F", "name": "SUPPLY CHAIN AND QUALITY MANAGEMENT", "image": "/media/image/work.jpg" },
    { "id": 44, "code": "23MT2010", "name": "COMPUTATIONS IN APPLIED MECHANICS & STATISTICS", "image": "/media/image/work.jpg" },
    { "id": 45, "code": "23ME3113A", "name": "MANUFACTURING TECHNOLOGY", "image": "/media/image/work.jpg" },
    { "id": 46, "code": "23ME3113R", "name": "MANUFACTURING TECHNOLOGY", "image": "/media/image/work.jpg" },
    { "id": 47, "code": "23ME2209A", "name": "KINEMATICS & DYNAMICS OF MACHINES", "image": "/media/image/work.jpg" },
    { "id": 48, "code": "23ME2209R", "name": "KINEMATICS & DYNAMICS OF MACHINES", "image": "/media/image/work.jpg" },
    { "id": 49, "code": "23ME3112", "name": "THERMAL SYSTEMS ENGINEERING", "image": "/media/image/work.jpg" },
    { "id": 50, "code": "23CS3202", "name": "NATURE INSPIRED SOFT COMPUTING", "image": "/media/image/work.jpg" },
    { "id": 51, "code": "23CE2232F", "name": "BUILDING MATERIALS, PLANNING & DRAWING", "image": "/media/image/work.jpg" },
    { "id": 52, "code": "23MB4062", "name": "CONSTRUCTION PROJECT MANAGEMENT", "image": "/media/image/work.jpg" },
    { "id": 53, "code": "23CE2209R", "name": "TRANSPORTATION ENGINEERING", "image": "/media/image/work.jpg" },
    { "id": 54, "code": "23CE2206", "name": "STRUCTURAL ANALYSIS", "image": "/media/image/work.jpg" },
    { "id": 55, "code": "23CE2208R", "name": "GEOTECHNICAL ENGINEERING", "image": "/media/image/work.jpg" },
    { "id": 56, "code": "23CE2207", "name": "CONCRETE TECHNOLOGY", "image": "/media/image/work.jpg" },
    { "id": 57, "code": "23BT2207A", "name": "BIOANALYTICAL TECHNIQUES", "image": "/media/image/work.jpg" },
    { "id": 58, "code": "23BT2207R", "name": "BIOANALYTICAL TECHNIQUES", "image": "/media/image/work.jpg" },
    { "id": 59, "code": "23BT3214", "name": "BIOINFORMATICS", "image": "/media/image/work.jpg" },
    { "id": 60, "code": "23MT2009", "name": "BIOSTATISTICS", "image": "/media/image/work.jpg" },
    { "id": 61, "code": "23BT2206", "name": "MOLECULAR BIOLOGY", "image": "/media/image/work.jpg" },
    { "id": 62, "code": "23BT2209A", "name": "BIOCHEMICAL REACTION ENGINEERING", "image": "/media/image/work.jpg" },
    { "id": 63, "code": "23BT2209R", "name": "BIOCHEMICAL REACTION ENGINEERING", "image": "/media/image/work.jpg" },
    { "id": 64, "code": "23BT2105A", "name": "IMMUNOLOGY", "image": "/media/image/work.jpg" },
    { "id": 65, "code": "23BT2105R", "name": "IMMUNOLOGY", "image": "/media/image/work.jpg" },
    { "id": 66, "code": "23AD2103R", "name": "SYSTEM DESIGN AND INTRODUCTION TO CLOUD", "image": "/media/image/work.jpg" },
    { "id": 67, "code": "23AD2204A", "name": "DATA MANAGEMENT AND WAREHOUSING", "image": "/media/image/work.jpg" },
    { "id": 68, "code": "23AD2204R", "name": "DATA MANAGEMENT AND WAREHOUSING", "image": "/media/image/work.jpg" },
    { "id": 69, "code": "23AD2205A", "name": "DEEP LEARNING", "image": "/media/image/work.jpg" },
    { "id": 70, "code": "23AD2205R", "name": "DEEP LEARNING", "image": "/media/image/work.jpg" }
];


function SecondYearOddSem() {


    const [search, setSearch] = useState("");
    const [showAll, setShowAll] = useState(false);

    const filteredWorkbookData = SecondYearOddSemData.filter((wb) =>
        wb.name.toLowerCase().includes(search.toLowerCase())
    );
    const displayedData = showAll ? filteredWorkbookData : filteredWorkbookData.slice(0, 20);

    return (
        <>
            <div className="all">
                <div className="ner">
                    <div className="search-bar">
                        <input
                            type="text"
                            placeholder="Search Engineering books..."
                            value={search}
                            onChange={(e) => setSearch(e.target.value)}
                        />
                    </div>
                </div>

                {/* Book Grid */}
                <div className="grid">
                    {displayedData.length > 0 ? (
                        displayedData.map((wb) => (
                            <div key={wb.id} className="card">
                                <img src={wb.image} alt={wb.name} />
                                <h5 className="card-title">{wb.name}</h5>
                                <p className="card-info">{wb.code}</p>
                            </div>
                        ))
                    ) : (
                        <div className="priyanka">
                        <h3>
                            Sorry, this workbook is not available. If you need this workbook, feel free to contact me
                            <a href="https://t.me/Brijeshpriya1409" target="_blank" rel="noopener noreferrer">
                                here on Telegram
                            </a>.
                        </h3>
                    </div>
                    )}
                </div>
                {/* Show More/Less Button */}
                {filteredWorkbookData.length > 20 && (
                    <div className="show-more">
                        <button onClick={() => setShowAll(!showAll)}>
                            {showAll ? "Show Less" : "Show More"}
                        </button>
                    </div>
                )}
            </div>
        </>
    );
}

export default SecondYearOddSem;