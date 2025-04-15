import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './Hero.css';

function Hero() {
    const [profile, setProfile] = useState({
        name: '',
        email: '',
        phone: '',
        addresses: []
    });

    const [isEditing, setIsEditing] = useState(false);
    const [editAddress, setEditAddress] = useState(null);
    const [newAddress, setNewAddress] = useState({
        street: '',
        city: '',
        state: '',
        pincode: ''
    });

    useEffect(() => {
        fetchProfile();
    }, []);

    const fetchProfile = async () => {
        try {
            const token = localStorage.getItem('token');
            const response = await axios.get('http://localhost:8080/api/profile', {
                headers: { Authorization: `Bearer ${token}` }
            });
            setProfile(response.data);
        } catch (error) {
            console.error('Error fetching profile:', error);
        }
    };

    const handleAddressSubmit = async (e) => {
        e.preventDefault();
        try {
            const token = localStorage.getItem('token');
            if (isEditing) {
                await axios.put(`http://localhost:8080/api/profile/address/${editAddress._id}`, 
                    editAddress,
                    { headers: { Authorization: `Bearer ${token}` }}
                );
            } else {
                await axios.post('http://localhost:8080/api/profile/address', 
                    newAddress,
                    { headers: { Authorization: `Bearer ${token}` }}
                );
            }
            fetchProfile();
            resetForm();
        } catch (error) {
            console.error('Error saving address:', error);
        }
    };

    const resetForm = () => {
        setIsEditing(false);
        setEditAddress(null);
        setNewAddress({ street: '', city: '', state: '', pincode: '' });
    };

    return (
        <div className="profile-container">
            <div className="profile-header">
                <h1>My Profile</h1>
                <div className="profile-info">
                    <p><strong>Name:</strong> {profile.name}</p>
                    <p><strong>Email:</strong> {profile.email}</p>
                    <p><strong>Phone:</strong> {profile.phone}</p>
                </div>
            </div>

            <div className="address-section">
                <h2>My Addresses</h2>
                <div className="address-list">
                    {profile.addresses.map((address) => (
                        <div key={address._id} className="address-card">
                            <p>{address.street}</p>
                            <p>{address.city}, {address.state}</p>
                            <p>PIN: {address.pincode}</p>
                            <div className="address-actions">
                                <button onClick={() => {
                                    setIsEditing(true);
                                    setEditAddress(address);
                                }}>Edit</button>
                                <button onClick={async () => {
                                    const token = localStorage.getItem('token');
                                    await axios.delete(`http://localhost:8080/api/profile/address/${address._id}`, {
                                        headers: { Authorization: `Bearer ${token}` }
                                    });
                                    fetchProfile();
                                }}>Delete</button>
                            </div>
                        </div>
                    ))}
                </div>

                <form onSubmit={handleAddressSubmit} className="address-form">
                    <h3>{isEditing ? 'Edit Address' : 'Add New Address'}</h3>
                    <input
                        type="text"
                        placeholder="Street Address"
                        value={isEditing ? editAddress.street : newAddress.street}
                        onChange={(e) => isEditing 
                            ? setEditAddress({...editAddress, street: e.target.value})
                            : setNewAddress({...newAddress, street: e.target.value})
                        }
                        required
                    />
                    <input
                        type="text"
                        placeholder="City"
                        value={isEditing ? editAddress.city : newAddress.city}
                        onChange={(e) => isEditing
                            ? setEditAddress({...editAddress, city: e.target.value})
                            : setNewAddress({...newAddress, city: e.target.value})
                        }
                        required
                    />
                    <input
                        type="text"
                        placeholder="State"
                        value={isEditing ? editAddress.state : newAddress.state}
                        onChange={(e) => isEditing
                            ? setEditAddress({...editAddress, state: e.target.value})
                            : setNewAddress({...newAddress, state: e.target.value})
                        }
                        required
                    />
                    <input
                        type="text"
                        placeholder="PIN Code"
                        value={isEditing ? editAddress.pincode : newAddress.pincode}
                        onChange={(e) => isEditing
                            ? setEditAddress({...editAddress, pincode: e.target.value})
                            : setNewAddress({...newAddress, pincode: e.target.value})
                        }
                        required
                    />
                    <div className="form-buttons">
                        <button type="submit">
                            {isEditing ? 'Update Address' : 'Add Address'}
                        </button>
                        {isEditing && (
                            <button type="button" onClick={resetForm}>
                                Cancel
                            </button>
                        )}
                    </div>
                </form>
            </div>
        </div>
    );
}

export default Hero;