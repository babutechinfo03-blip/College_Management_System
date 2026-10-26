import React, { useState, useEffect } from 'react';
import api from '../../../services/api';
import { useOffice } from '../../../context/OfficeContext';
import jsPDF from 'jspdf';
import 'jspdf-autotable';

const PhotoModal = ({ show, onClose, staffId, photoPath, onUploadSuccess }) => {
    const [file, setFile] = useState(null);
    const [uploading, setUploading] = useState(false);

    if (!show) return null;

    const handleUpload = async () => {
        if (!file) return;
        setUploading(true);
        try {
            const formData = new FormData();
            formData.append('photo', file);

            await api.post(`/office/assistant-staff/${staffId}/photo`, formData, {
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
                <h3 style={{ marginTop: 0 }}>Staff Photo</h3>

                <div style={{ textAlign: 'center', margin: '1rem 0', background: '#f8fafc', padding: '1rem', borderRadius: '8px' }}>
                    {photoUrl ? (
                        <img src={photoUrl} alt="Staff" style={{ maxWidth: '100%', maxHeight: '300px', borderRadius: '4px' }} />
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

const EditAssistantStaffModal = ({ show, onClose, staff, onSave }) => {
    const [formData, setFormData] = useState({ ...staff });
    const [loading, setLoading] = useState(false);
    const [isEditing, setIsEditing] = useState(false);

    useEffect(() => {
        if (show && staff) {
            setFormData({
                ...staff,
                designation: staff.designation || '',
                departmentId: staff.department?.name || staff.departmentId || '', // Handle both object and string
                phone: staff.phone || '',
                whatsappNumber: staff.whatsappNumber || '',
                dob: staff.dob || '',
                address: staff.address || '',
                bloodGroup: staff.bloodGroup || ''
            });
            setIsEditing(false); // Reset to read-only when modal opens
        }
    }, [show, staff]);

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData(prev => ({ ...prev, [name]: value }));
    };

    const handleSave = async () => {
        setLoading(true);
        try {
            const payload = {
                firstName: formData.firstName,
                lastName: formData.lastName,
                email: formData.email,
                designation: formData.designation,
                departmentId: formData.departmentId,
                phone: formData.phone,
                whatsappNumber: formData.whatsappNumber,
                dob: formData.dob,
                address: formData.address,
                bloodGroup: formData.bloodGroup,
                roles: ['ASSISTANT_STAFF'],
                password: formData.password
            };

            await api.put(`/office/assistant-staff/${staff.id}`, payload);
            onSave();
            onClose();
        } catch (error) {
            console.error('Update failed', error);
            alert('Failed to update assistant staff');
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
                <h3>Edit Assistant Staff</h3>
                <div style={{ display: 'grid', gap: '1rem' }}>
                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                        <div>
                            <label className="form-label">First Name *</label>
                            <input name="firstName" className="form-control" value={formData.firstName} onChange={handleChange} readOnly={!isEditing} />
                        </div>
                        <div>
                            <label className="form-label">Last Name</label>
                            <input name="lastName" className="form-control" value={formData.lastName} onChange={handleChange} readOnly={!isEditing} />
                        </div>
                    </div>
                    <div>
                        <label className="form-label">Email *</label>
                        <input name="email" className="form-control" value={formData.email} onChange={handleChange} readOnly={!isEditing} />
                    </div>

                    <div style={{ gridColumn: 'span 1', background: '#eff6ff', padding: '1rem', borderRadius: '8px', border: '1px solid #dbeafe', display: 'grid', gap: '1rem' }}>
                        <h4 style={{ margin: '0', color: '#1e40af', fontSize: '0.9rem', textTransform: 'uppercase', letterSpacing: '0.05em' }}>Login Credentials</h4>
                        <div>
                            <label className="form-label" style={{ color: '#1e3a8a' }}>Login Username</label>
                            <input className="form-control" value={staff.staffId} readOnly style={{ backgroundColor: '#fff', borderColor: '#bfdbfe', color: '#1e40af', fontWeight: 'bold' }} />
                        </div>
                        <div>
                            <label className="form-label" style={{ color: '#1e3a8a' }}>Password</label>
                            {!isEditing ? (
                                <div style={{ fontSize: '1rem', fontWeight: 'bold', color: staff.visiblePassword ? '#10b981' : '#94a3b8', background: '#fff', padding: '0.375rem 0.75rem', borderRadius: '0.25rem', border: '1px solid #cbd5e1' }}>
                                    {staff.visiblePassword || "Not Saved (Encrypted)"}
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

                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                        <div>
                            <label className="form-label">Designation</label>
                            <input name="designation" className="form-control" value={formData.designation} onChange={handleChange} readOnly={!isEditing} />
                        </div>
                        <div>
                            <label className="form-label">Department / sub-Dept</label>
                            <input name="departmentId" className="form-control" value={formData.departmentId} onChange={handleChange} readOnly={!isEditing} />
                        </div>
                    </div>

                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                        <div>
                            <label className="form-label">Phone Number *</label>
                            <input name="phone" className="form-control" value={formData.phone} onChange={handleChange} required readOnly={!isEditing} />
                        </div>
                        <div>
                            <label className="form-label">WhatsApp Number</label>
                            <input name="whatsappNumber" className="form-control" value={formData.whatsappNumber} onChange={handleChange} readOnly={!isEditing} />
                        </div>
                    </div>

                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
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
                    </div>

                    <div>
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
                                    setFormData({ ...staff });
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

const AssistantStaffManagement = () => {
    const { refreshKey } = useOffice();
    const [staffList, setStaffList] = useState([]);
    const [loading, setLoading] = useState(true);
    const [searchTerm, setSearchTerm] = useState('');
    const [filters, setFilters] = useState({
        isActive: ''
    });
    const [editModal, setEditModal] = useState({ show: false, staff: null });
    const [photoModal, setPhotoModal] = useState({ show: false, staffId: null, photoPath: null });

    useEffect(() => {
        fetchStaff();
    }, [filters, refreshKey]);

    const fetchStaff = async () => {
        setLoading(true);
        try {
            const params = new URLSearchParams();
            if (filters.isActive) params.append('isActive', filters.isActive);

            const response = await api.get(`/office/assistant-staff?${params}`);
            setStaffList(response.data);
        } catch (error) {
            console.error('Error fetching assistant staff:', error);
        } finally {
            setLoading(false);
        }
    };

    const handleToggleStatus = async (staffId) => {
        try {
            await api.put(`/office/assistant-staff/${staffId}/toggle-status`, {});
            fetchStaff();
        } catch (error) {
            console.error('Error toggling status:', error);
            alert('Failed to update status');
        }
    };

    const handleResetPassword = async (staffId) => {
        const newPassword = prompt('Enter new password:');
        if (!newPassword) return;

        try {
            await api.post(`/office/assistant-staff/${staffId}/reset-password`, { newPassword });
            alert('Password reset successfully');
        } catch (error) {
            console.error('Error resetting password:', error);
            alert('Failed to reset password');
        }
    };

    const handleDelete = async (staffId, name) => {
        if (!window.confirm(`Are you sure you want to PERMANENTLY delete Assistant Staff: ${name}? This action cannot be undone.`)) {
            return;
        }

        try {
            await api.delete(`/office/assistant-staff/${staffId}`);
            alert('Assistant staff deleted successfully');
            fetchStaff();
            // Also refresh overall office stats if context provides it
            // This is handled by fetchStaff if it updates the global state, 
            // but here we just need the list to be fresh.
        } catch (error) {
            console.error('Error deleting assistant staff:', error);
            alert(error.response?.data?.error || 'Failed to delete assistant staff');
        }
    };

    const filteredStaff = staffList.filter(staff => {
        const searchLower = searchTerm.toLowerCase();
        return (
            staff.staffId.toLowerCase().includes(searchLower) ||
            staff.firstName.toLowerCase().includes(searchLower) ||
            staff.lastName.toLowerCase().includes(searchLower) ||
            staff.email.toLowerCase().includes(searchLower)
        );
    });

    const handleExportCSV = () => {
        const headers = ['Staff ID', 'Name', 'Email', 'Designation', 'Status'];
        const csvContent = [
            headers.join(','),
            ...filteredStaff.map(s => [
                s.staffId,
                `${s.firstName} ${s.lastName}`,
                s.email,
                s.designation || 'N/A',
                s.isActive ? 'Active' : 'Inactive'
            ].map(v => `"${v}"`).join(','))
        ].join('\n');

        const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
        const link = document.createElement('a');
        link.href = URL.createObjectURL(blob);
        link.download = `Assistant_Staff_Export_${new Date().toISOString().split('T')[0]}.csv`;
        link.click();
    };

    const handleExportPDF = () => {
        const doc = new jsPDF();
        doc.setFontSize(16);
        doc.text('Elite College Administration', 14, 15);
        doc.setFontSize(12);
        doc.text(`Official Assistant Staff Directory - Generated on ${new Date().toLocaleDateString()}`, 14, 25);

        const tableColumn = ["Staff ID", "Name", "Email", "Designation", "Status"];
        const tableRows = filteredStaff.map(s => [
            s.staffId,
            `${s.firstName} ${s.lastName}`,
            s.email,
            s.designation || 'N/A',
            s.isActive ? 'Active' : 'Inactive'
        ]);

        doc.autoTable({
            startY: 30,
            head: [tableColumn],
            body: tableRows,
            styles: { fontSize: 8, cellPadding: 2 },
            headStyles: { fillColor: [30, 58, 138], textColor: 255 }
        });

        doc.save(`Assistant_Staff_Directory_${new Date().toISOString().split('T')[0]}.pdf`);
    };

    return (
        <div>
            {/* Action Bar */}
            <div style={{ display: 'flex', justifyContent: 'flex-end', gap: '12px', marginBottom: '16px' }}>
                <button onClick={handleExportCSV} style={{ padding: '8px 16px', background: '#10B981', color: 'white', border: 'none', borderRadius: '6px', fontWeight: '600', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}>
                    <span>📄</span> Export CSV
                </button>
                <button onClick={handleExportPDF} style={{ padding: '8px 16px', background: '#DC2626', color: 'white', border: 'none', borderRadius: '6px', fontWeight: '600', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}>
                    <span>🖨️</span> Export PDF
                </button>
            </div>

            {/* Search and Filters */}
            <div className="card" style={{ marginBottom: '1.5rem', background: '#FFFFFF', padding: '24px', borderRadius: '12px', border: '1px solid #E5E7EB', boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.05)' }}>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '16px' }}>
                    <input
                        type="text"
                        className="form-control"
                        placeholder="Search by ID, name, or email..."
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                    />
                    <select
                        className="form-control"
                        value={filters.isActive}
                        onChange={(e) => setFilters({ ...filters, isActive: e.target.value })}
                    >
                        <option value="">All Status</option>
                        <option value="true">Active</option>
                        <option value="false">Inactive</option>
                    </select>
                    <button className="btn btn-primary" onClick={fetchStaff}>
                        Refresh List
                    </button>
                </div>
            </div>

            {/* Staff Table */}
            <div className="card">
                <div style={{ overflowX: 'auto' }}>
                    {loading ? (
                        <p style={{ textAlign: 'center', padding: '2rem', color: 'var(--text-secondary)' }}>
                            Loading assistant staff...
                        </p>
                    ) : filteredStaff.length === 0 ? (
                        <p style={{ textAlign: 'center', padding: '2rem', color: 'var(--text-secondary)' }}>
                            No assistant staff found
                        </p>
                    ) : (
                        <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                            <thead>
                                <tr style={{ borderBottom: '2px solid var(--slate-200)' }}>
                                    <th style={{ padding: '1rem', textAlign: 'left', fontWeight: '700', color: 'var(--slate-700)' }}>Photo</th>
                                    <th style={{ padding: '1rem', textAlign: 'left', fontWeight: '700', color: 'var(--slate-700)' }}>ID</th>
                                    <th style={{ padding: '1rem', textAlign: 'left', fontWeight: '700', color: 'var(--slate-700)' }}>Name</th>
                                    <th style={{ padding: '1rem', textAlign: 'left', fontWeight: '700', color: 'var(--slate-700)' }}>Email</th>
                                    <th style={{ padding: '1rem', textAlign: 'left', fontWeight: '700', color: 'var(--slate-700)' }}>Designation</th>
                                    <th style={{ padding: '1rem', textAlign: 'left', fontWeight: '700', color: 'var(--slate-700)' }}>Status</th>
                                    <th style={{ padding: '1rem', textAlign: 'left', fontWeight: '700', color: 'var(--slate-700)' }}>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                {filteredStaff.map((staff) => (
                                    <tr key={staff.id} style={{ borderBottom: '1px solid var(--slate-100)' }}>
                                        <td style={{ padding: '1rem' }}>
                                            <div
                                                onClick={() => setPhotoModal({ show: true, staffId: staff.id, photoPath: staff.photoPath })}
                                                style={{
                                                    width: '40px',
                                                    height: '40px',
                                                    borderRadius: '50%',
                                                    background: 'var(--accent)',
                                                    color: 'white',
                                                    display: 'flex',
                                                    alignItems: 'center',
                                                    justifyContent: 'center',
                                                    fontWeight: '700',
                                                    cursor: 'pointer',
                                                    overflow: 'hidden'
                                                }}>
                                                {staff.photoPath ? (
                                                    <img src={`http://localhost:8080/uploads/${staff.photoPath}`} alt="" style={{ width: '100%', height: '100%', objectFit: 'cover' }} />
                                                ) : (
                                                    staff.firstName.charAt(0)
                                                )}
                                            </div>
                                        </td>
                                        <td style={{ padding: '1rem', fontWeight: '600' }}>{staff.staffId}</td>
                                        <td style={{ padding: '1rem' }}>{staff.firstName} {staff.lastName}</td>
                                        <td style={{ padding: '1rem', color: 'var(--text-secondary)' }}>{staff.email}</td>
                                        <td style={{ padding: '1rem' }}>{staff.designation || 'N/A'}</td>
                                        <td style={{ padding: '1rem' }}>
                                            <span style={{
                                                padding: '0.25rem 0.75rem',
                                                borderRadius: '12px',
                                                fontSize: '0.75rem',
                                                fontWeight: '600',
                                                background: staff.isActive ? '#d1fae5' : '#fee2e2',
                                                color: staff.isActive ? '#059669' : '#dc2626'
                                            }}>
                                                {staff.isActive ? 'Active' : 'Inactive'}
                                            </span>
                                        </td>
                                        <td style={{ padding: '1rem' }}>
                                            <div style={{ display: 'flex', gap: '0.5rem' }}>
                                                <button
                                                    className="btn btn-sm btn-secondary"
                                                    style={{ padding: '0.25rem 0.5rem', fontSize: '0.75rem' }}
                                                    onClick={() => setEditModal({ show: true, staff })}
                                                    title="View Details"
                                                >
                                                    👁️
                                                </button>
                                                <button
                                                    className="btn btn-sm btn-secondary"
                                                    style={{ padding: '0.25rem 0.5rem', fontSize: '0.75rem' }}
                                                    onClick={() => handleResetPassword(staff.id)}
                                                    title="Reset Password"
                                                >
                                                    🔄
                                                </button>
                                                <button
                                                    className="btn btn-sm btn-secondary"
                                                    style={{ padding: '0.25rem 0.5rem', fontSize: '0.75rem' }}
                                                    onClick={() => handleToggleStatus(staff.id)}
                                                    title={staff.isActive ? 'Deactivate' : 'Activate'}
                                                >
                                                    {staff.isActive ? '🔒' : '🔓'}
                                                </button>
                                                <button
                                                    className="btn btn-sm btn-secondary"
                                                    style={{ padding: '0.25rem 0.5rem', fontSize: '0.75rem', color: '#dc2626' }}
                                                    onClick={() => handleDelete(staff.id, staff.firstName + ' ' + staff.lastName)}
                                                    title="Delete Staff"
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
                staffId={photoModal.staffId}
                photoPath={photoModal.photoPath}
                onUploadSuccess={fetchStaff}
            />

            <EditAssistantStaffModal
                show={editModal.show}
                onClose={() => setEditModal({ show: false, staff: null })}
                staff={editModal.staff}
                onSave={fetchStaff}
            />
        </div>
    );
};

export default AssistantStaffManagement;
