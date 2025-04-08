import React from 'react';
import { Outlet } from 'react-router-dom';

import Footer from '../../Footer';



function WorkbookPage() {
    return (
        <>
            <div>

                <Outlet />

            </div>
            <Footer />
        </>
    );
}

export default WorkbookPage;