import React, { useEffect, useState } from 'react';
import { supabase } from '../supabaseClient';
import { Plus, Edit2, Trash2, Upload, X, Package, Search, AlertCircle } from 'lucide-react';
import './ProductManager.css';
import AdminSidebar from './AdminSidebar';
import { PDFDocument } from 'pdf-lib';
import Klimage from '../assets/Klimage.png';
// Replace the DEFAULT_BOOK_IMAGE constant with a local image
const DEFAULT_BOOK_IMAGE = Klimage; // Current
// OR try:
// const DEFAULT_BOOK_IMAGE = '/media/Klimage.png'; // If file is capitalized

const initialForm = {
  id: '',
  code: '',
  name: '',
  price: '',
  pages: '',
  image: '',
  pagetype: 'single', // Set default to 'single'
  year: '',
  sem: '',
};

function ProductManager() {
  const [products, setProducts] = useState([]);
  const [form, setForm] = useState(initialForm);
  const [editingId, setEditingId] = useState(null);
  const [pdfFile, setPdfFile] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [searchTerm, setSearchTerm] = useState('');

  // Fetch products
  useEffect(() => {
    fetchProducts();
  }, []);

  async function fetchProducts() {
    setLoading(true);
    const { data, error } = await supabase.from('products').select('*');
    if (error) setError(error.message);
    else setProducts(data);
    setLoading(false);
  }

  // Handle form input
  function handleChange(e) {
    const { name, value } = e.target;
    setForm((f) => ({ ...f, [name]: value }));
  }

  // Extract page count from PDF file
  async function extractPdfPageCount(file) {
    try {
      const arrayBuffer = await file.arrayBuffer();
      const pdfDoc = await PDFDocument.load(arrayBuffer);
      return pdfDoc.getPageCount();
    } catch (error) {
      console.error('Error extracting page count:', error);
      setError('Failed to extract page count from PDF');
      return null;
    }
  }

  // Handle image file selection
  async function handlePdfChange(e) {
    const file = e.target.files[0];
    setPdfFile(file);
    
    // Automatically extract page count when PDF is selected
    if (file && file.type === 'application/pdf') {
      setLoading(true);
      const pageCount = await extractPdfPageCount(file);
      if (pageCount !== null) {
        setForm(prevForm => ({ 
          ...prevForm, 
          pages: pageCount.toString() 
        }));
      }
      setLoading(false);
    }
  }

  // Upload image to Supabase Storage
  async function uploadPdf(file) {
    if (!file) return '';
    const fileExt = file.name.split('.').pop();
    const fileName = `${Date.now()}-${Math.random().toString(36).substr(2, 9)}.${fileExt}`;
    const { data, error } = await supabase.storage.from('products').upload(fileName, file);
    if (error) {
      setError('PDF upload failed: ' + error.message);
      return '';
    }
    // Get public URL
    const { data: publicUrlData } = supabase.storage.from('products').getPublicUrl(fileName);
    return publicUrlData.publicUrl;
  }

  // Handle form submit (create or update)
  async function handleSubmit(e) {
    e.preventDefault();
    setLoading(true);
    setError('');
    let pdfUrl = form.image;
    if (pdfFile) {
      pdfUrl = await uploadPdf(pdfFile);
      if (!pdfUrl) {
        setLoading(false);
        return;
      }
    }
    const productData = {
      ...form,
      price: parseFloat(form.pages) + 50, // Fixed: convert pages to number first, then add 50
      pages: form.pages ? parseInt(form.pages) : null,
      image: pdfUrl, // keep the same field for compatibility
    };
    if (editingId) {
      // Update
      const { error } = await supabase.from('products').update(productData).eq('id', editingId);
      if (error) setError(error.message);
    } else {
      // Create
      const { error } = await supabase.from('products').insert([{ ...productData, id: crypto.randomUUID() }]);
      if (error) setError(error.message);
    }
    setForm(initialForm);
    setPdfFile(null);
    setEditingId(null);
    fetchProducts();
    setLoading(false);
  }

  // Edit product
  function handleEdit(product) {
    setForm({ ...product });
    setEditingId(product.id);
  }

  // Delete product
  async function handleDelete(id) {
    if (!window.confirm('Delete this product?')) return;
    setLoading(true);
    const { error } = await supabase.from('products').delete().eq('id', id);
    if (error) setError(error.message);
    fetchProducts();
    setLoading(false);
  }

  // Cancel editing
  function handleCancel() {
    setForm(initialForm);
    setPdfFile(null);
    setEditingId(null);
  }

  // Filter products based on search term
  const filteredProducts = products.filter(product =>
    product.name?.toLowerCase().includes(searchTerm.toLowerCase()) ||
    product.code?.toLowerCase().includes(searchTerm.toLowerCase()) ||
    product.pagetype?.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div style={{ display: 'flex' }}>
      <AdminSidebar />
      <div style={{ marginLeft: 220, width: '100%' }}>
        {/* Header */}
        <div className="header-card">
          <div className="header-title">
            <Package className="header-icon" />
            <h1>Product Manager</h1>
          </div>
          <p className="header-subtitle">Manage your product catalog with ease</p>
        </div>

        {/* Error Alert */}
        {error && (
          <div className="error-alert">
            <AlertCircle className="error-icon" />
            <div className="error-text">{error}</div>
          </div>
        )}

        {/* Product Form */}
        <div className="form-card">
          <h2 className="form-header">
            <Plus className="form-header-icon" />
            {editingId ? 'Edit Product' : 'Add New Product'}
          </h2>
          
          <div className="form-content">
            <div className="form-grid">
              <div className="form-field">
                <label className="form-label">Product Code</label>
                <input
                  name="code"
                  placeholder="Enter product code"
                  value={form.code}
                  onChange={handleChange}
                  className="form-input"
                />
              </div>
              
              <div className="form-field">
                <label className="form-label">Product Name *</label>
                <input
                  name="name"
                  placeholder="Enter book name"
                  value={form.name}
                  onChange={handleChange}
                  required
                  className="form-input"
                />
              </div>
              
              <div className="form-field">
                <label className="form-label">Price</label>
                <input
                  name="price"
                  placeholder="0.00"
                  type="number"
                  step="0.01"
                  value={form.price}
                  onChange={handleChange}
                  className="form-input"
                />
              </div>
              
              <div className="form-field">
                <label className="form-label">Pages</label>
                <input
                  name="pages"
                  placeholder="Number of pages"
                  type="number"
                  value={form.pages}
                  onChange={handleChange}
                  className="form-input"
                />
              </div>
              
              <div className="form-field">
                <label className="form-label">Page Type</label>
                <input
                  name="pagetype"
                  placeholder="single,double."
                  value={form.pagetype}
                  onChange={handleChange}
                  className="form-input"
                />
              </div>
              
              <div className="form-field">
                <label className="form-label">Year</label>
                <input
                  name="year"
                  placeholder="1st ,2nd ,3rd..."
                  value={form.year}
                  onChange={handleChange}
                  className="form-input"
                />
              </div>
              
              <div className="form-field">
                <label className="form-label">Semester</label>
                <input
                  name="sem"
                  placeholder="odd ,even"
                  value={form.sem}
                  onChange={handleChange}
                  className="form-input"
                />
              </div>
            </div>
            
            <div className="form-field">
              <label className="form-label">Product PDF</label>
              <div className="file-upload-container">
                <input
                  type="file"
                  accept="application/pdf"
                  onChange={handlePdfChange}
                  className="file-input"
                />
                {form.image && !pdfFile && (
                  <a href={form.image} target="_blank" rel="noopener noreferrer" className="current-pdf-link">
                    View PDF
                  </a>
                )}
              </div>
            </div>
            
            <div className="button-group">
              <button
                type="submit"
                disabled={loading}
                onClick={handleSubmit}
                className="btn btn-primary"
              >
                {loading ? (
                  <>
                    <div className="loading-spinner"></div>
                    Processing...
                  </>
                ) : (
                  <>
                    {editingId ? <Edit2 className="btn-icon" /> : <Plus className="btn-icon" />}
                    {editingId ? 'Update Product' : 'Add Product'}
                  </>
                )}
              </button>
              
              {editingId && (
                <button
                  type="button"
                  onClick={handleCancel}
                  className="btn btn-secondary"
                >
                  <X className="btn-icon" />
                  Cancel
                </button>
              )}
            </div>
          </div>
        </div>

        {/* Products Table */}
        <div className="table-card">
          <div className="table-header">
            <div className="table-header-content">
              <h2 className="table-title">Products ({filteredProducts.length})</h2>
              <div className="search-container">
                <Search className="search-icon" />
                <input
                  type="text"
                  placeholder="Search products..."
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  className="search-input"
                />
              </div>
            </div>
          </div>
          
          <div className="table-container">
            {loading ? (
              <div className="table-loading">
                <div className="table-loading-spinner"></div>
                <span className="table-loading-text">Loading products...</span>
              </div>
            ) : filteredProducts.length === 0 ? (
              <div className="table-empty">
                <Package className="table-empty-icon" />
                <p className="table-empty-text">No products found</p>
              </div>
            ) : (
              <table className="products-table">
                <thead className="table-head">
                  <tr>
                    <th>Image</th>
                    <th>Code</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Pages</th>
                    <th>Page Type</th>
                    <th>Year</th>
                    <th>Semester</th>
                    <th>Actions</th>
                  </tr>
                </thead>
                <tbody className="table-body">
                  {filteredProducts.map((product) => (
                    <tr key={product.id} className="table-row">
                      <td className="table-cell">
                        <div className="product-image-container">
                          <img 
                            src={DEFAULT_BOOK_IMAGE} 
                            alt={product.name || 'Book'}
                            className="product-default-image"
                            onError={(e) => {
                              // Hide broken image and show fallback
                              e.target.style.display = 'none';
                              e.target.nextSibling.style.display = 'flex';
                            }}
                          />
                          <div className="book-icon-fallback" style={{display: 'none'}}>
                            <Package className="book-icon" />
                            <span className="book-text">📚</span>
                          </div>
                          
                        </div>
                      </td>
                      <td className="table-cell">{product.code}</td>
                      <td className="table-cell table-cell-medium">{product.name}</td>
                      <td className="table-cell">
                        {product.price ? `${product.price}` : '-'}
                      </td>
                      <td className="table-cell">{product.pages || '-'}</td>
                      <td className="table-cell">{product.pagetype || '-'}</td>
                      <td className="table-cell">{product.year || '-'}</td>
                      <td className="table-cell">{product.sem || '-'}</td>
                      <td className="table-cell">
                        <div className="action-buttons">
                          <button
                            onClick={() => handleEdit(product)}
                            className="btn-edit"
                          >
                            <Edit2 className="btn-action-icon" />
                            Edit
                          </button>
                          <button
                            onClick={() => handleDelete(product.id)}
                            className="btn-delete"
                          >
                            <Trash2 className="btn-action-icon" />
                            Delete
                          </button>
                        </div>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            )}
          </div>
        </div>
      </div>
    </div>
  );

}
export default ProductManager;