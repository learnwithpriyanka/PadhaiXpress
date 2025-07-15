import React, { useState, useEffect } from 'react';
import { supabase } from '../../supabaseClient';
import "./WorkBook.css";
import { useCart } from '../../cartcomponent/CartContext';

const Year = ({
  year = "First",
  sem = "Odd",
  placeholder = "Search workbooks...",
  cart = []
}) => {
  const [search, setSearch] = useState("");
  const [products, setProducts] = useState([]);
  const [showAll, setShowAll] = useState(false);
  const [loading, setLoading] = useState(false);
  
  const { addToCart, updateCartItem, removeFromCart } = useCart();

  useEffect(() => {
    const fetchProducts = async () => {
      setLoading(true);
      let query = supabase
        .from('products')
        .select('*')
        .eq('year', year)
        .eq('sem', sem);

      if (search.trim()) {
        query = query.ilike('name', `%${search}%`);
      }

      const { data, error } = await query;
      if (!error) setProducts(data || []);
      setLoading(false);
    };
    fetchProducts();
  }, [year, sem, search]);

  const displayedData = showAll ? products : products.slice(0, 20);

  return (
    <div className="year-page">
      <div className="year-content">
        <div className="all">
          <div className="ner">
            <div className="search-bar">
              <input
                type="text"
                placeholder={placeholder}
                value={search}
                onChange={(e) => setSearch(e.target.value)}
              />
            </div>
          </div>

          <div className="grid">
            {loading ? (
              <div style={{
                gridColumn: '1 / -1',
                textAlign: 'center',
                padding: '3rem',
                color: 'white',
                fontSize: '1.2rem',
                fontWeight: '600'
              }}>
                <div style={{
                  display: 'inline-block',
                  width: '40px',
                  height: '40px',
                  border: '4px solid rgba(255,255,255,0.3)',
                  borderTop: '4px solid white',
                  borderRadius: '50%',
                  animation: 'spin 1s linear infinite',
                  marginBottom: '1rem'
                }}></div>
                Loading workbooks...
              </div>
            ) : displayedData.length > 0 ? (
              displayedData.map((wb, index) => {
                const cartItem = cart.find((cartItem) => cartItem.product_id === wb.id);
                return (
                  <div 
                    key={wb.id} 
                    className="card"
                    style={{
                      animationDelay: `${index * 0.1}s`
                    }}
                  >
                    <img src={wb.image} alt={wb.name} />
                    <h6 className="card-title">{wb.name} ({wb.code})</h6>
                    <p className="card-price">Price: ₹{wb.price} &nbsp; &nbsp;   Pages:{wb.pages}</p>
                    
                    {cartItem ? (
                      <div className="cart-controls">
                        <button
                          onClick={() => updateCartItem(cartItem.id, { quantity: cartItem.quantity - 1 })}
                          aria-label="Decrease quantity"
                          disabled={cartItem.quantity <= 1}
                        >
                          -
                        </button>
                        <span>{cartItem.quantity}</span>
                        <button
                          onClick={() => updateCartItem(cartItem.id, { quantity: cartItem.quantity + 1 })}
                          aria-label="Increase quantity"
                        >
                          +
                        </button>
                        <button
                          onClick={() => removeFromCart(cartItem.id)}
                          aria-label="Remove item"
                          className='deletebutton'
                        >
                          Delete
                        </button>
                      </div>
                    ) : (
                      <button
                        className="addtocart"
                        onClick={() => {
                          console.log('Add to cart button clicked for product:', wb);
                          addToCart(wb);
                        }}
                        aria-label="Add to cart"
                      >
                        Add to Cart
                      </button>
                    )}
                  </div>
                );
              })
            ) : (
              <div className="priyanka">
                <h3>
                  Sorry, this workbook is not available. If you need this workbook, feel free to contact me
                  <a href="https://t.me/Brijeshpriya1409" target="_blank" rel="noopener noreferrer">
                    here on Telegram
                  </a>.
                </h3>
              </div>
            )}
          </div>

          {products.length > 20 && (
            <div className="show-more">
              <button onClick={() => setShowAll(!showAll)}>
                {showAll ? "Show Less" : "Show More"}
              </button>
            </div>
          )}

          <style jsx>{`
            @keyframes spin {
              0% { transform: rotate(0deg); }
              100% { transform: rotate(360deg); }
            }
          `}</style>
        </div>
      </div>
    </div>
  );
};

export default Year;