import React, { useState } from 'react';
import "./Year1.css";
import { useNavigate } from "react-router-dom";

function Year1() {
    const [year, setYear] = useState('');
    const [semester, setSemester] = useState('');
    const navigate = useNavigate();


    const handleReset = () => {
        setYear('');
        setSemester('');
    };

    const handleNext = () => {
        if (year && semester) {
            if(year === '1' && semester === '1') {
                navigate("/workbook/year1/firstyearoddsem");
            }else if(year === '1' && semester === '2') {
                navigate("/workbook/year1/firstyearevensem");
            }else if(year === '2' && semester === '1') {
                navigate("/workbook/year1/secondyearoddsem");
            }
            else if(year === '2' && semester === '2') {
                navigate("/workbook/year1/secondyearevensem");
            }
            else if(year === '3' && semester === '1') {
                navigate("/workbook/year1/thirdyearoddsem");
            }
            else if(year === '3' && semester === '2') {
                navigate("/workbook/year1/thirdyearevensem");
            }
            else if(year === '4' && semester === '1') {
                navigate("/workbook/year1/fourthyearoddsem");
            }
            else if(year === '4' && semester === '2') {
                navigate("/workbook/year1/fourthyearevensem");
            }
            else{
            alert(`Selected Year: ${year}, Semester: ${semester}`);
            }
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
                            <option value="">Select Year</option>
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
                            <option value="">Select Semester</option>
                            <option value="1">Odd Sem</option>
                            <option value="2">Even Sem</option>
                        </select>
                    </div>
                    <div className="buttons">
                        
                        <button onClick={handleReset}>Reset</button>
                        <button onClick={handleNext}>Next</button>
                    </div>
                </div>
            </div>
        </>
    );
}

export default Year1;