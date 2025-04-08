import React from 'react';
import { useCart } from '../../cartcomponent/CartContext'; // Ensure CartContext is properly set up
import Year from './Year';
import {SecondYearOddSemData} from './SecondYearOddSem'; // Adjust the import path as necessary




function SecondYearEvenSem() {
    const { cart, dispatch } = useCart();

    return (
        <Year
            data={SecondYearOddSemData}
            placeholder="Search for Second Year Odd Semester workbooks..."
            cart={cart}
            dispatch={dispatch}
        />
    );
}




export default SecondYearEvenSem;