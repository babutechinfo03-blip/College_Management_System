import React, { useState } from 'react';
import api from '../../../services/api';
import { useOffice } from '../../../context/OfficeContext';

const AddStaff = () => {
    const { refreshOfficeData } = useOffice();
    const [loading, setLoading] = useState(false);
    const [message, setMessage] = useState({ type: '', text: '' });
    const [generatedStaffId, setGeneratedStaffId] = useState('');
    const [photo, setPhoto] = useState(null);

    const [degrees, setDegrees] = useState([]);
    const [subDepartments, setSubDepartments] = useState([]);

    const [formData, setFormData] = useState({
        firstName: '',
        lastName: '',
        email: '',
        password: '',
        designation: '',
        roles: [],
        programType: '',
        degreeId: '',
        departmentId: '', // Maps to Sub-Department code
        phone: '',
        whatsappNumber: '',
        dob: '',
        address: '',
        bloodGroup: ''
    });

    const availableRoles = [
        { value: 'HOD', label: 'Head of Department (HOD)' },
        { value: 'FACULTY', label: 'Faculty' },
        { value: 'CLASS_ADVISOR', label: 'Class Advisor' },
        { value: 'ASSISTANT_STAFF', label: 'Assistant Staff' }
    ];

    // ============================================
    // PRODUCTION API LOGIC (RELIABLE FLOW)
    // ============================================

    const fetchDegrees = async (type) => {
        console.log('[DEBUG] Fetching degrees for:', type);
        try {
            // Using centralized api service for consistent headers/proxy
            const res = await api.get(`/degrees?programType=${type}`);
            console.log('[DEBUG] Degrees response:', res.data);
            setDegrees(res.data);
            setSubDepartments([]);
        } catch (err) {
            console.error('[ERROR] Failed to fetch degrees:', err);
            setDegrees([]);
        }
    };

    const fetchSubDepartments = async (degreeCode) => {
        console.log('[DEBUG] Fetching sub-departments for:', degreeCode);
        try {
            // Using centralized api service
            const res = await api.get(`/sub-departments?degree=${degreeCode}`);
            console.log('[DEBUG] Sub-Departments response:', res.data);
            setSubDepartments(res.data);
        } catch (err) {
            console.error('[ERROR] Failed to fetch sub-departments:', err);
            setSubDepartments([]);
        }
    };

    // ============================================

    const handleChange = (e) => {
        const { name, value } = e.target;

        setFormData(prev => {
            const updated = { ...prev, [name]: value };

            if (name === 'programType') {
                updated.degreeId = '';
                updated.departmentId = '';
                if (value) fetchDegrees(value);
            } else if (name === 'degreeId') {
                updated.departmentId = '';
                if (value) fetchSubDepartments(value);
            }

            return updated;
        });
    };

    const handlePhotoChange = (e) => {
        if (e.target.files && e.target.files[0]) {
            setPhoto(e.target.files[0]);
        }
    };

    const handleRoleToggle = (roleValue) => {
        setFormData(prev => ({
            ...prev,
            roles: prev.roles.includes(roleValue)
                ? prev.roles.filter(r => r !== roleValue)
                : [...prev.roles, roleValue]
        }));
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        setMessage({ type: '', text: '' });
        setGeneratedStaffId('');

        if (formData.roles.length === 0) {
            setMessage({ type: 'error', text: 'Please select at least one role' });
            setLoading(false);
            return;
        }

        try {
            const formDataToSend = new FormData();
            formDataToSend.append('data', JSON.stringify(formData));
            if (photo) {
                formDataToSend.append('photo', photo);
            }

            // Using centralized api service for the actual creation
            const response = await api.post('/office/staff', formDataToSend, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            });

            const staffId = response.data.staffId;
            setGeneratedStaffId(staffId);
            setMessage({
                type: 'success',
                text: `✅ Faculty created successfully! Generated Staff ID: ${staffId}`
            });
            refreshOfficeData();

            // Reset form
            setFormData({
                firstName: '',
                lastName: '',
                email: '',
                password: '',
                designation: '',
                roles: [],
                programType: '',
                degreeId: '',
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
            setDegrees([]);
            setSubDepartments([]);
        } catch (error) {
            const errorMsg = error.response?.data?.error || 'Failed to create staff';
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
                        Faculty Information
                    </h3>

                    {/* Personal Information */}
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
                            placeholder="faculty@college.edu"
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
                                placeholder="Faculty mobile"
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

                    <div style={{ marginBottom: '1.5rem' }}>
                        <label className="form-label">Designation</label>
                        <input
                            type="text"
                            name="designation"
                            className="form-control"
                            value={formData.designation}
                            onChange={handleChange}
                            placeholder="e.g., Professor, Assistant Professor"
                        />
                    </div>

                    {/* Academic Information */}
                    <h4 style={{ fontSize: '1.1rem', fontWeight: '600', marginBottom: '1rem', color: 'var(--slate-800)', marginTop: '2rem' }}>
                        Department Assignment
                    </h4>

                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1rem', marginBottom: '1.5rem' }}>
                        <div>
                            <label className="form-label">Program Type</label>
                            <select
                                name="programType"
                                className="form-control"
                                value={formData.programType}
                                onChange={handleChange}
                            >
                                <option value="">Select Type</option>
                                <option value="UG">Undergraduate (UG)</option>
                                <option value="PG">Postgraduate (PG)</option>
                            </select>
                        </div>

                        <div>
                            <label className="form-label">Degree</label>
                            <select
                                name="degreeId"
                                className="form-control"
                                value={formData.degreeId}
                                onChange={handleChange}
                            >
                                <option value="">Select Degree</option>
                                {degrees.map(d => (
                                    <option key={d.code} value={d.code}>{d.name}</option>
                                ))}
                            </select>
                        </div>

                        <div>
                            <label className="form-label">Department / Sub-Dept</label>
                            <select
                                name="departmentId"
                                className="form-control"
                                value={formData.departmentId}
                                onChange={handleChange}
                            >
                                <option value="">Select Department</option>
                                {subDepartments.map(s => (
                                    <option key={s} value={s}>{s}</option>
                                ))}
                            </select>
                        </div>
                    </div>

                    <div style={{ marginBottom: '1.5rem' }}>
                        <label className="form-label">Faculty Photo (Max 2MB)</label>
                        <input
                            type="file"
                            id="staffPhotoInput"
                            className="form-control"
                            accept="image/png, image/jpeg"
                            onChange={handlePhotoChange}
                        />
                    </div>

                    <div style={{ marginBottom: '1.5rem' }}>
                        <label className="form-label">Password *</label>
                        <input
                            type="password"
                            name="password"
                            className="form-control"
                            value={formData.password}
                            onChange={handleChange}
                            placeholder="Default password for staff login"
                            required
                        />
                        <small style={{ color: 'var(--text-muted)', fontSize: '0.875rem', marginTop: '0.5rem', display: 'block' }}>
                            Note: Staff ID will be auto-generated upon submission
                        </small>
                    </div>

                    <hr style={{ margin: '2rem 0', border: 'none', borderTop: '1px solid var(--slate-200)' }} />

                    {/* Role Assignment */}
                    <h3 style={{ fontSize: '1.25rem', fontWeight: '700', marginBottom: '1rem', color: 'var(--slate-900)' }}>
                        Role Assignment *
                    </h3>
                    <p style={{ fontSize: '0.875rem', color: 'var(--text-secondary)', marginBottom: '1.5rem' }}>
                        Select one or more roles for this faculty member
                    </p>

                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))', gap: '1rem', marginBottom: '2rem' }}>
                        {availableRoles.map(role => (
                            <div
                                key={role.value}
                                onClick={() => handleRoleToggle(role.value)}
                                style={{
                                    padding: '1rem',
                                    border: `2px solid ${formData.roles.includes(role.value) ? 'var(--primary)' : 'var(--slate-200)'}`,
                                    borderRadius: '8px',
                                    cursor: 'pointer',
                                    background: formData.roles.includes(role.value) ? 'rgba(99, 102, 241, 0.05)' : 'white',
                                    transition: 'all 0.3s ease',
                                    display: 'flex',
                                    alignItems: 'center',
                                    gap: '0.75rem'
                                }}
                                onMouseEnter={(e) => {
                                    if (!formData.roles.includes(role.value)) {
                                        e.currentTarget.style.borderColor = 'var(--primary)';
                                        e.currentTarget.style.background = 'rgba(99, 102, 241, 0.02)';
                                    }
                                }}
                                onMouseLeave={(e) => {
                                    if (!formData.roles.includes(role.value)) {
                                        e.currentTarget.style.borderColor = 'var(--slate-200)';
                                        e.currentTarget.style.background = 'white';
                                    }
                                }}
                            >
                                <div style={{
                                    width: '24px',
                                    height: '24px',
                                    borderRadius: '4px',
                                    border: `2px solid ${formData.roles.includes(role.value) ? 'var(--primary)' : 'var(--slate-300)'}`,
                                    background: formData.roles.includes(role.value) ? 'var(--primary)' : 'white',
                                    display: 'flex',
                                    alignItems: 'center',
                                    justifyContent: 'center',
                                    color: 'white',
                                    fontSize: '0.75rem',
                                    fontWeight: '700',
                                    flexShrink: 0
                                }}>
                                    {formData.roles.includes(role.value) && '✓'}
                                </div>
                                <div>
                                    <p style={{ fontWeight: '600', color: 'var(--slate-900)', margin: 0 }}>
                                        {role.label}
                                    </p>
                                </div>
                            </div>
                        ))}
                    </div>

                    <div style={{ display: 'flex', gap: '1rem', justifyContent: 'flex-end' }}>
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
                                    roles: [],
                                    programType: '',
                                    degreeId: '',
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
                                setDegrees([]);
                                setSubDepartments([]);
                            }}
                        >
                            Reset Form
                        </button>
                        <button
                            type="submit"
                            className="btn btn-primary"
                            disabled={loading}
                        >
                            {loading ? 'Creating...' : '➕ Create Faculty'}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    );
};

export default AddStaff;
