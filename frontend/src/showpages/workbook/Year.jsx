import React, { useState } from 'react';
import "./WorkBook.css";

const Year = ({ data = [], placeholder = "Search...", cart = [], dispatch }) => {
    const [search, setSearch] = useState("");
    const [showAll, setShowAll] = useState(false);

    // Filter workbooks based on search input
    const filteredWorkbookData = data.filter((wb) =>
        wb.name.toLowerCase().includes(search.toLowerCase())
    );

    // Limit displayed data if "Show All" is not enabled
    const displayedData = showAll ? filteredWorkbookData : filteredWorkbookData.slice(0, 20);

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
                {displayedData.length > 0 ? (
                    displayedData.map((wb) => {
                        const cartItem = cart.find((cartItem) => cartItem.id=== wb.id);
                        return (
                            <div key={wb.id} className="card">
                                <img src={wb.image} alt={wb.name} />
                                <h6 className="card-title">{wb.name} ({wb.code})</h6>
                                <p className="card-price">Price: ₹{wb.price}</p>
                                {/* Conditionally render buttons */}
                                {cartItem ? (
                                    <div className="cart-controls">
                                        <button
                                            onClick={() => dispatch({ type: 'DECREASE', payload: wb.id })}
                                            aria-label="Decrease quantity"
                                        >
                                            -
                                        </button>
                                        <span>{cartItem.quantity}</span>
                                        <button
                                            onClick={() => dispatch({ type: 'INCREASE', payload: wb.id })}
                                            aria-label="Increase quantity"
                                        >
                                            +
                                        </button>
                                        <button
                                            onClick={() => dispatch({ type: 'REMOVE', payload: wb.id })}
                                            aria-label="Remove item"
                                            className='deletebutton'
                                        >
                                            Delete
                                        </button>
                                    </div>
                                ) : (
                                    <button
                                        className="addtocart"
                                        onClick={() => dispatch({ type: 'ADD_TO_CART', payload: wb })}
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
            {filteredWorkbookData.length > 20 && (
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