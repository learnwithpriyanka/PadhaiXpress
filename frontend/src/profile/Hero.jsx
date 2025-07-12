// import React, { useState, useEffect } from 'react';
// import { supabase } from '../supabaseClient';
// import './Hero.css';

// function Hero() {
//     const [profile, setProfile] = useState({
//         name: '',
//         email: '',
//         university_id: '',
//         role: '',
//         address: ''
//     });
//     const [addressFields, setAddressFields] = useState({
//         street: '',
//         city: '',
//         state: '',
//         pincode: ''
//     });
//     const [editing, setEditing] = useState(false);
//     const [loading, setLoading] = useState(true);
//     const [error, setError] = useState('');
//     const [success, setSuccess] = useState('');

//     useEffect(() => {
//         fetchProfile();
//     }, []);

//     const fetchProfile = async () => {
//         setLoading(true);
//         setError('');
//         setSuccess('');
//         try {
//             const { data: { user } } = await supabase.auth.getUser();
//             if (!user) {
//                 setError('Not logged in');
//                 setLoading(false);
//                 return;
//             }
//             const { data, error } = await supabase
//                 .from('users')
//                 .select('*')
//                 .eq('id', user.id)
//                 .single();
//             if (error) {
//                 setError(error.message);
//             } else if (data) {
//                 setProfile(data);
//                 if (data.address) {
//                     // Try to parse address into fields if possible
//                     const match = data.address.match(/^(.*),\s*(.*),\s*(.*)\s*-\s*(\d{6})$/);
//                     if (match) {
//                         setAddressFields({
//                             street: match[1],
//                             city: match[2],
//                             state: match[3],
//                             pincode: match[4]
//                         });
//                     } else {
//                         setAddressFields({ street: '', city: '', state: '', pincode: '' });
//                     }
//                 } else {
//                     setAddressFields({ street: '', city: '', state: '', pincode: '' });
//                 }
//             }
//         } catch (err) {
//             setError('Failed to fetch profile');
//         }
//         setLoading(false);
//     };

//     const handleAddressChange = (e) => {
//         const { name, value } = e.target;
//         setAddressFields(prev => ({ ...prev, [name]: value }));
//     };

//     const handleAddressSubmit = async (e) => {
//         e.preventDefault();
//         setError('');
//         setSuccess('');
//         const { street, city, state, pincode } = addressFields;
//         if (!street || !city || !state || !pincode) {
//             setError('All address fields are required.');
//             return;
//         }
//         const addressString = `${street}, ${city}, ${state} - ${pincode}`;
//         try {
//             const { data: { user } } = await supabase.auth.getUser();
//             if (!user) {
//                 setError('Not logged in');
//                 return;
//             }
//             const { error: updateError } = await supabase
//                 .from('users')
//                 .update({ address: addressString })
//                 .eq('id', user.id);
//             if (updateError) {
//                 setError(updateError.message);
//             } else {
//                 setSuccess(editing ? 'Address updated successfully!' : 'Address added successfully!');
//                 setEditing(false);
//                 fetchProfile();
//             }
//         } catch (err) {
//             setError('Failed to update address');
//         }
//     };

//     const handleEdit = () => {
//         setEditing(true);
//     };

//     const handleDelete = async () => {
//         setError('');
//         setSuccess('');
//         try {
//             const { data: { user } } = await supabase.auth.getUser();
//             if (!user) {
//                 setError('Not logged in');
//                 return;
//             }
//             const { error: updateError } = await supabase
//                 .from('users')
//                 .update({ address: null })
//                 .eq('id', user.id);
//             if (updateError) {
//                 setError(updateError.message);
//             } else {
//                 setSuccess('Address deleted successfully!');
//                 setAddressFields({ street: '', city: '', state: '', pincode: '' });
//                 setEditing(false);
//                 fetchProfile();
//             }
//         } catch (err) {
//             setError('Failed to delete address');
//         }
//     };

//     if (loading) return <div>Loading...</div>;

