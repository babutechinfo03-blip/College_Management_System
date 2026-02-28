import React, { useState, useEffect } from 'react';
import api from '../../../services/api';
import { useOffice } from '../../../context/OfficeContext';

const PhotoModal = ({ show, onClose, studentId, photoPath, onUploadSuccess }) => {
    const [file, setFile] = useState(null);
    const [uploading, setUploading] = useState(false);

    if (!show) return null;

    const handleUpload = async () => {
        if (!file) return;
        setUploading(true);
        try {
            const formData = new FormData();
            formData.append('photo', file);

            await api.post(`/office/students/${studentId}/photo`, formData, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            });
            onUploadSuccess();
            onClose();
            setFile(null);
        } catch (error) {
            console.error('Upload failed', error);
            alert('Failed to upload photo');
        } finally {
            setUploading(false);
        }
    };

    const photoUrl = photoPath
        ? `http://localhost:8080/uploads/${photoPath}`
        : null;

    return (
        <div style={{
            position: 'fixed', top: 0, left: 0, right: 0, bottom: 0,
            background: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000
        }}>
            <div className="card" style={{ width: '400px', maxWidth: '90%', maxHeight: '90vh', overflowY: 'auto' }}>
                <h3 style={{ marginTop: 0 }}>Student Photo</h3>

                <div style={{ textAlign: 'center', margin: '1rem 0', background: '#f8fafc', padding: '1rem', borderRadius: '8px' }}>
                    {photoUrl ? (
                        <img src={photoUrl} alt="Student" style={{ maxWidth: '100%', maxHeight: '300px', borderRadius: '4px' }} />
                    ) : (
                        <div style={{ fontSize: '3rem' }}>👤</div>
                    )}
                </div>

                <div style={{ marginTop: '1rem' }}>
                    <label className="form-label">Replace Photo</label>
                    <input type="file" className="form-control" accept="image/*" onChange={(e) => setFile(e.target.files[0])} />
                </div>

                <div style={{ display: 'flex', gap: '1rem', marginTop: '1rem', justifyContent: 'flex-end' }}>
                    <button className="btn btn-secondary" onClick={onClose} disabled={uploading}>Close</button>
                    <button className="btn btn-primary" onClick={handleUpload} disabled={!file || uploading}>
                        {uploading ? 'Uploading...' : 'Upload New Photo'}
                    </button>
                </div>
            </div>
        </div>
    );
};

