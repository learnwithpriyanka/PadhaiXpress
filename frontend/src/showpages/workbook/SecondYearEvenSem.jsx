import React from 'react';
import Year from './Year';
import { useCart } from '../../cartcomponent/CartContext';

function SecondYearEvenSem() {
    const { cart, dispatch } = useCart();

    return (
        <Year
            year="Second"
            sem="Even"
            placeholder="Search for Second Year Even Semester workbooks..."
            cart={cart}
            dispatch={dispatch}
        />
    );
}

export default SecondYearEvenSem;