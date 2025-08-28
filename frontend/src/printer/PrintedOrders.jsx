// frontend/src/printer/PrintedOrders.jsx
import React, { useEffect, useMemo, useState } from 'react';
import { supabase } from '../supabaseClient';
import { Link } from 'react-router-dom';

// A read-only page that lists all processed orders (Printed, Out-for-Delivery, Delivered)
// with date range filters and aggregate stats specifically for the printer payout.
// This does not change any existing logic elsewhere; it's an isolated page.

const PROCESSED_STATUSES = ['printed', 'out-for-delivery', 'delivered'];

const PrintedOrders = () => {
  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  // Date range filters (YYYY-MM-DD strings)
  const [filters, setFilters] = useState({ startDate: '', endDate: '' });

  useEffect(() => {
    const fetchOrders = async () => {
      setLoading(true);
      setError('');
      const { data, error } = await supabase
        .from('orders')
        .select('*, order_items(*, product:product_id(*))')
        .in('status', PROCESSED_STATUSES)
        .order('created_at', { ascending: false });

      if (error) {
        setError('Failed to fetch orders: ' + error.message);
        setOrders([]);
      } else {
        setOrders(data || []);
      }
      setLoading(false);
    };

    fetchOrders();
  }, []);

  const handleFilterChange = (e) => {
    const { name, value } = e.target;
    setFilters((prev) => ({ ...prev, [name]: value }));
  };

  // Inclusive date range filtering helper
  const filteredOrders = useMemo(() => {
    if (!filters.startDate && !filters.endDate) return orders;

    const start = filters.startDate ? new Date(filters.startDate) : null;
    const end = filters.endDate ? new Date(filters.endDate) : null;

    // Normalize start to start-of-day
    if (start) start.setHours(0, 0, 0, 0);
    // Normalize end to end-of-day to make it inclusive
    if (end) end.setHours(23, 59, 59, 999);

    return orders.filter((order) => {
      const d = order.created_at ? new Date(order.created_at) : null;
      if (!d) return false;
      if (start && d < start) return false;
      if (end && d > end) return false;
      return true;
    });
  }, [orders, filters.startDate, filters.endDate]);

  // Printer payout helpers
  const perBookPrinterCost = (pages, pageType) => {
    const pageCount = Number(pages) || 0;
    const rate = pageType === 'single' ? 0.90 : 0.45; // single-side vs double-side
    return pageCount * rate + 55; // binding charge
  };

  const getOrderPrinterTotals = (order) => {
    const items = Array.isArray(order.order_items) ? order.order_items : [];
    return items.reduce(
      (acc, it) => {
        const qty = Number(it.quantity) || 0;
        const pages = Number(it.product?.pages) || 0;
        const perBook = perBookPrinterCost(pages, it.page_type);
        const itemPayout = perBook * qty;
        acc.totalBooks += qty;
        acc.totalPages += pages * qty;
        acc.totalPayout += itemPayout;
        return acc;
      },
      { totalBooks: 0, totalPages: 0, totalPayout: 0 }
    );
  };

  // Aggregates across filtered orders (printer-focused)
  const overall = useMemo(() => {
    return filteredOrders.reduce(
      (acc, order) => {
        const { totalBooks, totalPages, totalPayout } = getOrderPrinterTotals(order);
        acc.totalOrders += 1;
        acc.totalBooks += totalBooks;
        acc.totalPages += totalPages;
        acc.totalPayout += totalPayout;
        return acc;
      },
      { totalOrders: 0, totalBooks: 0, totalPages: 0, totalPayout: 0 }
    );
  }, [filteredOrders]);

  const styles = {
    container: {
      maxWidth: '1200px',
      margin: '0 auto',
      padding: '20px',
      fontFamily:
        'system-ui, -apple-system, Segoe UI, Roboto, Ubuntu, Cantarell, Noto Sans, Helvetica Neue, Arial, "Apple Color Emoji", "Segoe UI Emoji"',
      backgroundColor: '#f8fafc',
      minHeight: '100vh',
    },
    header: {
      textAlign: 'center',
      marginBottom: '24px',
      color: '#1e293b',
      fontSize: '2rem',
      fontWeight: 700,
    },
    toolbar: {
      display: 'flex',
      flexWrap: 'wrap',
      justifyContent: 'space-between',
      gap: '12px',
      marginBottom: '16px',
      alignItems: 'center',
    },
    filterGroup: {
      display: 'flex',
      gap: '8px',
      alignItems: 'center',
      flexWrap: 'wrap',
    },
    input: {
      padding: '8px 10px',
      border: '1px solid #cbd5e1',
      borderRadius: '6px',
      backgroundColor: '#fff',
    },
    sectionHeader: {
      marginTop: '20px',
      marginBottom: '12px',
      fontSize: '1.25rem',
      fontWeight: 700,
      color: '#334155',
      borderBottom: '2px solid #e2e8f0',
      paddingBottom: '6px',
    },
    ordersGrid: {
      display: 'grid',
      gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', // responsive on small screens
      gap: '16px',
    },
    orderCard: {
      backgroundColor: '#ffffff',
      borderRadius: '10px',
      padding: '16px',
      border: '1px solid #e2e8f0',
      boxShadow: '0 1px 2px rgba(0,0,0,0.06)',
    },
    orderHeader: {
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'space-between',
      marginBottom: '10px',
      gap: '8px',
      flexWrap: 'wrap',
    },
    orderId: { fontWeight: 700, color: '#0f172a' },
    statusBadge: {
      padding: '4px 10px',
      borderRadius: '9999px',
      fontSize: '0.8rem',
      fontWeight: 600,
      textTransform: 'capitalize',
    },
    statusColors: {
      printed: { backgroundColor: '#dcfce7', color: '#166534' },
      'out-for-delivery': { backgroundColor: '#fee2e2', color: '#7f1d1d' },
      delivered: { backgroundColor: '#dbeafe', color: '#1e3a8a' },
      default: { backgroundColor: '#e5e7eb', color: '#374151' },
    },
    infoRow: {
      display: 'grid',
      gridTemplateColumns: '1fr 1fr',
      gap: '8px',
      marginBottom: '8px',
    },
    infoLabel: { color: '#64748b', fontSize: '0.85rem' },
    infoValue: { color: '#0f172a', fontWeight: 600 },
    itemsList: {
      marginTop: '8px',
      borderTop: '1px solid #f1f5f9',
      paddingTop: '8px',
      display: 'flex',
      flexDirection: 'column',
      gap: '8px',
    },
    item: {
      display: 'flex',
      justifyContent: 'space-between',
      gap: '8px',
      padding: '8px 0',
      borderBottom: '1px solid #f8fafc',
      color: '#475569',
      alignItems: 'center',
      flexWrap: 'wrap',
    },
    itemLeft: { flex: 1, minWidth: 0 },
    itemRight: { fontWeight: 700, color: '#0f172a', whiteSpace: 'nowrap' },
    itemName: { fontWeight: 600, color: '#0f172a' },
    itemMeta: { fontSize: '0.85rem', color: '#64748b' },
    orderPayoutBar: {
      marginTop: '8px',
      paddingTop: '8px',
      display: 'flex',
      justifyContent: 'space-between',
      alignItems: 'center',
      fontWeight: 700,
      color: '#0f172a',
    },
    overallBar: {
      marginTop: '16px',
      background: '#ffffff',
      border: '1px solid #e2e8f0',
      borderRadius: '10px',
      padding: '16px',
      display: 'grid',
      gridTemplateColumns: 'repeat(auto-fit, minmax(220px, 1fr))',
      gap: '12px',
    },
    summaryBar: {
      marginTop: '8px',
      background: '#ffffff',
      border: '1px solid #e2e8f0',
      borderRadius: '10px',
      padding: '16px',
      display: 'grid',
      gridTemplateColumns: 'repeat(auto-fit, minmax(220px, 1fr))',
      gap: '12px',
    },
  };

  const getStatusStyle = (status) => styles.statusColors[status] || styles.statusColors.default;
  const formatDateTime = (iso) => {
    if (!iso) return '-';
    try {
      return new Date(iso).toLocaleString();
    } catch {
      return String(iso);
    }
  };

  if (loading) {
    return (
      <div style={styles.container}>
        <div style={styles.header}>🖨️ Printed Orders</div>
        <p>Loading...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div style={styles.container}>
        <div style={styles.header}>🖨️ Printed Orders</div>
        <div style={{ color: '#b91c1c', background: '#fee2e2', padding: '12px', borderRadius: '8px' }}>{error}</div>
      </div>
    );
  }

  return (
    <div style={styles.container}>
      <div style={styles.header}>🖨️ Printed Orders</div>

      <div className="toolbar" style={styles.toolbar}>
        <div style={styles.filterGroup}>
          <label htmlFor="startDate">Start Date</label>
          <input
            id="startDate"
            name="startDate"
            type="date"
            value={filters.startDate}
            onChange={handleFilterChange}
            style={styles.input}
          />
          <label htmlFor="endDate">End Date</label>
          <input
            id="endDate"
            name="endDate"
            type="date"
            value={filters.endDate}
            onChange={handleFilterChange}
            style={styles.input}
          />
        </div>
        <div>
          <Link
            to="/printer-dashboard"
            style={{
              display: 'inline-block',
              padding: '8px 14px',
              background: '#1d4ed8',
              color: '#fff',
              borderRadius: '8px',
              textDecoration: 'none',
              fontWeight: 600,
            }}
          >
            Back to Printer Dashboard
          </Link>
        </div>
      </div>

      {/* Summary bar (updates with filters) */}
      <div style={styles.summaryBar}>
        <div>
          <div style={styles.infoLabel}>📦 Total Orders</div>
          <div style={styles.infoValue}>{overall.totalOrders}</div>
        </div>
        <div>
          <div style={styles.infoLabel}>📚 Total Books</div>
          <div style={styles.infoValue}>{overall.totalBooks}</div>
        </div>
        <div>
          <div style={styles.infoLabel}>💰 Total Price (Printer Payout)</div>
          <div style={{ ...styles.infoValue, fontSize: '1.1rem' }}>₹{overall.totalPayout.toFixed(2)}</div>
        </div>
      </div>

      <h2 style={styles.sectionHeader}>Order History</h2>

      {filteredOrders.length === 0 ? (
        <div style={{ background: '#fff', padding: '24px', borderRadius: '12px', textAlign: 'center', color: '#64748b' }}>
          No orders found for the selected period.
        </div>
      ) : (
        <>
          <div style={styles.ordersGrid}>
            {filteredOrders.map((order) => {
              const orderTotals = getOrderPrinterTotals(order);
              return (
                <div key={order.id} style={styles.orderCard}>
                  <div style={styles.orderHeader}>
                    <span style={styles.orderId}>Order #{order.id}</span>
                    <span style={{ ...styles.statusBadge, ...getStatusStyle(order.status) }}>{order.status}</span>
                  </div>

                  <div style={styles.infoRow}>
                    <div>
                      <div style={styles.infoLabel}>Order Date</div>
                      <div style={styles.infoValue}>{formatDateTime(order.created_at)}</div>
                    </div>
                    <div>
                      <div style={styles.infoLabel}>Books in Order</div>
                      <div style={styles.infoValue}>{orderTotals.totalBooks}</div>
                    </div>
                  </div>

                  <div style={styles.itemsList}>
                    {(order.order_items || []).map((item) => {
                      const qty = Number(item.quantity) || 0;
                      const pages = Number(item.product?.pages) || 0;
                      const perBook = perBookPrinterCost(pages, item.page_type);
                      const itemPayout = perBook * qty;
                      const bindLabel = item.page_type === 'single' ? 'Single side' : 'Double side';
                      return (
                        <div key={item.id} style={styles.item}>
                          <div style={styles.itemLeft}>
                            <div style={styles.itemName}>{item.product?.name || `Product ${item.product_id}`}</div>
                            <div style={styles.itemMeta}>
                              Pages: {pages} • Binding Type: {bindLabel} • Qty: x{qty}
                            </div>
                          </div>
                          <div style={styles.itemRight}>₹{itemPayout.toFixed(2)}</div>
                        </div>
                      );
                    })}
                  </div>

                  <div style={styles.orderPayoutBar}>
                    <div>Order Printer Payout</div>
                    <div>₹{orderTotals.totalPayout.toFixed(2)}</div>
                  </div>
                </div>
              );
            })}
          </div>

          {/* Overall Totals (bottom) */}
          <div style={styles.overallBar}>
            <div>
              <div style={styles.infoLabel}>Total Books Printed</div>
              <div style={styles.infoValue}>{overall.totalBooks}</div>
            </div>
            <div>
              <div style={styles.infoLabel}>Total Pages Printed</div>
              <div style={styles.infoValue}>{overall.totalPages}</div>
            </div>
            <div>
              <div style={styles.infoLabel}>Total Payout (Printer)</div>
              <div style={{ ...styles.infoValue, fontSize: '1.1rem' }}>₹{overall.totalPayout.toFixed(2)}</div>
            </div>
          </div>
        </>
      )}
    </div>
  );
};

export default PrintedOrders;