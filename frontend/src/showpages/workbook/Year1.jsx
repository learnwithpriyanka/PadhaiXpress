import React, { useState } from 'react';
import "./Year1.css";

function Year1() {
    const [year, setYear] = useState('');
    const [semester, setSemester] = useState('');

    const handleReset = () => {
        setYear('');
        setSemester('');
    };

    const handleNext = () => {
        if (year && semester) {
            alert(`Selected Year: ${year}, Semester: ${semester}`);
        } else {
            alert('Please select both Year and Semester.');
        }
    };

    return (
        <>
            <div className="year1">
                <div className="year1-card">
                    <h1>Select Year and Semester</h1>
                    <div>
                        <label htmlFor="year">Year: </label>
                        <select
                            id="year"
                            value={year}
                            onChange={(e) => setYear(e.target.value)}
                        >
                            <option value="">--Select Year--</option>
                            <option value="1">1st Year</option>
                            <option value="2">2nd Year</option>
                            <option value="3">3rd Year</option>
                            <option value="4">4th Year</option>
                        </select>
                    </div>
                    <div>
                        <label htmlFor="semester">Semester: </label>
                        <select
                            id="semester"
                            value={semester}
                            onChange={(e) => setSemester(e.target.value)}
                        >
                            <option value="">--Select Semester--</option>
                            <option value="1">1st Semester</option>
                            <option value="2">2nd Semester</option>
                        </select>
                    </div>
                    <div className="buttons">
                        <button onClick={handleNext}>Next</button>
                        <button onClick={handleReset}>Reset</button>
                    </div>
                </div>
            </div>
        </>
    );
}

export default Year1;