import React from 'react';
import { Outlet } from 'react-router-dom';
import Footer from '../../Footer';

function WorkbookPage() {
    return (
        <div className="workbook-page">
            <div className="workbook-content">
                <Outlet />
            </div>
            <Footer />
        </div>
    );
}

export default WorkbookPage;