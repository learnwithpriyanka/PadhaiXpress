import React, { useState } from 'react';
import "./WorkBook.css";

const FirstYearOddSemData = [
    { "id": 1, "code": "23MT1001", "name": "LINEAR ALGEBRA & CALCIULUS FOR ENGINEERS", "image": "/media/image/work.jpg" },
    { "id": 2, "code": "24SC1203", "name": "DATA STRUCTURES", "image": "/media/image/work.jpg" },
    { "id": 3, "code": "23EC1203", "name": "BASIC ELECTRICAL AND ELECTRONIC CIRCUITS", "image": "/media/image/work.jpg" },
    { "id": 4, "code": "23EC1202", "name": "DIGITAL DESIGN AND COMPUTER ARCHITECTURE", "image": "/media/image/work.jpg" },
    { "id": 5, "code": "23MET1005", "name": "MATERIAL SCIENCE AND METALLURGY", "image": "/media/image/work.jpg" },
    { "id": 6, "code": "24SC1203", "name": "DATA STRUCTURES USING PYTHON", "image": "/media/image/work.jpg" },
    { "id": 7, "code": "22CE1201", "name": "ENGINEERING GEOLOGY", "image": "/media/image/work.jpg" },
    { "id": 8, "code": "23MT2003", "name": "MATHEMATICAL MODELLING & NUMERICAL METHODS", "image": "/media/image/work.jpg" },
    { "id": 9, "code": "24AD1201", "name": "ARTIFICAL INTELLIGENCE", "image": "/media/image/work.jpg" }
];

function FirstYearOddSem() {
    const [search, setSearch] = useState("");
    const [showAll, setShowAll] = useState(false);

    const filteredWorkbookData = FirstYearOddSemData.filter((wb) =>
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
                        <p>No books found.</p>
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

export default FirstYearOddSem;