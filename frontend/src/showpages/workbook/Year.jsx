import React, { useState, useEffect } from 'react';
import { supabase } from '../../supabaseClient'; // adjust path as needed
import "./WorkBook.css";
import { useCart } from '../../cartcomponent/CartContext';

const Year = ({
  year = "First", // Pass the year as a prop
  sem = "Odd",    // Pass the sem as a prop
  placeholder = "Search...",
  cart = []
}) => {
  const [search, setSearch] = useState("");
  const [products, setProducts] = useState([]);
  const [showAll, setShowAll] = useState(false);
  const [loading, setLoading] = useState(false);
  
  // Get the new cart methods
  const { addToCart, updateCartItem, removeFromCart } = useCart();

  // Fetch products from Supabase based on year, sem, and search
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

  // Limit displayed data if "Show All" is not enabled
  const displayedData = showAll ? products : products.slice(0, 20);

  return (
    <div className="all">
      {/* Search Bar */}
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

      {/* Book Grid */}
      <div className="grid">
        {loading ? (
          <div>Loading...</div>
        ) : displayedData.length > 0 ? (
          displayedData.map((wb) => {
            const cartItem = cart.find((cartItem) => cartItem.product_id === wb.id);
            return (
              <div key={wb.id} className="card">
                <img src={wb.image} alt={wb.name} />
                <h6 className="card-title">{wb.name} ({wb.code})</h6>
                <p className="card-price">Price: ₹{wb.price} &nbsp; &nbsp;   Pages:{wb.pages}</p>
                {/* Conditionally render buttons */}
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

      {/* Show More/Less Button */}
      {products.length > 20 && (
        <div className="show-more">
          <button onClick={() => setShowAll(!showAll)}>
            {showAll ? "Show Less" : "Show More"}
          </button>
        </div>
      )}
    </div>
  );
};

export default Year;