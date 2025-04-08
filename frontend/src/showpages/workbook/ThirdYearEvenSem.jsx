import React from 'react';
import { useCart } from '../../cartcomponent/CartContext'; // Ensure CartContext is properly set up
import Year from './Year';
import {ThirdYearOddSemData} from './ThirdYearOddSem'; // Adjust the import path as necessary




function ThirdYearEvenSem() {
   
    const { cart, dispatch } = useCart();

    return (
        <Year
            data={ThirdYearOddSemData}
            placeholder="Search for Second Year Odd Semester workbooks..."
            cart={cart}
            dispatch={dispatch}
        />
    );
        


}

export default ThirdYearEvenSem;