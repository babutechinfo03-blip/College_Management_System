import React, { useState } from 'react';
import api from '../../../services/api';
import { useOffice } from '../../../context/OfficeContext';

const AddStudent = () => {
    const { refreshOfficeData } = useOffice();
    const [degrees, setDegrees] = useState([]);
    const [specializations, setSpecializations] = useState([]);
    const [loading, setLoading] = useState(false);
    const [message, setMessage] = useState({ type: '', text: '' });
    const [photo, setPhoto] = useState(null);

    const [formData, setFormData] = useState({
        programType: '',
        studentId: '',
        email: '',
        password: '',
        firstName: '',
        lastName: '',
        degreeId: '',
        specializationId: '',
        currentYear: '',
        currentSemester: '',
        batch: new Date().getFullYear().toString(),
        parentName: '',
        parentMobile: '',
        dob: '',
        address: '',
        phone: '',
        whatsappNumber: '',
        bloodGroup: '',
        caste: '',
        religion: ''
    });

    const yearOptions = formData.programType === 'UG'
        ? [1, 2, 3, 4]
        : formData.programType === 'PG'
            ? [1, 2]
            : [];

    const semesterOptions = formData.currentYear
        ? [parseInt(formData.currentYear) * 2 - 1, parseInt(formData.currentYear) * 2]
        : [];

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
            setSpecializations([]);
        } catch (err) {
            console.error('[ERROR] Failed to fetch degrees:', err);
            setDegrees([]);
        }
    };

    const fetchSpecializations = async (degreeCode) => {
        console.log('[DEBUG] Fetching sub-departments for:', degreeCode);
        try {
            // Using centralized api service
            const res = await api.get(`/sub-departments?degree=${degreeCode}`);
            console.log('[DEBUG] Sub-Departments response:', res.data);
            setSpecializations(res.data);
        } catch (err) {
            console.error('[ERROR] Failed to fetch sub-departments:', err);
            setSpecializations([]);
        }
    };

    // ============================================

    const handleChange = (e) => {
        const { name, value } = e.target;

        setFormData(prev => {
            const updated = { ...prev, [name]: value };

            if (name === 'programType') {
                updated.degreeId = '';
                updated.specializationId = '';
                updated.currentYear = '';
                updated.currentSemester = '';
                if (value) fetchDegrees(value);
            } else if (name === 'degreeId') {
                updated.specializationId = '';
                if (value) fetchSpecializations(value);
            } else if (name === 'currentYear') {
                updated.currentSemester = '';
            }

            return updated;
        });
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

        if (!formData.programType || !formData.degreeId || !formData.specializationId || !formData.currentYear || !formData.currentSemester) {
            setMessage({ type: 'error', text: 'Please fill in all required fields' });
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
            await api.post('/office/students', formDataToSend, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            });

            setMessage({ type: 'success', text: '✅ Student created successfully!' });
            refreshOfficeData();

            // Reset form
            setFormData({
                programType: '',
                studentId: '',
                email: '',
                password: '',
                firstName: '',
                lastName: '',
                degreeId: '',
                specializationId: '',
                currentYear: '',
                currentSemester: '',
                batch: new Date().getFullYear().toString(),
                parentName: '',
                parentMobile: '',
                dob: '',
                address: '',
                phone: '',
                whatsappNumber: '',
                bloodGroup: '',
                caste: '',
                religion: ''
            });
            setPhoto(null);
            if (document.getElementById('photoInput')) {
                document.getElementById('photoInput').value = '';
            }

            setDegrees([]);
            setSpecializations([]);
        } catch (error) {
            const errorMsg = error.response?.data?.error || 'Failed to create student';
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
                        Student Information
                    </h3>

                    {/* Academic Hierarchy */}
                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1rem', marginBottom: '1.5rem' }}>
                        <div>
                            <label className="form-label">Program Type *</label>
                            <select
                                name="programType"
                                className="form-control"
                                value={formData.programType}
                                onChange={handleChange}
                                required
                            >
                                <option value="">Select Program</option>
                                <option value="UG">Undergraduate (UG)</option>
                                <option value="PG">Postgraduate (PG)</option>
                            </select>
                        </div>

                        <div>
                            <label className="form-label">Degree *</label>
                            <select
                                name="degreeId"
                                className="form-control"
                                value={formData.degreeId}
                                onChange={handleChange}
                                required
                            >
                                <option value="">Select Degree</option>
                                {degrees.map(d => (
                                    <option key={d.code} value={d.code}>{d.name}</option>
                                ))}
                            </select>
                        </div>
                    </div>

                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1rem', marginBottom: '1.5rem' }}>
                        <div>
                            <label className="form-label">Sub-Department *</label>
                            <select
                                name="specializationId"
                                className="form-control"
                                value={formData.specializationId}
                                onChange={handleChange}
                                required
                            >
                                <option value="">Select Sub-Department</option>
                                {specializations.map(s => (
                                    <option key={s} value={s}>{s}</option>
                                ))}
                            </select>
                        </div>

                        <div>
                            <label className="form-label">Batch Year *</label>
                            <input
                                type="text"
                                name="batch"
                                className="form-control"
                                value={formData.batch}
                                onChange={handleChange}
                                placeholder="e.g., 2024"
                                required
                            />
                        </div>
                    </div>

                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1rem', marginBottom: '1.5rem' }}>
                        <div>
                            <label className="form-label">Current Year *</label>
                            <select
                                name="currentYear"
                                className="form-control"
                                value={formData.currentYear}
                                onChange={handleChange}
                                disabled={!formData.programType}
                                required
                            >
                                <option value="">Select Year</option>
                                {yearOptions.map(year => (
                                    <option key={year} value={year}>Year {year}</option>
                                ))}
                            </select>
                        </div>

                        <div>
                            <label className="form-label">Semester *</label>
                            <select
                                name="currentSemester"
                                className="form-control"
                                value={formData.currentSemester}
                                onChange={handleChange}
                                disabled={!formData.currentYear}
                                required
                            >
                                <option value="">Select Semester</option>
                                {semesterOptions.map(sem => (
                                    <option key={sem} value={sem}>Semester {sem}</option>
                                ))}
                            </select>
                        </div>
                    </div>

                    <hr style={{ margin: '2rem 0', border: 'none', borderTop: '1px solid var(--slate-200)' }} />

                    {/* Personal Information */}
                    <h3 style={{ fontSize: '1.25rem', fontWeight: '700', marginBottom: '1.5rem', color: 'var(--slate-900)' }}>
                        Personal Information
                    </h3>

                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1rem', marginBottom: '1.5rem' }}>
                        <div>
                            <label className="form-label">Student ID *</label>
                            <input
                                type="text"
                                name="studentId"
                                className="form-control"
                                value={formData.studentId}
                                onChange={handleChange}
                                placeholder="e.g., 2024CSE001"
                                required
                            />
                            <small style={{ color: 'var(--slate-500)', fontSize: '0.85rem' }}>Unique ID set by Office</small>
                        </div>

                        <div>
                            <label className="form-label">Email *</label>
                            <input
                                type="email"
                                name="email"
                                className="form-control"
                                value={formData.email}
                                onChange={handleChange}
                                placeholder="student@college.edu"
                                required
                            />
                        </div>
                    </div>

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

                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1rem', marginBottom: '1.5rem' }}>
                        <div>
                            <label className="form-label">Phone Number *</label>
                            <input
                                type="text"
                                name="phone"
                                className="form-control"
                                value={formData.phone}
                                onChange={handleChange}
                                placeholder="Student mobile"
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

                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1rem', marginBottom: '1.5rem' }}>
                        <div>
                            <label className="form-label">Parent/Guardian Name *</label>
                            <input
                                type="text"
                                name="parentName"
                                className="form-control"
                                value={formData.parentName}
                                onChange={handleChange}
                                required
                            />
                        </div>
                        <div>
                            <label className="form-label">Parent Mobile *</label>
                            <input
                                type="text"
                                name="parentMobile"
                                className="form-control"
                                value={formData.parentMobile}
                                onChange={handleChange}
                                required
                            />
                        </div>
                    </div>

                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1rem', marginBottom: '1.5rem' }}>
                        <div>
                            <label className="form-label">Caste</label>
                            <input
                                type="text"
                                name="caste"
                                className="form-control"
                                value={formData.caste}
                                onChange={handleChange}
                            />
                        </div>
                        <div>
                            <label className="form-label">Religion</label>
                            <input
                                type="text"
                                name="religion"
                                className="form-control"
                                value={formData.religion}
                                onChange={handleChange}
                            />
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
                        <label className="form-label">Student Photo (Max 2MB)</label>
                        <input
                            type="file"
                            id="photoInput"
                            className="form-control"
                            accept="image/png, image/jpeg"
                            onChange={handlePhotoChange}
                        />
                    </div>

                    <div style={{ marginBottom: '2rem' }}>
                        <label className="form-label">Password *</label>
                        <input
                            type="password"
                            name="password"
                            className="form-control"
                            value={formData.password}
                            onChange={handleChange}
                            placeholder="Default password for student login"
                            required
                        />
                        <small style={{ color: 'var(--slate-500)', fontSize: '0.85rem' }}>Set by Office. Student cannot change this.</small>
                    </div>

                    <div style={{ display: 'flex', gap: '1rem', justifyContent: 'flex-end' }}>
                        <button
                            type="button"
                            className="btn btn-secondary"
                            onClick={() => {
                                setFormData({
                                    programType: '',
                                    studentId: '',
                                    email: '',
                                    password: '',
                                    firstName: '',
                                    lastName: '',
                                    degreeId: '',
                                    specializationId: '',
                                    currentYear: '',
                                    currentSemester: '',
                                    batch: new Date().getFullYear().toString(),
                                    parentName: '',
                                    parentMobile: '',
                                    dob: '',
                                    address: '',
                                    phone: '',
                                    whatsappNumber: '',
                                    bloodGroup: '',
                                    caste: '',
                                    religion: ''
                                });
                                setPhoto(null);
                                if (document.getElementById('photoInput')) {
                                    document.getElementById('photoInput').value = '';
                                }
                                setMessage({ type: '', text: '' });
                            }}
                        >
                            Reset Form
                        </button>
                        <button
                            type="submit"
                            className="btn btn-primary"
                            disabled={loading}
                        >
                            {loading ? 'Creating...' : '➕ Create Student'}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    );
};

export default AddStudent;
