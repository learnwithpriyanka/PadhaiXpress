import React from 'react';
import Year from './Year';
import { useCart } from '../../cartcomponent/CartContext';

function FourthYearOddSem() {
    const { cart, dispatch } = useCart();

    return (
        <Year
            year="Fourth"
            sem="Odd"
            placeholder="Search for Fourth Year Odd Semester workbooks..."
            cart={cart}
            dispatch={dispatch}
        />
    );
}

export default FourthYearOddSem;