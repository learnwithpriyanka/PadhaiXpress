import React, { useState, useContext, useEffect } from 'react';
import { AuthContext } from '../../context/AuthContext';
import { supabase } from '../../supabaseClient';
import './WorkbookOrder.css';
import { PDFDocument } from 'pdf-lib';

function ProjectPage() {
    const { isLoggedIn } = useContext(AuthContext);
    const [currentStep, setCurrentStep] = useState(1);
    const [file, setFile] = useState(null);
    const [fileError, setFileError] = useState('');
    const [uploadProgress, setUploadProgress] = useState(0);
    const [bindingType, setBindingType] = useState('spiral');
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
    
    const BINDING_CHARGES = {
        spiral: 40,
        tape: 30,
        white: 60,
        normal: 5
    };
    const PER_PAGE_COST = 2;

    const handleFileChange = async (e) => {
        const selectedFile = e.target.files[0];
        setFileError('');
        
        if (!selectedFile) {
            setFile(null);
            setEstimatedPages(0);
            return;
        }
        
        if (selectedFile.type !== 'application/pdf') {
            setFileError('Please upload a PDF file only');
            setFile(null);
            setEstimatedPages(0);
            return;
        }
        
        if (selectedFile.size > 25 * 1024 * 1024) {
            setFileError('File size exceeds 25MB limit');
            setFile(null);
            setEstimatedPages(0);
            return;
        }
        
        setFile(selectedFile);
        try {
            const buffer = await selectedFile.arrayBuffer();
            const pdfDoc = await PDFDocument.load(buffer);
            const pageCount = pdfDoc.getPageCount();
            setEstimatedPages(pageCount || 0);
        } catch (err) {
            console.error('Failed to parse PDF for page count, using estimate.', err);
            const fallbackEstimate = Math.ceil(selectedFile.size / (150 * 1024));
            setEstimatedPages(fallbackEstimate);
        }
    };

    const handleBindingTypeChange = (e) => {
        setBindingType(e.target.value);
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
    
    // Razorpay loader
    const loadRazorpayScript = () => {
        return new Promise((resolve) => {
            if (window.Razorpay) {
                resolve(true);
                return;
            }
            const script = document.createElement('script');
            script.src = 'https://checkout.razorpay.com/v1/checkout.js';
            script.onload = () => resolve(true);
            script.onerror = () => resolve(false);
            document.body.appendChild(script);
        });
    };

    useEffect(() => {
        loadRazorpayScript();
    }, []);
    
    const nextStep = () => {
        if (currentStep === 1 && !file) {
            setFileError('Please upload a PDF file');
            return;
        }
        
        if (currentStep === 2) {
            // Validate delivery form
            if (!formData.fullName.trim()) {
                alert('Please enter your full name');
                return;
            }
            if (!formData.phoneNumber.trim()) {
                alert('Please enter your phone number');
                return;
            }
            if (!/^\d{10}$/.test(formData.phoneNumber)) {
                alert('Please enter a valid 10-digit phone number');
                return;
            }
            if (!formData.address.trim()) {
                alert('Please enter your delivery address');
                return;
            }
            if (!formData.pincode.trim()) {
                alert('Please enter your pincode');
                return;
            }
            if (!/^\d{6}$/.test(formData.pincode)) {
                alert('Please enter a valid 6-digit pincode');
                return;
            }
        }
        
        setCurrentStep(currentStep + 1);
    };
    
    const prevStep = () => {
        setCurrentStep(currentStep - 1);
    };
    
    const calculateTotal = () => {
        return (estimatedPages * PER_PAGE_COST) + BINDING_CHARGES[bindingType];
    };
    
    const createRazorpayOrder = async (amount) => {
        if (!import.meta.env.VITE_RAZORPAY_KEY_ID) {
            alert('Payment is not configured. Missing Razorpay key.');
            return;
        }
        if (!window.Razorpay) {
            const loaded = await loadRazorpayScript();
            if (!loaded) {
                alert('Payment gateway failed to load. Please try again.');
                return;
            }
        }
        if (!amount || amount <= 0) {
            alert('Calculated amount is invalid. Please reselect your file.');
            return;
        }

        const options = {
            key: import.meta.env.VITE_RAZORPAY_KEY_ID,
            amount: Math.round(amount * 100),
            currency: 'INR',
            name: 'PadhaiXpress',
            description: 'Custom Workbook Payment',
            receipt: `receipt_${Date.now()}`,
            prefill: {
                name: formData.fullName,
                contact: formData.phoneNumber,
            },
            theme: { color: '#3399cc' },
            handler: async function (response) {
                try {
                    setIsSubmitting(true);
                    const timestamp = new Date().getTime();
                    const fileName = `${timestamp}_${file.name}`;
                    const filePath = `workbooks/${fileName}`;

                    const { error: uploadError } = await supabase.storage
                        .from('workbooks')
                        .upload(filePath, file, {
                            cacheControl: '3600',
                            upsert: false,
                            onUploadProgress: (progress) => {
                                setUploadProgress(Math.round((progress.loaded / progress.total) * 100));
                            }
                        });
                    if (uploadError) throw uploadError;

                    const { data: { publicUrl } } = supabase.storage
                        .from('workbooks')
                        .getPublicUrl(filePath);

                    const { data: orderData, error: orderError } = await supabase
                        .from('custom_workbook_orders')
                        .insert([
                            {
                                user_id: (await supabase.auth.getUser()).data.user?.id || null,
                                pdf_file_url: publicUrl,
                                pages: estimatedPages,
                                binding_type: bindingType,
                                delivery_name: formData.fullName,
                                phone: formData.phoneNumber,
                                address: formData.address,
                                pincode: formData.pincode,
                                landmark: formData.landmark || null,
                                payment_method: 'online',
                                status: 'uploaded',
                                total_amount: calculateTotal(),
                                razorpay_payment_id: response?.razorpay_payment_id || null,
                                razorpay_order_id: response?.razorpay_order_id || null,
                                razorpay_signature: response?.razorpay_signature || null,
                            }
                        ])
                        .select();
                    if (orderError) throw orderError;

                    setOrderId(orderData[0].id);
                    setOrderSuccess(true);
                    setCurrentStep(5);
                } catch (error) {
                    console.error('Error submitting order:', error);
                    alert(`Error submitting order: ${error.message}`);
                } finally {
                    setIsSubmitting(false);
                    setUploadProgress(0);
                }
            },
            modal: {
                ondismiss: function () {
                    // Optional: user closed without paying
                }
            }
        };

        const rzp = new window.Razorpay(options);
        rzp.open();
    };

    const handleSubmit = async () => {
        if (!formData.fullName || !formData.phoneNumber || !formData.address || !formData.pincode) {
            alert('Please fill all required fields');
            return;
        }
        
        if (!/^\d{10}$/.test(formData.phoneNumber)) {
            alert('Please enter a valid 10-digit phone number');
            return;
        }
        
        if (!/^\d{6}$/.test(formData.pincode)) {
            alert('Please enter a valid 6-digit pincode');
            return;
        }
        
        if (!isLoggedIn) {
            alert('Please log in to place your order. This ensures your order is properly tracked.');
            return;
        }
        
        // If online payment, open Razorpay and finish flow within handler
        if (paymentMethod === 'online') {
            if (!window.Razorpay) {
                alert('Payment gateway is loading. Please try again in a moment.');
                return;
            }
            await createRazorpayOrder(calculateTotal());
            return;
        }

        // COD flow (original)
        setIsSubmitting(true);
        try {
            const timestamp = new Date().getTime();
            const fileName = `${timestamp}_${file.name}`;
            const filePath = `workbooks/${fileName}`;

            const { error: uploadError } = await supabase.storage
                .from('workbooks')
                .upload(filePath, file, {
                    cacheControl: '3600',
                    upsert: false,
                    onUploadProgress: (progress) => {
                        setUploadProgress(Math.round((progress.loaded / progress.total) * 100));
                    }
                });
            if (uploadError) throw uploadError;

            const { data: { publicUrl } } = supabase.storage
                .from('workbooks')
                .getPublicUrl(filePath);

            const { data: orderData, error: orderError } = await supabase
                .from('custom_workbook_orders')
                .insert([
                    {
                        user_id: isLoggedIn ? (await supabase.auth.getUser()).data.user?.id : null,
                        pdf_file_url: publicUrl,
                        pages: estimatedPages,
                        binding_type: bindingType,
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

            setOrderId(orderData[0].id);
            setOrderSuccess(true);
            setCurrentStep(5);
        } catch (error) {
            console.error('Error submitting order:', error);
            alert(`Error submitting order: ${error.message}`);
        } finally {
            setIsSubmitting(false);
            setUploadProgress(0);
        }
    };

    const stepTitles = ['Upload & Binding', 'Delivery Details', 'Order Summary', 'Payment'];
    
    return (
        <div className="workbook-container">
            {!orderSuccess ? (
                <div className="workbook-page">
                    <div className="page-header">
                        <div className="brand-info">
                            <h1>Custom Workbook Printing</h1>
                            <p>Professional printing service with fast delivery</p>
                        </div>
                        
                        <div className="progress-indicator">
                            <div className="steps-nav">
                                {[1, 2, 3, 4].map((step) => (
                                    <div key={step} className="step-item">
                                        <div 
                                            className={`step-circle ${currentStep >= step ? 'active' : ''} ${currentStep > step ? 'completed' : ''}`}
                                            onClick={() => currentStep > step && setCurrentStep(step)}
                                        >
                                            {currentStep > step ? '✓' : step}
                                        </div>
                                        <span className="step-title">{stepTitles[step - 1]}</span>
                                    </div>
                                ))}
                            </div>
                            <div className="progress-track">
                                <div 
                                    className="progress-bar" 
                                    style={{ width: `${(currentStep - 1) * 33.33}%` }}
                                ></div>
                            </div>
                        </div>
                    </div>
                    
                    <div className="page-content">
                        {currentStep === 1 && (
                            <div className="step-page">
                                <div className="step-header">
                                    <h2>Upload Your Workbook & Select Binding</h2>
                                    <p>Upload your PDF file and choose your preferred binding type</p>
                                </div>
                                
                                <div className="step-body">
                                    <div className="upload-section">
                                        <div className={`file-upload-area ${file ? 'has-file' : ''}`}>
                                            <input 
                                                type="file" 
                                                accept=".pdf" 
                                                onChange={handleFileChange} 
                                                className="file-input"
                                                id="pdf-upload"
                                            />
                                            <label htmlFor="pdf-upload" className="upload-label">
                                                {file ? (
                                                    <div className="file-selected">
                                                        <div className="file-icon">📄</div>
                                                        <div className="file-info">
                                                            <span className="file-name">{file.name}</span>
                                                            <span className="file-size">{(file.size / (1024 * 1024)).toFixed(2)} MB</span>
                                                        </div>
                                                    </div>
                                                ) : (
                                                    <div className="upload-prompt">
                                                        <div className="upload-icon">📤</div>
                                                        <span className="upload-text">Click to upload PDF</span>
                                                        <span className="upload-subtext">Maximum file size: 25MB</span>
                                                    </div>
                                                )}
                                            </label>
                                        </div>
                                        
                                        {fileError && <div className="error-message">{fileError}</div>}
                                        
                                        {file && (
                                            <div className="file-details">
                                                <div className="detail-item">
                                                    <span>Estimated Pages:</span>
                                                    <span>{estimatedPages}</span>
                                                </div>
                                            </div>
                                        )}
                                    </div>

                                    <div className="binding-section">
                                        <h3>Choose Binding Type</h3>
                                        <div className="binding-options">
                                            {Object.entries(BINDING_CHARGES).map(([type, price]) => (
                                                <label key={type} className={`binding-option ${bindingType === type ? 'selected' : ''}`}>
                                                    <input 
                                                        type="radio" 
                                                        name="bindingType" 
                                                        value={type} 
                                                        checked={bindingType === type} 
                                                        onChange={handleBindingTypeChange} 
                                                    />
                                                    <div className="binding-content">
                                                        <div className="binding-icon">
                                                            {type === 'spiral' && '🌀'}
                                                            {type === 'tape' && '📎'}
                                                            {type === 'white' && '⚪'}
                                                            {type === 'normal' && '🖨️'}
                                                        </div>
                                                        <div className="binding-details">
                                                            <span className="binding-name">
                                                                {type === 'spiral' && 'Spiral Binding'}
                                                                {type === 'tape' && 'Tape Binding'}
                                                                {type === 'white' && 'White Binding'}
                                                                {type === 'normal' && 'Normal Printing'}
                                                            </span>
                                                            <span className="binding-price">₹{price}</span>
                                                        </div>
                                                    </div>
                                                </label>
                                            ))}
                                        </div>
                                    </div>
                                </div>
                                
                                <div className="step-footer">
                                    <button className="btn btn-primary btn-full" onClick={nextStep}>
                                        Continue
                                    </button>
                                </div>
                            </div>
                        )}
                        
                        {currentStep === 2 && (
                            <div className="step-page">
                                <div className="step-header">
                                    <h2>Delivery Information</h2>
                                    <p>Please provide accurate delivery details</p>
                                </div>
                                
                                <div className="step-body">
                                    <div className="form-container">
                                        <div className="form-group">
                                            <label>Full Name *</label>
                                            <input 
                                                type="text" 
                                                name="fullName" 
                                                value={formData.fullName} 
                                                onChange={handleInputChange} 
                                                placeholder="Enter your full name"
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
                                            />
                                        </div>
                                        
                                        <div className="form-group">
                                            <label>Delivery Address *</label>
                                            <textarea 
                                                name="address" 
                                                value={formData.address} 
                                                onChange={handleInputChange} 
                                                placeholder="Enter complete address with area details"
                                                rows="3"
                                            />
                                        </div>
                                        
                                        <div className="form-row">
                                            <div className="form-group">
                                                <label>Pincode *</label>
                                                <input 
                                                    type="text" 
                                                    name="pincode" 
                                                    value={formData.pincode} 
                                                    onChange={handleInputChange} 
                                                    placeholder="6-digit pincode"
                                                />
                                            </div>
                                            
                                            <div className="form-group">
                                                <label>Landmark (Optional)</label>
                                                <input 
                                                    type="text" 
                                                    name="landmark" 
                                                    value={formData.landmark} 
                                                    onChange={handleInputChange} 
                                                    placeholder="Nearby landmark"
                                                />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div className="step-footer">
                                    <button className="btn btn-secondary" onClick={prevStep}>
                                        Back
                                    </button>
                                    <button className="btn btn-primary" onClick={nextStep}>
                                        Continue
                                    </button>
                                </div>
                            </div>
                        )}
                        
                        {currentStep === 3 && (
                            <div className="step-page">
                                <div className="step-header">
                                    <h2>Order Summary</h2>
                                    <p>Review your order details</p>
                                </div>
                                
                                <div className="step-body">
                                    <div className="summary-container">
                                        <div className="order-summary">
                                            <div className="summary-row">
                                                <span>File:</span>
                                                <span>{file?.name}</span>
                                            </div>
                                            <div className="summary-row">
                                                <span>Estimated Pages:</span>
                                                <span>{estimatedPages}</span>
                                            </div>
                                            <div className="summary-row">
                                                <span>Binding Type:</span>
                                                <span>
                                                    {bindingType === 'spiral' && 'Spiral Binding'}
                                                    {bindingType === 'tape' && 'Tape Binding'}
                                                    {bindingType === 'white' && 'White Binding'}
                                                    {bindingType === 'normal' && 'Normal Printing'}
                                                </span>
                                            </div>
                                            <div className="summary-row">
                                                <span>Page Cost ({estimatedPages} pages):</span>
                                                <span>₹{estimatedPages * PER_PAGE_COST}</span>
                                            </div>
                                            <div className="summary-row">
                                                <span>Binding Charge:</span>
                                                <span>₹{BINDING_CHARGES[bindingType]}</span>
                                            </div>
                                            <div className="summary-row total">
                                                <span>Total Amount:</span>
                                                <span>₹{calculateTotal()}</span>
                                            </div>
                                        </div>
                                        
                                        <div className="delivery-promises">
                                            <div className="promise-item">
                                                <div className="promise-icon">🚚</div>
                                                <div>
                                                    <h4>Fast Delivery</h4>
                                                    <p>Delivered within 18 hours</p>
                                                </div>
                                            </div>
                                            <div className="promise-item">
                                                <div className="promise-icon">📱</div>
                                                <div>
                                                    <h4>SMS Updates</h4>
                                                    <p>Track your order status</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div className="step-footer">
                                    <button className="btn btn-secondary" onClick={prevStep}>
                                        Back
                                    </button>
                                    <button className="btn btn-primary" onClick={nextStep}>
                                        Continue
                                    </button>
                                </div>
                            </div>
                        )}
                        
                        {currentStep === 4 && (
                            <div className="step-page">
                                <div className="step-header">
                                    <h2>Payment Method</h2>
                                    <p>Choose your preferred payment option</p>
                                </div>
                                
                                <div className="step-body">
                                    <div className="payment-container">
                                        <div className="total-banner">
                                            <span>Total Amount: ₹{calculateTotal()}</span>
                                        </div>
                                        
                                        <div className="payment-options">
                                            <label className={`payment-option ${paymentMethod === 'online' ? 'selected' : ''}`}>
                                                <input 
                                                    type="radio" 
                                                    name="paymentMethod" 
                                                    value="online" 
                                                    checked={paymentMethod === 'online'} 
                                                    onChange={handlePaymentMethodChange} 
                                                />
                                                <div className="payment-content">
                                                    <div className="payment-icon">💳</div>
                                                    <div className="payment-details">
                                                        <span className="payment-name">Online Payment</span>
                                                        <span className="payment-desc">Pay securely with Razorpay</span>
                                                    </div>
                                                    <div className="selection-indicator"></div>
                                                </div>
                                            </label>
                                            <label className={`payment-option ${paymentMethod === 'cod' ? 'selected' : ''}`}>
                                                <input 
                                                    type="radio" 
                                                    name="paymentMethod" 
                                                    value="cod" 
                                                    checked={paymentMethod === 'cod'} 
                                                    onChange={handlePaymentMethodChange} 
                                                />
                                                <div className="payment-content">
                                                    <div className="payment-icon">💵</div>
                                                    <div className="payment-details">
                                                        <span className="payment-name">Cash on Delivery</span>
                                                        <span className="payment-desc">Pay when you receive</span>
                                                    </div>
                                                    <div className="selection-indicator"></div>
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                
                                <div className="step-footer">
                                    <button className="btn btn-secondary" onClick={prevStep}>
                                        Back
                                    </button>
                                    <button 
                                        className="btn btn-success" 
                                        onClick={handleSubmit}
                                        disabled={isSubmitting}
                                    >
                                        {isSubmitting ? (
                                            <>
                                                <div className="spinner"></div>
                                                {uploadProgress > 0 ? `Uploading ${uploadProgress}%` : 'Processing...'}
                                            </>
                                        ) : (
                                            'Place Order'
                                        )}
                                    </button>
                                </div>
                            </div>
                        )}
                    </div>
                </div>
            ) : (
                <div className="success-screen">
                    <div className="success-icon">✅</div>
                    <h1>Order Placed Successfully!</h1>
                    <p>Your workbook order has been received and is being processed</p>
                    <div className="order-id">Order ID: #{orderId}</div>
                    <div className="success-actions">
                        <button 
                            className="btn btn-primary" 
                            onClick={() => window.location.href = '/'}
                        >
                            Back to Home
                        </button>
                        <button 
                            className="btn btn-secondary" 
                            onClick={() => window.location.href = '/orders'}
                        >
                            View Orders
                        </button>
                    </div>
                </div>
            )}
        </div>
    );
}

export default ProjectPage;