const EditStudentModal = ({ show, onClose, student, onSave }) => {
    const [formData, setFormData] = useState({ ...student });
    const [degrees, setDegrees] = useState([]);
    const [specializations, setSpecializations] = useState([]);
    const [loading, setLoading] = useState(false);
    const [isEditing, setIsEditing] = useState(false);

    useEffect(() => {
        if (show && student) {
            setFormData({
                ...student,
                currentYear: student.currentYear || '',
                currentSemester: student.currentSemester || '',
                batch: student.batch || '',
                degreeId: student.degree?.id || '',
                specializationId: student.specialization?.id || '',
                parentName: student.parentName || '',
                parentMobile: student.parentMobile || '',
                dob: student.dob || '',
                address: student.address || '',
                phone: student.phone || '',
                whatsappNumber: student.whatsappNumber || '',
                bloodGroup: student.bloodGroup || '',
                caste: student.caste || '',
                religion: student.religion || ''
            });
            fetchDegrees();
            if (student.degree?.code) {
                fetchSpecializations(student.degree.code);
            }
            setIsEditing(false); // Reset to read-only when modal opens
        }
    }, [show, student]);

    const fetchDegrees = async () => {
        try {
            const res = await api.get('/office/degrees?programType=UG'); // Simple fix: fetch all or manage program type
            setDegrees(res.data);
        } catch (err) { console.error(err); }
    };

    const fetchSpecializations = async (degreeCode) => {
        try {
            const res = await api.get(`/office/sub-departments?degree=${degreeCode}`);
            setSpecializations(res.data);
        } catch (err) { console.error(err); }
    };

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData(prev => {
            const updated = { ...prev, [name]: value };
            if (name === 'degreeId') {
                updated.specializationId = '';
                // Need degree code for specializing fetching
                const degree = degrees.find(d => d.id == value);
                if (degree) fetchSpecializations(degree.code);
            }
            return updated;
        });
    };

    const handleSave = async () => {
        setLoading(true);
        try {
            const payload = {
                firstName: formData.firstName,
                lastName: formData.lastName,
                email: formData.email,
                degreeId: formData.degreeId.toString(),
                specializationId: formData.specializationId.toString(),
                currentYear: formData.currentYear.toString(),
                currentSemester: formData.currentSemester ? formData.currentSemester.toString() : '1',
                batch: formData.batch,
                parentName: formData.parentName,
                parentMobile: formData.parentMobile,
                dob: formData.dob,
                address: formData.address,
                phone: formData.phone,
                whatsappNumber: formData.whatsappNumber,
                bloodGroup: formData.bloodGroup,
                caste: formData.caste,
                religion: formData.religion,
                password: formData.password
            };

            await api.put(`/office/students/${student.id}`, payload);
            onSave();
            onClose();
        } catch (error) {
            console.error('Update failed', error);
            alert('Failed to update student');
        } finally {
            setLoading(false);
        }
    };

    if (!show) return null;

    return (
        <div style={{
            position: 'fixed', top: 0, left: 0, right: 0, bottom: 0,
            background: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000
        }}>
            <div className="card" style={{ width: '600px', maxWidth: '90%', maxHeight: '90vh', overflowY: 'auto' }}>
                <h3>Edit Student</h3>
                <div style={{ display: 'grid', gap: '1rem', gridTemplateColumns: '1fr 1fr' }}>
                    <div>
                        <label className="form-label">First Name *</label>
                        <input name="firstName" className="form-control" value={formData.firstName} onChange={handleChange} readOnly={!isEditing} />
                    </div>
                    <div>
                        <label className="form-label">Last Name</label>
                        <input name="lastName" className="form-control" value={formData.lastName} onChange={handleChange} readOnly={!isEditing} />
                    </div>
                    <div style={{ gridColumn: 'span 2' }}>
                        <label className="form-label">Email *</label>
                        <input name="email" className="form-control" value={formData.email} onChange={handleChange} readOnly={!isEditing} />
                    </div>

                    <div style={{ gridColumn: 'span 2', background: '#eff6ff', padding: '1rem', borderRadius: '8px', border: '1px solid #dbeafe', display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                        <div style={{ gridColumn: 'span 2' }}>
                            <h4 style={{ margin: '0 0 0.5rem 0', color: '#1e40af', fontSize: '0.9rem', textTransform: 'uppercase', letterSpacing: '0.05em' }}>Login Credentials</h4>
                        </div>
                        <div>
                            <label className="form-label" style={{ color: '#1e3a8a' }}>Login Username</label>
                            <input className="form-control" value={student.studentId} readOnly style={{ backgroundColor: '#fff', borderColor: '#bfdbfe', color: '#1e40af', fontWeight: 'bold' }} />
                        </div>
                        <div>
                            <label className="form-label" style={{ color: '#1e3a8a' }}>Password</label>
                            {!isEditing ? (
                                <div style={{ fontSize: '1rem', fontWeight: 'bold', color: student.visiblePassword ? '#10b981' : '#94a3b8', background: '#fff', padding: '0.375rem 0.75rem', borderRadius: '0.25rem', border: '1px solid #cbd5e1' }}>
                                    {student.visiblePassword || "Not Saved (Encrypted)"}
                                </div>
                            ) : (
                                <>
                                    <div style={{ fontSize: '0.8rem', color: '#64748b', marginBottom: '0.25rem' }}>
                                        (Enter new password to reset)
                                    </div>
                                    <input
                                        name="password"
                                        type="text"
                                        className="form-control"
                                        placeholder="Type NEW password here"
                                        value={formData.password || ''}
                                        onChange={handleChange}
                                        style={{ borderColor: '#3b82f6' }}
                                    />
                                    <small style={{ color: '#059669', fontSize: '0.75rem', fontWeight: '500' }}>✓ Will be saved as visible text for Office</small>
                                </>
                            )}
                        </div>
                    </div>

                    <div>
                        <label className="form-label">Degree *</label>
                        <select name="degreeId" className="form-control" value={formData.degreeId} onChange={handleChange} disabled={!isEditing}>
                            <option value="">Select Degree</option>
                            {degrees.map(d => <option key={d.code} value={d.code}>{d.name}</option>)}
                        </select>
                    </div>
                    <div>
                        <label className="form-label">Sub-Department *</label>
                        <select name="specializationId" className="form-control" value={formData.specializationId} onChange={handleChange} disabled={!isEditing || !formData.degreeId}>
                            <option value="">Select Sub-Department</option>
                            {specializations.map(s => <option key={s.code} value={s.code}>{s.name}</option>)}
                        </select>
                    </div>
                    <div>
                        <label className="form-label">Year *</label>
                        <select name="currentYear" className="form-control" value={formData.currentYear} onChange={handleChange} disabled={!isEditing}>
                            {[1, 2, 3, 4].map(y => <option key={y} value={y}>{y}</option>)}
                        </select>
                    </div>
                    <div>
                        <label className="form-label">Semester *</label>
                        <select name="currentSemester" className="form-control" value={formData.currentSemester} onChange={handleChange} disabled={!isEditing}>
                            {formData.currentYear ? [formData.currentYear * 2 - 1, formData.currentYear * 2].map(s => <option key={s} value={s}>{s}</option>) : <option>1</option>}
                        </select>
                    </div>
                    <div>
                        <label className="form-label">Batch *</label>
                        <input name="batch" className="form-control" value={formData.batch} onChange={handleChange} readOnly={!isEditing} />
                    </div>

                    <div style={{ gridColumn: 'span 2' }}>
                        <h4 style={{ margin: '1rem 0 0.5rem 0', color: 'var(--slate-800)', borderBottom: '1px solid var(--slate-200)', paddingBottom: '0.25rem' }}>Personal Details</h4>
                    </div>

                    <div>
                        <label className="form-label">Phone Number *</label>
                        <input name="phone" className="form-control" value={formData.phone} onChange={handleChange} required readOnly={!isEditing} />
                    </div>
                    <div>
                        <label className="form-label">WhatsApp Number</label>
                        <input name="whatsappNumber" className="form-control" value={formData.whatsappNumber} onChange={handleChange} readOnly={!isEditing} />
                    </div>

                    <div>
                        <label className="form-label">Date of Birth *</label>
                        <input type="date" name="dob" className="form-control" value={formData.dob} onChange={handleChange} required readOnly={!isEditing} />
                    </div>
                    <div>
                        <label className="form-label">Blood Group</label>
                        <select name="bloodGroup" className="form-control" value={formData.bloodGroup} onChange={handleChange} disabled={!isEditing}>
                            <option value="">Select Blood Group</option>
                            {['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'].map(bg => (
                                <option key={bg} value={bg}>{bg}</option>
                            ))}
                        </select>
                    </div>

                    <div>
                        <label className="form-label">Parent/Guardian Name *</label>
                        <input name="parentName" className="form-control" value={formData.parentName} onChange={handleChange} required readOnly={!isEditing} />
                    </div>
                    <div>
                        <label className="form-label">Parent Mobile *</label>
                        <input name="parentMobile" className="form-control" value={formData.parentMobile} onChange={handleChange} required readOnly={!isEditing} />
                    </div>

                    <div>
                        <label className="form-label">Caste</label>
                        <input name="caste" className="form-control" value={formData.caste} onChange={handleChange} readOnly={!isEditing} />
                    </div>
                    <div>
                        <label className="form-label">Religion</label>
                        <input name="religion" className="form-control" value={formData.religion} onChange={handleChange} readOnly={!isEditing} />
                    </div>

                    <div style={{ gridColumn: 'span 2' }}>
                        <label className="form-label">Residential Address *</label>
                        <textarea name="address" className="form-control" value={formData.address} onChange={handleChange} rows="3" required readOnly={!isEditing}></textarea>
                    </div>
                </div>
                <div style={{ display: 'flex', gap: '1rem', marginTop: '1.5rem', justifyContent: 'flex-end' }}>
                    {!isEditing ? (
                        <>
                            <button className="btn btn-secondary" onClick={onClose}>Close</button>
                            <button className="btn btn-primary" onClick={() => setIsEditing(true)}>Edit Details</button>
                        </>
                    ) : (
                        <>
                            <button
                                className="btn btn-secondary"
                                onClick={() => {
                                    setIsEditing(false);
                                    setFormData({ ...student }); // Reset form to original values
                                }}
                                disabled={loading}
                            >
                                Cancel
                            </button>
                            <button className="btn btn-primary" onClick={handleSave} disabled={loading}>
                                {loading ? 'Saving...' : 'Save Changes'}
                            </button>
                        </>
                    )}
                </div>
            </div>
        </div>
    );
};


const StudentManagement = () => {
    const { refreshKey } = useOffice();
    const [students, setStudents] = useState([]);
    const [loading, setLoading] = useState(true);
    const [searchTerm, setSearchTerm] = useState('');
    const [filters, setFilters] = useState({
        degree: '',
        specialization: '',
        year: '',
        semester: '',
        isActive: ''
    });
    const [degrees, setDegrees] = useState([]);
    const [specializations, setSpecializations] = useState([]);
    const [editModal, setEditModal] = useState({ show: false, student: null });
    const [photoModal, setPhotoModal] = useState({ show: false, studentId: null, photoPath: null });

    useEffect(() => {
        fetchStudents();
        fetchDegrees();
    }, [refreshKey]);

    useEffect(() => {
        if (filters.degreeId) {
            fetchSpecializations(filters.degreeId);
        } else {
            setSpecializations([]);
        }
    }, [filters.degreeId]);

    const fetchStudents = async () => {
        try {
            setLoading(true);
            const queryParams = {};
            if (filters.degreeId) queryParams.degree = filters.degreeId;
            if (filters.specializationId) queryParams.specialization = filters.specializationId;
            if (filters.year) queryParams.year = filters.year;
            if (filters.isActive) queryParams.isActive = filters.isActive;

            console.log('Fetching students with params:', queryParams);
            const response = await api.get('/office/students', { params: queryParams });
            console.log('Students received:', response.data);
            setStudents(response.data);
        } catch (error) {
            console.error('Error fetching students:', error);
            const errorMsg = error.response?.data?.message || error.response?.data?.error || error.message;
            alert(`Failed to fetch students: ${errorMsg}`);
        } finally {
            setLoading(false);
        }
    };

    const fetchDegrees = async () => {
        try {
            // Fetch both UG and PG for filter list
            const [ugRes, pgRes] = await Promise.all([
                api.get('/office/degrees?programType=UG'),
                api.get('/office/degrees?programType=PG')
            ]);
            setDegrees([...ugRes.data, ...pgRes.data]);
        } catch (error) {
            console.error('Error fetching degrees:', error);
        }
    };

    const fetchSpecializations = async (degreeCode) => {
        try {
            const response = await api.get(`/office/sub-departments?degree=${degreeCode}`);
            setSpecializations(response.data);
        } catch (error) {
            console.error('Error fetching specializations:', error);
        }
    };

    const handleToggleStatus = async (studentId) => {
        try {
            await api.put(`/office/students/${studentId}/toggle-status`, {});
            fetchStudents();
        } catch (error) {
            console.error('Error toggling status:', error);
            alert('Failed to update status');
        }
    };

    const handleResetPassword = async (studentId) => {
        const newPassword = prompt('Enter new password:');
        if (!newPassword) return;

        try {
            await api.post(`/office/students/${studentId}/reset-password`, { newPassword });
            alert('Password reset successfully');
        } catch (error) {
            console.error('Error resetting password:', error);
            alert('Failed to reset password');
        }
    };

    const handleDelete = async (studentId, name) => {
        if (!window.confirm(`Are you sure you want to PERMANENTLY delete Student: ${name}? This action cannot be undone.`)) {
            return;
        }

        try {
            await api.delete(`/office/students/${studentId}`);
            alert('Student deleted successfully');
            fetchStudents();
        } catch (error) {
            console.error('Error deleting student:', error);
            alert(error.response?.data?.error || 'Failed to delete student');
        }
    };

    const filteredStudents = students.filter(student => {
        const searchLower = searchTerm.toLowerCase();
        const studentId = student.studentId?.toLowerCase() || '';
        const firstName = student.firstName?.toLowerCase() || '';
        const lastName = student.lastName?.toLowerCase() || '';
        const email = student.email?.toLowerCase() || '';

        return (
            studentId.includes(searchLower) ||
            firstName.includes(searchLower) ||
            lastName.includes(searchLower) ||
            email.includes(searchLower)
        );
    });

    return (
        <div>
            {/* Search and Filters */}
            <div className="card" style={{ marginBottom: '1.5rem' }}>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1rem' }}>
                    <input
                        type="text"
                        className="form-control"
                        placeholder="Search by ID, name, or email..."
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                    />
                    <select
                        className="form-control"
                        value={filters.degreeId}
                        onChange={(e) => setFilters({ ...filters, degreeId: e.target.value, specializationId: '' })}
                    >
                        <option value="">All Degrees</option>
                        {degrees.map(d => <option key={d.code} value={d.code}>{d.name}</option>)}
                    </select>

                    <select
                        className="form-control"
                        value={filters.year}
                        onChange={(e) => setFilters({ ...filters, year: e.target.value })}
                    >
                        <option value="">All Years</option>
                        <option value="1">Year 1</option>
                        <option value="2">Year 2</option>
                        <option value="3">Year 3</option>
                        <option value="4">Year 4</option>
                    </select>
                    <select
                        className="form-control"
                        value={filters.isActive}
                        onChange={(e) => setFilters({ ...filters, isActive: e.target.value })}
                    >
                        <option value="">All Status</option>
                        <option value="true">Active</option>
                        <option value="false">Inactive</option>
                    </select>
                    <button className="btn btn-primary" onClick={fetchStudents}>
                        Apply Filters
                    </button>
                </div>
            </div>

            {/* Students Table */}
            <div className="card">
                <div style={{ overflowX: 'auto' }}>
                    {loading ? (
                        <p style={{ textAlign: 'center', padding: '2rem', color: 'var(--text-secondary)' }}>
                            Loading students...
                        </p>
                    ) : filteredStudents.length === 0 ? (
                        <p style={{ textAlign: 'center', padding: '2rem', color: 'var(--text-secondary)' }}>
                            No students found
                        </p>
                    ) : (
                        <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                            <thead>
                                <tr style={{ borderBottom: '2px solid var(--slate-200)' }}>
                                    <th style={{ padding: '1rem', textAlign: 'left', fontWeight: '700', color: 'var(--slate-700)' }}>Photo</th>
                                    <th style={{ padding: '1rem', textAlign: 'left', fontWeight: '700', color: 'var(--slate-700)' }}>Student ID</th>
                                    <th style={{ padding: '1rem', textAlign: 'left', fontWeight: '700', color: 'var(--slate-700)' }}>Name</th>
                                    <th style={{ padding: '1rem', textAlign: 'left', fontWeight: '700', color: 'var(--slate-700)' }}>Email</th>
                                    <th style={{ padding: '1rem', textAlign: 'left', fontWeight: '700', color: 'var(--slate-700)' }}>Degree</th>
                                    <th style={{ padding: '1rem', textAlign: 'left', fontWeight: '700', color: 'var(--slate-700)' }}>Year</th>
                                    <th style={{ padding: '1rem', textAlign: 'left', fontWeight: '700', color: 'var(--slate-700)' }}>Status</th>
                                    <th style={{ padding: '1rem', textAlign: 'left', fontWeight: '700', color: 'var(--slate-700)' }}>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                {filteredStudents.map((student) => (
                                    <tr key={student.id} style={{ borderBottom: '1px solid var(--slate-100)' }}>
                                        <td style={{ padding: '1rem' }}>
                                            <div
                                                onClick={() => setPhotoModal({ show: true, studentId: student.id, photoPath: student.photoPath })}
                                                style={{
                                                    width: '40px',
                                                    height: '40px',
                                                    borderRadius: '50%',
                                                    background: 'var(--primary)',
                                                    color: 'white',
                                                    display: 'flex',
                                                    alignItems: 'center',
                                                    justifyContent: 'center',
                                                    fontWeight: '700',
                                                    cursor: 'pointer',
                                                    overflow: 'hidden'
                                                }}>
                                                {student.photoPath ? (
                                                    <img src={`http://localhost:8080/uploads/${student.photoPath}`} alt="" style={{ width: '100%', height: '100%', objectFit: 'cover' }} />
                                                ) : (
                                                    student.firstName.charAt(0)
                                                )}
                                            </div>
                                        </td>
                                        <td style={{ padding: '1rem', fontWeight: '600' }}>{student.studentId}</td>
                                        <td style={{ padding: '1rem' }}>{student.firstName} {student.lastName}</td>
                                        <td style={{ padding: '1rem', color: 'var(--text-secondary)' }}>{student.email}</td>
                                        <td style={{ padding: '1rem' }}>{student.degree?.name || 'N/A'}</td>
                                        <td style={{ padding: '1rem' }}>Year {student.currentYear}</td>
                                        <td style={{ padding: '1rem' }}>
                                            <span style={{
                                                padding: '0.25rem 0.75rem',
                                                borderRadius: '12px',
                                                fontSize: '0.75rem',
                                                fontWeight: '600',
                                                background: student.isActive ? '#d1fae5' : '#fee2e2',
                                                color: student.isActive ? '#059669' : '#dc2626'
                                            }}>
                                                {student.isActive ? 'Active' : 'Inactive'}
                                            </span>
                                        </td>
                                        <td style={{ padding: '1rem' }}>
                                            <div style={{ display: 'flex', gap: '0.5rem' }}>
                                                <button
                                                    className="btn btn-sm btn-secondary"
                                                    style={{ padding: '0.25rem 0.5rem', fontSize: '0.75rem' }}
                                                    onClick={() => setEditModal({ show: true, student })}
                                                    title="View Details"
                                                >
                                                    👁️
                                                </button>
                                                <button
                                                    className="btn btn-sm btn-secondary"
                                                    style={{ padding: '0.25rem 0.5rem', fontSize: '0.75rem' }}
                                                    onClick={() => handleResetPassword(student.id)}
                                                    title="Reset Password"
                                                >
                                                    🔄
                                                </button>
                                                <button
                                                    className="btn btn-sm btn-secondary"
                                                    style={{ padding: '0.25rem 0.5rem', fontSize: '0.75rem' }}
                                                    onClick={() => handleToggleStatus(student.id)}
                                                    title={student.isActive ? 'Deactivate' : 'Activate'}
                                                >
                                                    {student.isActive ? '🔒' : '🔓'}
                                                </button>
                                                <button
                                                    className="btn btn-sm btn-secondary"
                                                    style={{ padding: '0.25rem 0.5rem', fontSize: '0.75rem', color: '#dc2626' }}
                                                    onClick={() => handleDelete(student.id, student.firstName + ' ' + student.lastName)}
                                                    title="Delete Student"
                                                >
                                                    🗑️
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

            <PhotoModal
                show={photoModal.show}
                onClose={() => setPhotoModal({ ...photoModal, show: false })}
                studentId={photoModal.studentId}
                photoPath={photoModal.photoPath}
                onUploadSuccess={fetchStudents}
            />

            <EditStudentModal
                show={editModal.show}
                onClose={() => setEditModal({ show: false, student: null })}
                student={editModal.student}
                onSave={fetchStudents}
            />
        </div>
    );
};

export default StudentManagement;
