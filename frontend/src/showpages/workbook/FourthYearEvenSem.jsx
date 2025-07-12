import React from 'react';
import Year from './Year';
import { useCart } from '../../cartcomponent/CartContext';

function FourthYearEvenSem() {
    const { cart, dispatch } = useCart();

    return (
        <Year
            year="Fourth"
            sem="Even"
            placeholder="Search for Fourth Year Even Semester workbooks..."
            cart={cart}
            dispatch={dispatch}
        />
    );
}

export default FourthYearEvenSem;