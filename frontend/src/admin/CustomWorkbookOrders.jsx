import React, { useState, useEffect } from 'react';
import { supabase } from '../supabaseClient';
import { Search, Filter, RefreshCw, Eye, X, Package, User, FileText } from 'lucide-react';
import './CustomWorkbookOrders.css';

const CustomWorkbookOrders = () => {
    const [orders, setOrders] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [statusFilter, setStatusFilter] = useState('all');
    const [selectedOrder, setSelectedOrder] = useState(null);
    const [updatingStatus, setUpdatingStatus] = useState(false);
    const [searchTerm, setSearchTerm] = useState('');

    // Status options for the order
    const statusOptions = [
        { value: 'uploaded', label: 'Uploaded', color: '#2196F3' },
        { value: 'in_print', label: 'In Print', color: '#FF9800' },
        { value: 'printed', label: 'Printed', color: '#9C27B0' },
        { value: 'out_for_delivery', label: 'Out for Delivery', color: '#3F51B5' },
        { value: 'delivered', label: 'Delivered', color: '#4CAF50' },
        { value: 'cancelled', label: 'Cancelled', color: '#F44336' }
    ];

    // Fetch orders from Supabase
    const fetchOrders = async () => {
        try {
            setLoading(true);
            setError(null);

            let query = supabase
                .from('custom_workbook_orders')
                .select('*')
                .order('placed_at', { ascending: false });

            // Apply status filter if not 'all'
            if (statusFilter !== 'all') {
                query = query.eq('status', statusFilter);
            }

            const { data, error } = await query;

            if (error) throw error;

            setOrders(data || []);
        } catch (err) {
            console.error('Error fetching orders:', err);
            setError('Failed to load orders. Please try again.');
        } finally {
            setLoading(false);
        }
    };

    // Update order status
    const updateOrderStatus = async (orderId, newStatus) => {
        try {
            setUpdatingStatus(true);

            const { error } = await supabase
                .from('custom_workbook_orders')
                .update({ 
                    status: newStatus
                })
                .eq('id', orderId);

            if (error) throw error;

            // Update local state
            setOrders(orders.map(order => 
                order.id === orderId ? { ...order, status: newStatus } : order
            ));

            // Close modal if open
            if (selectedOrder && selectedOrder.id === orderId) {
                setSelectedOrder({ ...selectedOrder, status: newStatus });
            }

            alert(`Order #${orderId} status updated to ${newStatus}`);
        } catch (err) {
            console.error('Error updating order status:', err);
            alert(`Failed to update order status: ${err.message}`);
        } finally {
            setUpdatingStatus(false);
        }
    };

    // Format date
    const formatDate = (dateString) => {
        const options = { 
            year: 'numeric', 
            month: 'short', 
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        };
        return new Date(dateString).toLocaleDateString('en-IN', options);
    };

    // Get status info
    const getStatusInfo = (status) => {
        const statusInfo = statusOptions.find(option => option.value === status);
        return statusInfo || { label: status, color: '#999' };
    };

    // Filter orders based on search term
    const filteredOrders = orders.filter(order =>
        order.delivery_name.toLowerCase().includes(searchTerm.toLowerCase()) ||
        order.id.toString().includes(searchTerm) ||
        order.phone.includes(searchTerm)
    );

    // Open order details modal
    const openOrderDetails = (order) => {
        setSelectedOrder(order);
    };

    // Close order details modal
    const closeOrderDetails = () => {
        setSelectedOrder(null);
    };

    // Effect to fetch orders on component mount and when filter changes
    useEffect(() => {
        fetchOrders();
    }, [statusFilter]);

    return (
        <div className="workbook-orders-container">
            <div className="workbook-orders-wrapper">
                {/* Header */}
                <div className="header-section">
                    <h1 className="main-title">Custom Workbook Orders</h1>
                    <p className="subtitle">Manage and track all custom workbook orders</p>
                </div>

                {/* Controls */}
                <div className="controls-section">
                    <div className="controls-wrapper">
                        {/* Search and Filter */}
                        <div className="search-filter-group">
                            {/* Search */}
                            <div className="search-container">
                                <Search className="search-icon" />
                                <input
                                    type="text"
                                    placeholder="Search orders..."
                                    value={searchTerm}
                                    onChange={(e) => setSearchTerm(e.target.value)}
                                    className="search-input"
                                />
                            </div>

                            {/* Status Filter */}
                            <div className="filter-container">
                                <Filter className="filter-icon" />
                                <select 
                                    value={statusFilter} 
                                    onChange={(e) => setStatusFilter(e.target.value)}
                                    className="filter-select"
                                >
                                    <option value="all">All Status</option>
                                    {statusOptions.map(option => (
                                        <option key={option.value} value={option.value}>
                                            {option.label}
                                        </option>
                                    ))}
                                </select>
                            </div>
                        </div>

                        {/* Refresh Button */}
                        <button 
                            className={`refresh-btn ${loading ? 'loading' : ''}`}
                            onClick={fetchOrders} 
                            disabled={loading}
                        >
                            <RefreshCw className={`refresh-icon ${loading ? 'spinning' : ''}`} />
                            {loading ? 'Loading...' : 'Refresh'}
                        </button>
                    </div>
                </div>

                {/* Error Message */}
                {error && (
                    <div className="error-container">
                        <div className="error-message">{error}</div>
                    </div>
                )}

                {/* Orders Content */}
                {!loading && filteredOrders.length === 0 ? (
                    <div className="no-orders-container">
                        <Package className="no-orders-icon" />
                        <h3 className="no-orders-title">No orders found</h3>
                        <p className="no-orders-text">
                            {searchTerm ? 'Try adjusting your search terms' : statusFilter !== 'all' ? `No orders with status "${getStatusInfo(statusFilter).label}"` : 'No orders have been placed yet'}
                        </p>
                    </div>
                ) : (
                    <div className="orders-table-container">
                        {/* Desktop Table */}
                        <div className="desktop-table">
                            <table className="orders-table">
                                <thead className="table-header">
                                    <tr>
                                        <th className="table-th">Order ID</th>
                                        <th className="table-th">Customer</th>
                                        <th className="table-th">Pages</th>
                                        <th className="table-th">Amount</th>
                                        <th className="table-th">Placed On</th>
                                        <th className="table-th">Status</th>
                                        <th className="table-th">Actions</th>
                                    </tr>
                                </thead>
                                <tbody className="table-body">
                                    {loading ? (
                                        <tr>
                                            <td colSpan="7" className="loading-cell">
                                                <div className="loading-content">
                                                    <RefreshCw className="loading-spinner" />
                                                    Loading orders...
                                                </div>
                                            </td>
                                        </tr>
                                    ) : (
                                        filteredOrders.map(order => (
                                            <tr key={order.id} className="table-row">
                                                <td className="table-cell font-medium">#{order.id}</td>
                                                <td className="table-cell">{order.delivery_name}</td>
                                                <td className="table-cell">{order.pages}</td>
                                                <td className="table-cell font-medium">₹{order.total_amount}</td>
                                                <td className="table-cell text-muted">{formatDate(order.placed_at)}</td>
                                                <td className="table-cell">
                                                    <span 
                                                        className="status-badge"
                                                        style={{ backgroundColor: getStatusInfo(order.status).color }}
                                                    >
                                                        {getStatusInfo(order.status).label}
                                                    </span>
                                                </td>
                                                <td className="table-cell">
                                                    <button 
                                                        className="view-btn"
                                                        onClick={() => openOrderDetails(order)}
                                                    >
                                                        <Eye className="view-icon" />
                                                        View
                                                    </button>
                                                </td>
                                            </tr>
                                        ))
                                    )}
                                </tbody>
                            </table>
                        </div>

                        {/* Mobile Cards */}
                        <div className="mobile-cards">
                            {loading ? (
                                <div className="mobile-loading">
                                    <RefreshCw className="mobile-loading-spinner" />
                                    Loading orders...
                                </div>
                            ) : (
                                <div className="mobile-cards-list">
                                    {filteredOrders.map(order => (
                                        <div key={order.id} className="mobile-card">
                                            <div className="mobile-card-header">
                                                <span className="mobile-order-id">#{order.id}</span>
                                                <span 
                                                    className="mobile-status-badge"
                                                    style={{ backgroundColor: getStatusInfo(order.status).color }}
                                                >
                                                    {getStatusInfo(order.status).label}
                                                </span>
                                            </div>
                                            <div className="mobile-card-content">
                                                <div className="mobile-info-row">
                                                    <span className="mobile-label">Customer:</span>
                                                    <span className="mobile-value">{order.delivery_name}</span>
                                                </div>
                                                <div className="mobile-info-row">
                                                    <span className="mobile-label">Amount:</span>
                                                    <span className="mobile-value font-medium">₹{order.total_amount}</span>
                                                </div>
                                                <div className="mobile-info-row">
                                                    <span className="mobile-label">Pages:</span>
                                                    <span className="mobile-value">{order.pages}</span>
                                                </div>
                                                <div className="mobile-info-row">
                                                    <span className="mobile-label">Placed:</span>
                                                    <span className="mobile-value">{formatDate(order.placed_at)}</span>
                                                </div>
                                            </div>
                                            <button 
                                                className="mobile-view-btn"
                                                onClick={() => openOrderDetails(order)}
                                            >
                                                <Eye className="mobile-view-icon" />
                                                View Details
                                            </button>
                                        </div>
                                    ))}
                                </div>
                            )}
                        </div>
                    </div>
                )}

                {/* Order Details Modal */}
                {selectedOrder && (
                    <div className="modal-overlay">
                        <div className="modal-container">
                            {/* Modal Header */}
                            <div className="modal-header">
                                <h2 className="modal-title">Order #{selectedOrder.id} Details</h2>
                                <button 
                                    className="modal-close-btn"
                                    onClick={closeOrderDetails}
                                >
                                    <X className="modal-close-icon" />
                                </button>
                            </div>

                            {/* Modal Body */}
                            <div className="modal-body">
                                <div className="modal-grid">
                                    {/* Order Information */}
                                    <div className="info-section order-info">
                                        <div className="section-header">
                                            <Package className="section-icon" />
                                            <h3 className="section-title">Order Information</h3>
                                        </div>
                                        <div className="info-list">
                                            <div className="info-item">
                                                <span className="info-label">Status</span>
                                                <span 
                                                    className="status-badge"
                                                    style={{ backgroundColor: getStatusInfo(selectedOrder.status).color }}
                                                >
                                                    {getStatusInfo(selectedOrder.status).label}
                                                </span>
                                            </div>
                                            <div className="info-item">
                                                <span className="info-label">Pages</span>
                                                <span className="info-value">{selectedOrder.pages}</span>
                                            </div>
                                            <div className="info-item">
                                                <span className="info-label">Amount</span>
                                                <span className="info-value">₹{selectedOrder.total_amount}</span>
                                            </div>
                                            <div className="info-item">
                                                <span className="info-label">Payment Method</span>
                                                <span className="info-value">
                                                    {selectedOrder.payment_method === 'cod' ? 'Cash on Delivery' : selectedOrder.payment_method}
                                                </span>
                                            </div>
                                            <div className="info-item">
                                                <span className="info-label">Placed On</span>
                                                <span className="info-value">{formatDate(selectedOrder.placed_at)}</span>
                                            </div>
                                        </div>
                                    </div>

                                    {/* Customer Information */}
                                    <div className="info-section customer-info">
                                        <div className="section-header">
                                            <User className="section-icon" />
                                            <h3 className="section-title">Customer Information</h3>
                                        </div>
                                        <div className="info-list">
                                            <div className="info-item-vertical">
                                                <span className="info-label">Name</span>
                                                <span className="info-value">{selectedOrder.delivery_name}</span>
                                            </div>
                                            <div className="info-item-vertical">
                                                <span className="info-label">Phone</span>
                                                <span className="info-value">{selectedOrder.phone}</span>
                                            </div>
                                            <div className="info-item-vertical">
                                                <span className="info-label">Address</span>
                                                <span className="info-value">{selectedOrder.address}</span>
                                            </div>
                                            <div className="info-item">
                                                <span className="info-label">Pincode</span>
                                                <span className="info-value">{selectedOrder.pincode}</span>
                                            </div>
                                            {selectedOrder.landmark && (
                                                <div className="info-item-vertical">
                                                    <span className="info-label">Landmark</span>
                                                    <span className="info-value">{selectedOrder.landmark}</span>
                                                </div>
                                            )}
                                        </div>
                                    </div>
                                </div>

                                {/* File Section */}
                                <div className="info-section file-section">
                                    <div className="section-header">
                                        <FileText className="section-icon" />
                                        <h3 className="section-title">Workbook File</h3>
                                    </div>
                                    <a 
                                        href={selectedOrder.pdf_file_url} 
                                        target="_blank" 
                                        rel="noopener noreferrer"
                                        className="download-btn"
                                    >
                                        <FileText className="download-icon" />
                                        View/Download PDF
                                    </a>
                                </div>

                                {/* Status Update Section */}
                                <div className="info-section status-section">
                                    <div className="section-header">
                                        <RefreshCw className="section-icon" />
                                        <h3 className="section-title">Update Status</h3>
                                    </div>
                                    <div className="status-buttons-grid">
                                        {statusOptions.map(option => (
                                            <button
                                                key={option.value}
                                                className={`status-update-btn ${selectedOrder.status === option.value ? 'active' : ''}`}
                                                style={selectedOrder.status === option.value ? 
                                                    { backgroundColor: option.color, color: 'white', borderColor: option.color } : 
                                                    { backgroundColor: option.color + '20', color: option.color, borderColor: option.color + '40' }
                                                }
                                                onClick={() => updateOrderStatus(selectedOrder.id, option.value)}
                                                disabled={updatingStatus || selectedOrder.status === option.value}
                                            >
                                                {option.label}
                                            </button>
                                        ))}
                                    </div>
                                    {updatingStatus && (
                                        <div className="updating-status">
                                            <RefreshCw className="updating-spinner" />
                                            Updating status...
                                        </div>
                                    )}
                                </div>
                            </div>
                        </div>
                    </div>
                )}
            </div>
        </div>
    );
};

export default CustomWorkbookOrders;