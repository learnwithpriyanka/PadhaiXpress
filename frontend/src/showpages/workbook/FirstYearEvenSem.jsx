import React from 'react';
import Year from './Year'; // Ensure the correct import path for Year
import { useCart } from '../../cartcomponent/CartContext'; // Ensure the correct import path for CartContext

function FirstYearEvenSem() {
  const { cart, dispatch } = useCart();
  return (
    <Year
      year="First"
      sem="Even"
      placeholder="Search for First Year Even Semester workbooks..."
      cart={cart}
      dispatch={dispatch}
    />
  );
}

export default FirstYearEvenSem; 