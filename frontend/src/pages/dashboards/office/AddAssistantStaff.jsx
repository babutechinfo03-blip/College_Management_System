import React, { useState } from 'react';
import api from '../../../services/api';
import { useOffice } from '../../../context/OfficeContext';

const AddAssistantStaff = () => {
    const { refreshOfficeData } = useOffice();
    const [loading, setLoading] = useState(false);
    const [message, setMessage] = useState({ type: '', text: '' });
    const [generatedStaffId, setGeneratedStaffId] = useState('');
    const [photo, setPhoto] = useState(null);

    const [formData, setFormData] = useState({
        firstName: '',
        lastName: '',
        email: '',
        password: '',
        designation: '',
        departmentId: '', // Simplified for Assistant Staff
        phone: '',
        whatsappNumber: '',
        dob: '',
        address: '',
        bloodGroup: ''
    });

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData(prev => ({ ...prev, [name]: value }));
    };

    const handlePhotoChange = (e) => {
        if (e.target.files && e.target.files[0]) {
            setPhoto(e.target.files[0]);
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        setMessage({ type: '', text: '' });
        setGeneratedStaffId('');

        try {
            const formDataToSend = new FormData();
            formDataToSend.append('data', JSON.stringify(formData));
            if (photo) {
                formDataToSend.append('photo', photo);
            }

            const response = await api.post('/office/assistant-staff', formDataToSend, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            });

            const staffId = response.data.staffId;
            setGeneratedStaffId(staffId);
            setMessage({
                type: 'success',
                text: `✅ Assistant Staff created successfully! Generated ID: ${staffId}`
            });
            refreshOfficeData();

            // Reset form
            setFormData({
                firstName: '',
                lastName: '',
                email: '',
                password: '',
                designation: '',
                departmentId: '',
                phone: '',
                whatsappNumber: '',
                dob: '',
                address: '',
                bloodGroup: ''
            });
            setPhoto(null);
            if (document.getElementById('staffPhotoInput')) {
                document.getElementById('staffPhotoInput').value = '';
            }
        } catch (error) {
            const errorMsg = error.response?.data?.error || 'Failed to create assistant staff';
            setMessage({ type: 'error', text: '❌ ' + errorMsg });
        } finally {
            setLoading(false);
        }
    };

    return (
        <div style={{ maxWidth: '800px' }}>
            {message.text && (
                <div className="card animate-fade-in" style={{
                    marginBottom: '1.5rem',
                    padding: '1rem',
                    background: message.type === 'success' ? '#d1fae5' : '#fee2e2',
                    border: `1px solid ${message.type === 'success' ? '#10b981' : '#ef4444'}`,
                    color: message.type === 'success' ? '#065f46' : '#991b1b'
                }}>
                    {message.text}
                </div>
            )}

            <div className="card">
                <form onSubmit={handleSubmit}>
                    <h3 style={{ fontSize: '1.25rem', fontWeight: '700', marginBottom: '1.5rem', color: 'var(--slate-900)' }}>
                        Assistant Staff Information
                    </h3>

                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1rem', marginBottom: '1.5rem' }}>
                        <div>
                            <label className="form-label">First Name *</label>
                            <input
                                type="text"
                                name="firstName"
                                className="form-control"
                                value={formData.firstName}
                                onChange={handleChange}
                                required
                            />
                        </div>

                        <div>
                            <label className="form-label">Last Name</label>
                            <input
                                type="text"
                                name="lastName"
                                className="form-control"
                                value={formData.lastName}
                                onChange={handleChange}
                            />
                        </div>
                    </div>

                    <div style={{ marginBottom: '1.5rem' }}>
                        <label className="form-label">Email *</label>
                        <input
                            type="email"
                            name="email"
                            className="form-control"
                            value={formData.email}
                            onChange={handleChange}
                            placeholder="assistant@college.edu"
                            required
                        />
                    </div>

                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1rem', marginBottom: '1.5rem' }}>
                        <div>
                            <label className="form-label">Phone Number *</label>
                            <input
                                type="text"
                                name="phone"
                                className="form-control"
                                value={formData.phone}
                                onChange={handleChange}
                                placeholder="Staff mobile"
                                required
                            />
                        </div>
                        <div>
                            <label className="form-label">WhatsApp Number</label>
                            <input
                                type="text"
                                name="whatsappNumber"
                                className="form-control"
                                value={formData.whatsappNumber}
                                onChange={handleChange}
                                placeholder="WhatsApp (if different)"
                            />
                        </div>
                    </div>

                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1rem', marginBottom: '1.5rem' }}>
                        <div>
                            <label className="form-label">Date of Birth *</label>
                            <input
                                type="date"
                                name="dob"
                                className="form-control"
                                value={formData.dob}
                                onChange={handleChange}
                                required
                            />
                        </div>
                        <div>
                            <label className="form-label">Blood Group</label>
                            <select
                                name="bloodGroup"
                                className="form-control"
                                value={formData.bloodGroup}
                                onChange={handleChange}
                            >
                                <option value="">Select Blood Group</option>
                                {['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'].map(bg => (
                                    <option key={bg} value={bg}>{bg}</option>
                                ))}
                            </select>
                        </div>
                    </div>

                    <div style={{ marginBottom: '1.5rem' }}>
                        <label className="form-label">Residential Address *</label>
                        <textarea
                            name="address"
                            className="form-control"
                            value={formData.address}
                            onChange={handleChange}
                            rows="3"
                            required
                        ></textarea>
                    </div>

                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1rem', marginBottom: '1.5rem' }}>
                        <div>
                            <label className="form-label">Designation</label>
                            <input
                                type="text"
                                name="designation"
                                className="form-control"
                                value={formData.designation}
                                onChange={handleChange}
                                placeholder="e.g., Lab Assistant, Office Assistant"
                            />
                        </div>
                        <div>
                            <label className="form-label">Department / Sub-Department</label>
                            <input
                                type="text"
                                name="departmentId"
                                className="form-control"
                                value={formData.departmentId}
                                onChange={handleChange}
                                placeholder="e.g., CSE, Main Office"
                            />
                        </div>
                    </div>

                    <div style={{ marginBottom: '1.5rem' }}>
                        <label className="form-label">Photo (Max 2MB)</label>
                        <input
                            type="file"
                            id="staffPhotoInput"
                            className="form-control"
                            accept="image/png, image/jpeg"
                            onChange={handlePhotoChange}
                        />
                    </div>

                    <div style={{ marginBottom: '1.5rem' }}>
                        <label className="form-label">Login Password *</label>
                        <input
                            type="password"
                            name="password"
                            className="form-control"
                            value={formData.password}
                            onChange={handleChange}
                            placeholder="Set initial password"
                            required
                        />
                        <small style={{ color: 'var(--text-muted)', fontSize: '0.875rem', marginTop: '0.5rem', display: 'block' }}>
                            Note: Assistant ID will be auto-generated (e.g., AST123456789)
                        </small>
                    </div>

                    <div style={{ display: 'flex', gap: '1rem', justifyContent: 'flex-end', marginTop: '2rem' }}>
                        <button
                            type="button"
                            className="btn btn-secondary"
                            onClick={() => {
                                setFormData({
                                    firstName: '',
                                    lastName: '',
                                    email: '',
                                    password: '',
                                    designation: '',
                                    departmentId: '',
                                    phone: '',
                                    whatsappNumber: '',
                                    dob: '',
                                    address: '',
                                    bloodGroup: ''
                                });
                                setMessage({ type: '', text: '' });
                                setGeneratedStaffId('');
                                setPhoto(null);
                                if (document.getElementById('staffPhotoInput')) {
                                    document.getElementById('staffPhotoInput').value = '';
                                }
                            }}
                        >
                            Reset Form
                        </button>
                        <button
                            type="submit"
                            className="btn btn-primary"
                            disabled={loading}
                        >
                            {loading ? 'Creating...' : '➕ Create Assistant Staff'}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    );
};

export default AddAssistantStaff;
