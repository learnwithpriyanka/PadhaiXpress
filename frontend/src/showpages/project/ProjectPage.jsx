import React, { useState, useContext } from 'react';
import { AuthContext } from '../../context/AuthContext';
import { supabase } from '../../supabaseClient';
import './WorkbookOrder.css';

function ProjectPage() {
    const { isLoggedIn } = useContext(AuthContext);
    const [currentStep, setCurrentStep] = useState(1);
    const [file, setFile] = useState(null);
    const [fileError, setFileError] = useState('');
    const [uploadProgress, setUploadProgress] = useState(0);
    const [formData, setFormData] = useState({
        fullName: '',
        phoneNumber: '',
        address: '',
        pincode: '',
        landmark: ''
    });
    const [paymentMethod, setPaymentMethod] = useState('cod');
    const [isSubmitting, setIsSubmitting] = useState(false);
    const [orderSuccess, setOrderSuccess] = useState(false);
    const [orderId, setOrderId] = useState(null);
    const [estimatedPages, setEstimatedPages] = useState(0);
    
    // Constants
    const BINDING_CHARGE = 50;
    const PER_PAGE_COST = 2; // ₹2 per page

    const handleFileChange = (e) => {
        const selectedFile = e.target.files[0];
        setFileError('');
        
        if (!selectedFile) {
            setFile(null);
            return;
        }
        
        // Check if file is PDF
        if (selectedFile.type !== 'application/pdf') {
            setFileError('Please upload a PDF file only');
            setFile(null);
            return;
        }
        
        // Check file size (25MB = 25 * 1024 * 1024 bytes)
        if (selectedFile.size > 25 * 1024 * 1024) {
            setFileError('File size exceeds 25MB limit');
            setFile(null);
            return;
        }
        
        setFile(selectedFile);
        
        // Estimate pages (this is just a rough estimate based on file size)
        const estimatedPageCount = Math.ceil(selectedFile.size / (75 * 1024)); // Assuming ~75KB per page
        setEstimatedPages(estimatedPageCount);
    };
    
    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setFormData({
            ...formData,
            [name]: value
        });
    };
    
    const handlePaymentMethodChange = (e) => {
        setPaymentMethod(e.target.value);
    };
    
    const nextStep = () => {
        if (currentStep === 1 && !file) {
            setFileError('Please upload a PDF file');
            return;
        }
        setCurrentStep(currentStep + 1);
    };
    
    const prevStep = () => {
        setCurrentStep(currentStep - 1);
    };
    
    const calculateTotal = () => {
        return (estimatedPages * PER_PAGE_COST) + BINDING_CHARGE;
    };
    
    const handleSubmit = async () => {
        // Validate form
        if (!formData.fullName || !formData.phoneNumber || !formData.address || !formData.pincode) {
            alert('Please fill all required fields');
            return;
        }
        
        // Validate phone number (10 digits)
        if (!/^\d{10}$/.test(formData.phoneNumber)) {
            alert('Please enter a valid 10-digit phone number');
            return;
        }
        
        // Validate pincode (6 digits)
        if (!/^\d{6}$/.test(formData.pincode)) {
            alert('Please enter a valid 6-digit pincode');
            return;
        }
        
        setIsSubmitting(true);
        
        try {
            // 1. Upload PDF to Supabase Storage
            const timestamp = new Date().getTime();
            const fileName = `${timestamp}_${file.name}`;
            const filePath = `workbooks/${fileName}`;
            
            const { data: uploadData, error: uploadError } = await supabase.storage
                .from('workbooks')
                .upload(filePath, file, {
                    cacheControl: '3600',
                    upsert: false,
                    onUploadProgress: (progress) => {
                        setUploadProgress(Math.round((progress.loaded / progress.total) * 100));
                    }
                });
                
            if (uploadError) throw uploadError;
            
            // Get the public URL
            const { data: { publicUrl } } = supabase.storage
                .from('workbooks')
                .getPublicUrl(filePath);
            
            // 2. Create order in database
            const { data: orderData, error: orderError } = await supabase
                .from('custom_workbook_orders')
                .insert([
                    {
                        user_id: isLoggedIn ? (await supabase.auth.getUser ()).data.user?.id : null,
                        pdf_file_url: publicUrl,
                        pages: estimatedPages,
                        delivery_name: formData.fullName,
                        phone: formData.phoneNumber,
                        address: formData.address,
                        pincode: formData.pincode,
                        landmark: formData.landmark || null,
                        payment_method: paymentMethod,
                        status: 'uploaded',
                        total_amount: calculateTotal()
                    }
                ])
                .select();
                
            if (orderError) throw orderError;
            
            // Success
            setOrderId(orderData[0].id);
            setOrderSuccess(true);
            setCurrentStep(5); // Move to success step
            
        } catch (error) {
            console.error('Error submitting order:', error);
            alert(`Error submitting order: ${error.message}`);
        } finally {
            setIsSubmitting(false);
            setUploadProgress(0);
        }
    };
    
    return (
        <div className="workbook-order-container">
            {!orderSuccess ? (
                <div className="workbook-order-card">
                    <div className="steps-indicator">
                        {[1, 2, 3, 4].map((step) => (
                            <div 
                                key={step} 
                                className={`step ${currentStep >= step ? 'active' : ''}`}
                                onClick={() => currentStep > step && setCurrentStep(step)}
                            >
                                {step}
                            </div>
                        ))}
                    </div>
                    
                    {currentStep === 1 && (
                        <div className="step-content">
                            <h2>📤 Upload Your Lab Workbook</h2>
                            <p className="step-description">Please upload your lab workbook in PDF format (Max size: 25MB).</p>
                            <p className="security-note">🔒 Your files are safe and used only for printing purposes.</p>
                            
                            <div className="file-upload-container">
                                <label className="file-upload-label">
                                    {file ? file.name : 'Choose PDF File'}
                                    <input 
                                        type="file" 
                                        accept=".pdf" 
                                        onChange={handleFileChange} 
                                        className="file-input"
                                    />
                                </label>
                                {file && <span className="file-selected">✓ File selected</span>}
                            </div>
                            
                            {fileError && <p className="error-message">{fileError}</p>}
                            
                            <div className="step-buttons">
                                <button className="next-button" onClick={nextStep}>Continue</button>
                            </div>
                        </div>
                    )}
                    
                    {currentStep === 2 && (
                        <div className="step-content">
                            <h2>📍 Enter Your Delivery Address</h2>
                            <p className="step-description">Make sure the address is complete and accurate.</p>
                            
                            <div className="form-group">
                                <label>Full Name *</label>
                                <input 
                                    type="text" 
                                    name="fullName" 
                                    value={formData.fullName} 
                                    onChange={handleInputChange} 
                                    placeholder="Enter your full name"
                                    required
                                />
                            </div>
                            
                            <div className="form-group">
                                <label>Phone Number *</label>
                                <input 
                                    type="tel" 
                                    name="phoneNumber" 
                                    value={formData.phoneNumber} 
                                    onChange={handleInputChange} 
                                    placeholder="10-digit mobile number"
                                    pattern="[0-9]{10}"
                                    required
                                />
                            </div>
                            
                            <div className="form-group">
                                <label>Delivery Address *</label>
                                <textarea 
                                    name="address" 
                                    value={formData.address} 
                                    onChange={handleInputChange} 
                                    placeholder="Enter your complete address"
                                    rows="3"
                                    required
                                ></textarea>
                            </div>
                            
                            <div className="form-group">
                                <label>Pincode *</label>
                                <input 
                                    type="text" 
                                    name="pincode" 
                                    value={formData.pincode} 
                                    onChange={handleInputChange} 
                                    placeholder="6-digit pincode"
                                    pattern="[0-9]{6}"
                                    required
                                />
                            </div>
                            
                            <div className="form-group">
                                <label>Landmark (Optional)</label>
                                <input 
                                    type="text" 
                                    name="landmark" 
                                    value={formData.landmark} 
                                    onChange={handleInputChange} 
                                    placeholder="Nearby landmark for easy delivery"
                                />
                            </div>
                            
                            <div className="step-buttons">
                                <button className="back-button" onClick={prevStep}>Back</button>
                                <button className="next-button" onClick={nextStep}>Continue</button>
                            </div>
                        </div>
                    )}
                    
                    {currentStep === 3 && (
                        <div className="step-content">
                            <h2>💳 Choose Payment Option</h2>
                            
                            <div className="payment-options">
                                <label className="payment-option">
                                    <input 
                                        type="radio" 
                                        name="paymentMethod" 
                                        value="cod" 
                                        checked={paymentMethod === 'cod'} 
                                        onChange={handlePaymentMethodChange} 
                                    />
                                    <div className="payment-option-content">
                                        <i className="payment-icon">💵</i>
                                        <span>Cash on Delivery (COD)</span>
                                    </div>
                                </label>
                                
                                <label className="payment-option disabled">
                                    <input 
                                        type="radio" 
                                        name="paymentMethod" 
                                        value="upi" 
                                        disabled 
                                    />
                                    <div className="payment-option-content">
                                        <i className="payment-icon">📱</i>
                                        <span>UPI / QR Code Payment (Coming Soon)</span>
                                    </div>
                                </label>
                            </div>
                            
                            <div className="step-buttons">
                                <button className="back-button" onClick={prevStep}>Back</button>
                                <button className="next-button" onClick={nextStep}>Continue</button>
                            </div>
                        </div>
                    )}
                    
                    {currentStep === 4 && (
                        <div className="step-content">
                            <h2>📝 Confirm Your Order</h2>
                            
                            <div className="order-summary">
                                <div className="summary-item">
                                    <span>File Uploaded:</span>
                                    <span>{file?.name}</span>
                                </div>
                                
                                <div className="summary-item">
                                    <span>Estimated Pages:</span>
                                    <span>{estimatedPages}</span>
                                </div>
                                
                                <div className="summary-item">
                                    <span>Page Cost:</span>
                                    <span>₹{estimatedPages * PER_PAGE_COST}</span>
                                </div>
                                
                                <div className="summary-item">
                                    <span>Binding Charge:</span>
                                    <span>₹{BINDING_CHARGE}</span>
                                </div>
                                
                                <div className="summary-item total">
                                    <span>Total Cost:</span>
                                    <span>₹{calculateTotal()}</span>
                                </div>
                            </div>
                            
                            <div className="delivery-note">
                                <p>✅ Once printed, your workbook will be delivered within 18 hours.</p>
                                <p>📞 You'll receive updates on your provided phone number.</p>
                            </div>
                            
                            <div className="step-buttons">
                                <button className="back-button" onClick={prevStep}>Back</button>
                                <button 
                                    className="place-order-button" 
                                    onClick={handleSubmit}
                                    disabled={isSubmitting}
                                >
                                    {isSubmitting ? (
                                        <>
                                            <span className="spinner"></span>
                                            {uploadProgress > 0 ? `Uploading... ${uploadProgress}%` : 'Processing...'}
                                        </>
                                    ) : 'Place Order'}
                                </button>
                            </div>
                        </div>
                    )}
                </div>
            ) : (
                <div className="order-success">
                    <div className="success-icon">✅</div>
                    <h2>Order Placed Successfully!</h2>
                    <p>Your order has been received and is being processed.</p>
                    <p className="order-id">Order ID: #{orderId}</p>
                    <p>We'll send updates about your order to your phone number.</p>
                    <p>Thank you for choosing PadhaiXpress!</p>
                    <button className="home-button" onClick={() => window.location.href = '/'}>Back to Home</button>
                </div>
            )}
        </div>
    );
}

export default ProjectPage;