//     return (
//         <div className="profile-container">
//             <div className="profile-header">
//                 <h1>My Profile</h1>
//                 <div className="profile-info">
//                     <p><strong>Name:</strong> {profile.name}</p>
//                     <p><strong>Email:</strong> {profile.email}</p>
//                     <p><strong>University ID:</strong> {profile.university_id}</p>
//                     <p><strong>Role:</strong> {profile.role}</p>
//                 </div>
//             </div>
//             <div className="address-section">
//                 <h2>Address</h2>
//                 {(!profile.address || editing) ? (
//                     <form onSubmit={handleAddressSubmit} className="address-form">
//                         <input
//                             type="text"
//                             name="street"
//                             placeholder="Street Address"
//                             value={addressFields.street}
//                             onChange={handleAddressChange}
//                             required
//                         />
//                         <input
//                             type="text"
//                             name="city"
//                             placeholder="City"
//                             value={addressFields.city}
//                             onChange={handleAddressChange}
//                             required
//                         />
//                         <input
//                             type="text"
//                             name="state"
//                             placeholder="State"
//                             value={addressFields.state}
//                             onChange={handleAddressChange}
//                             required
//                         />
//                         <input
//                             type="text"
//                             name="pincode"
//                             placeholder="PIN Code"
//                             value={addressFields.pincode}
//                             onChange={handleAddressChange}
//                             required
//                         />
//                         <div className="form-buttons">
//                             <button type="submit">{editing ? 'Update Address' : 'Add Address'}</button>
//                             {editing && (
//                                 <button type="button" onClick={() => setEditing(false)}>Cancel</button>
//                             )}
//                         </div>
//                     </form>
//                 ) : (
//                     <div className="address-list">
//                         <div className="address-card">
//                             <p>{profile.address}</p>
//                             <div className="address-actions">
//                                 <button onClick={handleEdit}>Update</button>
//                                 <button onClick={handleDelete}>Delete</button>
//                             </div>
//                         </div>
//                     </div>
//                 )}
//                 {error && <p style={{ color: 'red' }}>{error}</p>}
//                 {success && <p style={{ color: 'green' }}>{success}</p>}
//             </div>
//         </div>
//     );
// }

// export default Hero;
import React, { useState, useEffect } from 'react';
import { supabase } from '../supabaseClient';
import './Hero.css';

