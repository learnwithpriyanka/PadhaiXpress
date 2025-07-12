import React from 'react';
import Year from './Year';
import { useCart } from '../../cartcomponent/CartContext';

function ThirdYearEvenSem() {
    const { cart, dispatch } = useCart();

    return (
        <Year
            year="Third"
            sem="Even"
            placeholder="Search for Third Year Even Semester workbooks..."
            cart={cart}
            dispatch={dispatch}
        />
    );
}

export default ThirdYearEvenSem;