import React from 'react';

import "./WorkBook.css";
import { useState } from 'react';

const ThirdYearOddSemData = [
    { "id": 1, "code": "22PH4101", "name": "QUANTUM PHYSICS FOR ENGINEERS", "image": "/media/image/work.jpg" },
    { "id": 2, "code": "22PH4102", "name": "APPLIED PHYSICS", "image": "/media/image/work.jpg" },
    { "id": 3, "code": "222CS2221F", "name": "UX DESIGN", "image": "/media/image/work.jpg" },
    { "id": 4, "code": "22CS2224F", "name": "CRYPT ANALYSIS & CYBER DEFENSE", "image": "/media/image/work.jpg" },
    { "id": 5, "code": "22CS2227F", "name": "DATA ANALYTICS AND VISUALIZATION", "image": "/media/image/work.jpg" },
    { "id": 6, "code": "22CS2228F", "name": "CROSS-PLATFORM USER EXPERIENCE DESIGN", "image": "/media/image/work.jpg" },
    { "id": 7, "code": "22CS2247F", "name": "CRYPTOGRAPHY AND SECURITY", "image": "/media/image/work.jpg" },
    { "id": 8, "code": "22CS2247M", "name": "CRYPTOGRAPHY AND SECURITY", "image": "/media/image/work.jpg" },
    { "id": 9, "code": "22CS2233F", "name": "INTRODUCTION TO BLOCKCHAIN AND CRYPTO CURRENCIES", "image": "/media/image/work.jpg" },
    { "id": 10, "code": "22CS2234F", "name": "NETWORK & INFRASTRUCTURE SECURITY", "image": "/media/image/work.jpg" },
    { "id": 11, "code": "22CS2235F", "name": "COMPILER DESIGN", "image": "/media/image/work.jpg" },
    { "id": 12, "code": "22CS2235M", "name": "COMPILER DESIGN", "image": "/media/image/work.jpg" },
    { "id": 13, "code": "22CS2237F", "name": "QUANTUM COMPUTING", "image": "/media/image/work.jpg" },
    { "id": 14, "code": "22CS2239F", "name": "SOFTWARE VERIFICATION & VALIDATION", "image": "/media/image/work.jpg" },
    { "id": 15, "code": "22CS2229F", "name": "APPLICATION DEVELOPMENT ON CLOUD", "image": "/media/image/work.jpg" },
    { "id": 16, "code": "22CS2230F", "name": "SOLUTIONS ARCHITECTING ON CLOUD", "image": "/media/image/work.jpg" },
    { "id": 17, "code": "22CS2231F", "name": "VISUAL PROGRAMING", "image": "/media/image/work.jpg" },
    { "id": 18, "code": "22CS2240F", "name": ".NET PROGRAMMING (EPAM)", "image": "/media/image/work.jpg" },
    { "id": 19, "code": "22CS2241F", "name": "FRONT END WEB DEVELOPMENT (EPAM)", "image": "/media/image/work.jpg" },
    { "id": 20, "code": "22CS2242F", "name": "SOFTWARE TESTING (EPAM)", "image": "/media/image/work.jpg" },
    { "id": 21, "code": "22CS2243F", "name": "CLOUD DEVOPS (EPAM)", "image": "/media/image/work.jpg" },
    { "id": 22, "code": "22CY1001", "name": "ENGINEERING CHEMISTRY", "image": "/media/image/work.jpg" },
    { "id": 23, "code": "22CY1004", "name": "ORGANIC ELECTRONICS", "image": "/media/image/work.jpg" },
    { "id": 24, "code": "22EC3213A", "name": "CONTROL SYSTEMS", "image": "/media/image/work.jpg" },
    { "id": 25, "code": "22EC3213R", "name": "CONTROL SYSTEMS", "image": "/media/image/work.jpg" },
    { "id": 26, "code": "22AIP3305A", "name": "DEEP LEARNING", "image": "/media/image/work.jpg" },
    { "id": 27, "code": "22AIP3305R", "name": "DEEP LEARNING", "image": "/media/image/work.jpg" },
    { "id": 28, "code": "22CSB3304A", "name": "DIGITAL FORENSICS", "image": "/media/image/work.jpg" },
    { "id": 29, "code": "22CSB3304R", "name": "DIGITAL FORENSICS", "image": "/media/image/work.jpg" },
    { "id": 30, "code": "22DCS3303A", "name": "5G WIRELESS TECHNOLOGIES", "image": "/media/image/work.jpg" },
    { "id": 31, "code": "22DSB3303A", "name": "BIG DATA ANALYTICS", "image": "/media/image/work.jpg" },
    { "id": 32, "code": "22DSB3303R", "name": "BIG DATA ANALYTICS", "image": "/media/image/work.jpg" },
    { "id": 33, "code": "22EDS3303A", "name": "EMBEDDED AND REAL-TIME SYSTEMS", "image": "/media/image/work.jpg" },
    { "id": 34, "code": "22EDS3303R", "name": "EMBEDDED AND REAL-TIME SYSTEMS", "image": "/media/image/work.jpg" },
    { "id": 35, "code": "22SMD3303R", "name": "CONTINUOUS DELIVERY & DEVOPS", "image": "/media/image/work.jpg" },
    { "id": 36, "code": "22VLS3303R", "name": "VLSI PHYSICAL DESIGN AUTOMATION", "image": "/media/image/work.jpg" },
    { "id": 37, "code": "22VLS3303A", "name": "VLSI PHYSICAL DESIGN AUTOMATION", "image": "/media/image/work.jpg" },
    { "id": 38, "code": "22EE3209R", "name": "AI TECHNIQUES FOR ELECTRICAL ENGINEERING", "image": "/media/image/work.jpg" },
    { "id": 39, "code": "22EE3208R", "name": "POWER SYSTEM PROTECTION & CONTROL", "image": "/media/image/work.jpg" },
    { "id": 40, "code": "22ASS3309A", "name": "AUTONOMOUS ELECTRIC MOBILITY-SYSTEMS AND APPLICATIONS", "image": "/media/image/work.jpg" },
    { "id": 41, "code": "22CEC3305R", "name": "CLOUD & SERVERLESS COMPUTING", "image": "/media/image/work.jpg" },
    { "id": 42, "code": "22GET3304R", "name": "GRID INTEGRATION OF RENEWABLE ENERGY SOURCES", "image": "/media/image/work.jpg" },
    { "id": 43, "code": "22ME3112", "name": "THERMAL SYSTEMS ENGINEERING", "image": "/media/image/work.jpg" },
    { "id": 44, "code": "22ME3214R", "name": "MACHINE DESIGN", "image": "/media/image/work.jpg" },
    { "id": 45, "code": "22EGD3304A", "name": "SUSTAINABLE DESIGN & SOCIAL INNOVATION IN ENGINEERING DESIGN", "image": "/media/image/work.jpg" },
    { "id": 46, "code": "22EGD3304R", "name": "SUSTAINABLE DESIGN & SOCIAL INNOVATION IN ENGINEERING DESIGN", "image": "/media/image/work.jpg" },
    { "id": 47, "code": "22SMF3304R", "name": "SUSTAINABLE DESIGN & SOCIAL INNOVATION IN SMART MANUFACTURING", "image": "/media/image/work.jpg" },
    { "id": 48, "code": "22ME3215", "name": "DIGITAL MANUFACTURING & ROBOTICS", "image": "/media/image/work.jpg" }
];
function ThirdYearOddSem() {
    const [search, setSearch] = useState("");
    const [showAll, setShowAll] = useState(false);
    
        const filteredWorkbookData = ThirdYearOddSemData.filter((wb) =>
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

export default ThirdYearOddSem;