function Hero() {
    const [profile, setProfile] = useState({
        name: '',
        email: '',
        university_id: '',
        role: '',
        address: ''
    });
    const [addressFields, setAddressFields] = useState({
        street: '',
        city: '',
        state: '',
        pincode: ''
    });
    const [editing, setEditing] = useState(false);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');
    const [success, setSuccess] = useState('');

    useEffect(() => {
        fetchProfile();
    }, []);

    const fetchProfile = async () => {
        setLoading(true);
        setError('');
        setSuccess('');
        try {
            const { data: { user } } = await supabase.auth.getUser();
            if (!user) {
                setError('Not logged in');
                setLoading(false);
                return;
            }
            const { data, error } = await supabase
                .from('users')
                .select('*')
                .eq('id', user.id)
                .single();
            if (error) {
                setError(error.message);
            } else if (data) {
                setProfile(data);
                if (data.address) {
                    // Try to parse address into fields if possible
                    const match = data.address.match(/^(.*),\s*(.*),\s*(.*)\s*-\s*(\d{6})$/);
                    if (match) {
                        setAddressFields({
                            street: match[1],
                            city: match[2],
                            state: match[3],
                            pincode: match[4]
                        });
                    } else {
                        setAddressFields({ street: '', city: '', state: '', pincode: '' });
                    }
                } else {
                    setAddressFields({ street: '', city: '', state: '', pincode: '' });
                }
            }
        } catch (err) {
            setError('Failed to fetch profile');
        }
        setLoading(false);
    };

    const handleAddressChange = (e) => {
        const { name, value } = e.target;
        setAddressFields(prev => ({ ...prev, [name]: value }));
    };

    const handleAddressSubmit = async (e) => {
        e.preventDefault();
        setError('');
        setSuccess('');
        const { street, city, state, pincode } = addressFields;
        if (!street || !city || !state || !pincode) {
            setError('All address fields are required.');
            return;
        }
        const addressString = `${street}, ${city}, ${state} - ${pincode}`;
        try {
            const { data: { user } } = await supabase.auth.getUser();
            if (!user) {
                setError('Not logged in');
                return;
            }
            const { error: updateError } = await supabase
                .from('users')
                .update({ address: addressString })
                .eq('id', user.id);
            if (updateError) {
                setError(updateError.message);
            } else {
                setSuccess(editing ? 'Address updated successfully!' : 'Address added successfully!');
                setEditing(false);
                fetchProfile();
            }
        } catch (err) {
            setError('Failed to update address');
        }
    };

    const handleEdit = () => {
        setEditing(true);
    };

    const handleDelete = async () => {
        setError('');
        setSuccess('');
        try {
            const { data: { user } } = await supabase.auth.getUser();
            if (!user) {
                setError('Not logged in');
                return;
            }
            const { error: updateError } = await supabase
                .from('users')
                .update({ address: null })
                .eq('id', user.id);
            if (updateError) {
                setError(updateError.message);
            } else {
                setSuccess('Address deleted successfully!');
                setAddressFields({ street: '', city: '', state: '', pincode: '' });
                setEditing(false);
                fetchProfile();
            }
        } catch (err) {
            setError('Failed to delete address');
        }
    };

    if (loading) {
        return (
            <div className="loading-container">
                <div className="loading-content">
                    <div className="spinner"></div>
                    <p>Loading your profile...</p>
                </div>
            </div>
        );
    }

    return (
        <div className="profile-container">
            {/* Header */}
            <div className="profile-header-title">
                <h1>My Profile</h1>
                <p>Manage your personal information and preferences</p>
            </div>

            {/* Profile Information Card */}
            <div className="profile-card">
                <div className="profile-avatar">
                    <div className="avatar-circle">
                        <svg className="avatar-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                        </svg>
                    </div>
                </div>
                
                <div className="profile-info-grid">
                    <div className="profile-info-section">
                        <div className="profile-info-item">
                            <div className="info-icon">
                                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                                </svg>
                            </div>
                            <div className="info-content">
                                <p className="info-label">Name</p>
                                <p className="info-value">{profile.name}</p>
                            </div>
                        </div>
                        
                        <div className="profile-info-item">
                            <div className="info-icon">
                                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 8l7.89 7.89a2 2 0 002.82 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                                </svg>
                            </div>
                            <div className="info-content">
                                <p className="info-label">Email</p>
                                <p className="info-value">{profile.email}</p>
                            </div>
                        </div>
                    </div>
                    
                    <div className="profile-info-section">
                        <div className="profile-info-item">
                            <div className="info-icon">
                                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z" />
                                </svg>
                            </div>
                            <div className="info-content">
                                <p className="info-label">University ID</p>
                                <p className="info-value">{profile.university_id}</p>
                            </div>
                        </div>
                        
                        <div className="profile-info-item">
                            <div className="info-icon">
                                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                                </svg>
                            </div>
                            <div className="info-content">
                                <p className="info-label">Role</p>
                                <p className="info-value">{profile.role}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            {/* Address Section */}
            <div className="address-section">
                <div className="address-header">
                    <div className="address-title">
                        <svg className="address-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                        </svg>
                        <h2>Address</h2>
                    </div>
                </div>

                {(!profile.address || editing) ? (
                    <form onSubmit={handleAddressSubmit} className="address-form">
                        <div className="form-grid">
                            <div className="form-group">
                                <label className="form-label">Street Address</label>
                                <input
                                    type="text"
                                    name="street"
                                    placeholder="Enter street address"
                                    value={addressFields.street}
                                    onChange={handleAddressChange}
                                    required
                                    className="form-input"
                                />
                            </div>
                            
                            <div className="form-group">
                                <label className="form-label">City</label>
                                <input
                                    type="text"
                                    name="city"
                                    placeholder="Enter city"
                                    value={addressFields.city}
                                    onChange={handleAddressChange}
                                    required
                                    className="form-input"
                                />
                            </div>
                            
                            <div className="form-group">
                                <label className="form-label">State</label>
                                <input
                                    type="text"
                                    name="state"
                                    placeholder="Enter state"
                                    value={addressFields.state}
                                    onChange={handleAddressChange}
                                    required
                                    className="form-input"
                                />
                            </div>
                            
                            <div className="form-group">
                                <label className="form-label">PIN Code</label>
                                <input
                                    type="text"
                                    name="pincode"
                                    placeholder="Enter PIN code"
                                    value={addressFields.pincode}
                                    onChange={handleAddressChange}
                                    required
                                    className="form-input"
                                />
                            </div>
                        </div>
                        
                        <div className="form-buttons">
                            <button type="submit" className="btn-primary">
                                <svg className="btn-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                                </svg>
                                {editing ? 'Update Address' : 'Add Address'}
                            </button>
                            {editing && (
                                <button type="button" onClick={() => setEditing(false)} className="btn-secondary">
                                    <svg className="btn-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                                    </svg>
                                    Cancel
                                </button>
                            )}
                        </div>
                    </form>
                ) : (
                    <div className="address-display">
                        <div className="address-card">
                            <div className="address-content">
                                <div className="address-info">
                                    <svg className="address-pin-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                                    </svg>
                                    <p className="address-text">{profile.address}</p>
                                </div>
                                <div className="address-actions">
                                    <button onClick={handleEdit} className="btn-icon-action btn-edit" title="Update Address">
                                        <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                                        </svg>
                                    </button>
                                    <button onClick={handleDelete} className="btn-icon-action btn-delete" title="Delete Address">
                                        <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                        </svg>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                )}

                {/* Status Messages */}
                {error && (
                    <div className="alert alert-error">
                        <p>{error}</p>
                    </div>
                )}
                {success && (
                    <div className="alert alert-success">
                        <p>{success}</p>
                    </div>
                )}
            </div>
        </div>
    );
}

export default Hero;