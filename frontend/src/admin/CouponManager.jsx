import React, { useEffect, useState } from 'react';
import { supabase } from '../supabaseClient';
import './ProductManager.css'; // Reuse admin styles for consistency
import AdminSidebar from './AdminSidebar';

const initialForm = {
  code: '',
  discount_type: 'percent',
  discount_value: '',
  expiry_date: '',
  min_order_value: '',
  max_uses: '',
  is_active: true,
};

function CouponManager() {
  const [coupons, setCoupons] = useState([]);
  const [form, setForm] = useState(initialForm);
  const [editingId, setEditingId] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');

  useEffect(() => {
    fetchCoupons();
  }, []);

  async function fetchCoupons() {
    setLoading(true);
    const { data, error } = await supabase.from('coupons').select('*').order('created_at', { ascending: false });
    if (error) setError(error.message);
    else setCoupons(data);
    setLoading(false);
  }

  function handleChange(e) {
    const { name, value, type, checked } = e.target;
    setForm(f => ({ ...f, [name]: type === 'checkbox' ? checked : value }));
  }

  function handleEdit(coupon) {
    setForm({
      code: coupon.code,
      discount_type: coupon.discount_type,
      discount_value: coupon.discount_value,
      expiry_date: coupon.expiry_date ? coupon.expiry_date.slice(0, 10) : '',
      min_order_value: coupon.min_order_value || '',
      max_uses: coupon.max_uses || '',
      is_active: coupon.is_active,
    });
    setEditingId(coupon.id);
    setError('');
    setSuccess('');
  }

  function handleCancel() {
    setForm(initialForm);
    setEditingId(null);
    setError('');
    setSuccess('');
  }

  async function handleSubmit(e) {
    e.preventDefault();
    setLoading(true);
    setError('');
    setSuccess('');
    const couponData = {
      ...form,
      discount_value: form.discount_value ? Number(form.discount_value) : null,
      min_order_value: form.min_order_value ? Number(form.min_order_value) : null,
      max_uses: form.max_uses ? Number(form.max_uses) : null,
      expiry_date: form.expiry_date || null,
    };
    if (editingId) {
      // Update
      const { error } = await supabase.from('coupons').update(couponData).eq('id', editingId);
      if (error) setError(error.message);
      else setSuccess('Coupon updated!');
    } else {
      // Create
      const { error } = await supabase.from('coupons').insert([couponData]);
      if (error) setError(error.message);
      else setSuccess('Coupon created!');
    }
    setForm(initialForm);
    setEditingId(null);
    fetchCoupons();
    setLoading(false);
  }

  async function handleDelete(id) {
    if (!window.confirm('Delete this coupon?')) return;
    setLoading(true);
    const { error } = await supabase.from('coupons').delete().eq('id', id);
    if (error) setError(error.message);
    else setSuccess('Coupon deleted!');
    fetchCoupons();
    setLoading(false);
  }

  async function handleToggleActive(coupon) {
    setLoading(true);
    const { error } = await supabase.from('coupons').update({ is_active: !coupon.is_active }).eq('id', coupon.id);
    if (error) setError(error.message);
    fetchCoupons();
    setLoading(false);
  }

  return (
    <div style={{ display: 'flex' }}>
      <AdminSidebar />
      <div style={{ marginLeft: 220, width: '100%' }}>
        <div className="admin-page">
          <div className="admin-content">
            <h2 style={{ marginBottom: 16 }}>Coupon Manager</h2>
            {error && <div style={{ color: 'red', marginBottom: 8 }}>{error}</div>}
            {success && <div style={{ color: 'green', marginBottom: 8 }}>{success}</div>}
            <form onSubmit={handleSubmit} className="admin-form" style={{ marginBottom: 32, display: 'flex', flexWrap: 'wrap', gap: 16, alignItems: 'flex-end' }}>
              <input name="code" placeholder="Code" value={form.code} onChange={handleChange} required style={{ minWidth: 120 }} />
              <select name="discount_type" value={form.discount_type} onChange={handleChange} required>
                <option value="percent">Percent (%)</option>
                <option value="amount">Amount (₹)</option>
              </select>
              <input name="discount_value" placeholder="Value" type="number" value={form.discount_value} onChange={handleChange} required min={1} style={{ width: 90 }} />
              <input name="expiry_date" type="date" value={form.expiry_date} onChange={handleChange} />
              <input name="min_order_value" placeholder="Min Order" type="number" value={form.min_order_value} onChange={handleChange} min={0} style={{ width: 110 }} />
              <input name="max_uses" placeholder="Max Uses" type="number" value={form.max_uses} onChange={handleChange} min={1} style={{ width: 90 }} />
              <label style={{ display: 'flex', alignItems: 'center', gap: 4 }}>
                <input type="checkbox" name="is_active" checked={form.is_active} onChange={handleChange} /> Active
              </label>
              <button type="submit" className="admin-btn" disabled={loading} style={{ minWidth: 120 }}>
                {editingId ? 'Update' : 'Add'} Coupon
              </button>
              {editingId && (
                <button type="button" className="admin-btn" onClick={handleCancel} style={{ background: '#eee', color: '#222' }}>
                  Cancel
                </button>
              )}
            </form>
            <h3 style={{ marginBottom: 12 }}>All Coupons</h3>
            {loading ? (
              <div>Loading...</div>
            ) : (
              <div style={{ overflowX: 'auto' }}>
                <table className="admin-table" style={{ width: '100%', borderCollapse: 'collapse' }}>
                  <thead>
                    <tr>
                      <th>Code</th>
                      <th>Type</th>
                      <th>Value</th>
                      <th>Active</th>
                      <th>Expiry</th>
                      <th>Min Order</th>
                      <th>Max Uses</th>
                      <th>Used</th>
                      <th>Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    {coupons.map(coupon => (
                      <tr key={coupon.id} style={{ background: coupon.is_active ? '#f8fafc' : '#f3f4f6' }}>
                        <td>{coupon.code}</td>
                        <td>{coupon.discount_type === 'percent' ? 'Percent' : 'Amount'}</td>
                        <td>{coupon.discount_type === 'percent' ? `${coupon.discount_value}%` : `₹${coupon.discount_value}`}</td>
                        <td>
                          <button className="admin-btn" style={{ background: coupon.is_active ? '#22c55e' : '#e5e7eb', color: coupon.is_active ? '#fff' : '#222', fontWeight: 600, fontSize: 13, padding: '2px 10px' }} onClick={() => handleToggleActive(coupon)}>
                            {coupon.is_active ? 'Active' : 'Inactive'}
                          </button>
                        </td>
                        <td>{coupon.expiry_date ? new Date(coupon.expiry_date).toLocaleDateString() : '-'}</td>
                        <td>{coupon.min_order_value ? `₹${coupon.min_order_value}` : '-'}</td>
                        <td>{coupon.max_uses || '-'}</td>
                        <td>{coupon.times_used || 0}</td>
                        <td>
                          <button className="admin-btn" style={{ background: '#2563eb', color: '#fff', fontSize: 13, padding: '2px 10px', marginRight: 6 }} onClick={() => handleEdit(coupon)}>
                            Edit
                          </button>
                          <button className="admin-btn" style={{ background: '#ef4444', color: '#fff', fontSize: 13, padding: '2px 10px' }} onClick={() => handleDelete(coupon.id)}>
                            Delete
                          </button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}

export default CouponManager; 