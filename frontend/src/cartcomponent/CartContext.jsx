import React, { createContext, useContext, useReducer, useEffect } from 'react';
import { supabase } from '../supabaseClient';
import { useToast } from '../components/ToastContext';

const CartContext = createContext();

const cartReducer = (state, action) => {
  switch (action.type) {
    case 'SET_CART':
      return action.payload;
    case 'ADD_TO_CART':
      return [...state, action.payload];
    case 'UPDATE_CART_ITEM':
      return state.map(item =>
        item.id === action.payload.id ? { ...item, ...action.payload } : item
      );
    case 'REMOVE_FROM_CART':
      return state.filter(item => item.id !== action.payload);
    case 'CLEAR_CART':
      return [];
    default:
      return state;
  }
};

export const CartProvider = ({ children }) => {
  const [cart, dispatch] = useReducer(cartReducer, []);

  // Load cart from Supabase on mount
  useEffect(() => {
    const fetchCart = async () => {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;
      const { data, error } = await supabase
        .from('cart_items')
        .select('*, product:product_id(*)') // JOIN with products table
        .eq('user_id', user.id);
      if (!error) {
        dispatch({ type: 'SET_CART', payload: data });
      }
    };
    fetchCart();
    // Optionally, listen for auth changes and refetch cart
    const { data: listener } = supabase.auth.onAuthStateChange((_event, session) => {
      if (session?.user) fetchCart();
      else dispatch({ type: 'SET_CART', payload: [] });
    });
    return () => { listener?.unsubscribe(); };
  }, []);

  // Add to cart
  const addToCart = async (product) => {
    console.log('addToCart called with product:', product);
    
    try {
      const { data: { user } } = await supabase.auth.getUser();
      console.log('Current user:', user);
      
      if (!user) {
        console.log('No user found, redirecting to sign in');
        window.location.replace('/signin'); // Use replace for robust redirect
        return;
      }
      
      // Check if already in cart
      const { data: existing, error: existingError } = await supabase
        .from('cart_items')
        .select('*, product:product_id(*)')
        .eq('user_id', user.id)
        .eq('product_id', product.id)
        .single();
          
      console.log('Existing cart item:', existing);
      console.log('Existing error:', existingError);
      
      if (existing) {
        // If already in cart, increase quantity
        console.log('Item exists, updating quantity');
        const { data, error } = await supabase
          .from('cart_items')
          .update({ quantity: existing.quantity + 1 })
          .eq('id', existing.id)
          .select('*, product:product_id(*)')
          .single();
        console.log('Update result:', data, error);
        if (!error) {
          dispatch({ type: 'UPDATE_CART_ITEM', payload: data });
        } else {
          console.error('Error updating cart item:', error);
        }
      } else {
        // If not in cart, insert new
        console.log('Item does not exist, inserting new');
        const { data, error } = await supabase
          .from('cart_items')
          .insert([{
            user_id: user.id,
            product_id: product.id,
            quantity: 1,
            page_type: product.pageType || 'double',
          }])
          .select('*, product:product_id(*)')
          .single();
        console.log('Insert result:', data, error);
        if (!error) {
          dispatch({ type: 'ADD_TO_CART', payload: data });
        } else {
          console.error('Error adding item to cart:', error);
        }
      }
    } catch (error) {
      console.error('Error in addToCart:', error);
    }
  };

  // Update cart item (quantity, page_type, etc.)
  const updateCartItem = async (id, updates) => {
    const { data, error } = await supabase
      .from('cart_items')
      .update(updates)
      .eq('id', id)
      .select('*, product:product_id(*)') // JOIN with products table
      .single();
    if (!error) dispatch({ type: 'UPDATE_CART_ITEM', payload: data });
  };

  // Remove from cart
  const removeFromCart = async (id) => {
    const { error } = await supabase
      .from('cart_items')
      .delete()
      .eq('id', id);
    if (!error) dispatch({ type: 'REMOVE_FROM_CART', payload: id });
  };

  // Clear cart
  const clearCart = async (user_id) => {
    const { error } = await supabase
      .from('cart_items')
      .delete()
      .eq('user_id', user_id);
    if (!error) dispatch({ type: 'CLEAR_CART' });
  };

  return (
    <CartContext.Provider value={{
      cart,
      addToCart,
      updateCartItem,
      removeFromCart,
      clearCart,
      dispatch // for legacy compatibility
    }}>
      {children}
    </CartContext.Provider>
  );
};

export const useCart = () => useContext(CartContext);