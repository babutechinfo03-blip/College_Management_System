import React, { useState, useEffect } from 'react';
import api from '../../../services/api';

const UserOversight = () => {
    const [users, setUsers] = useState([]);
    const [loading, setLoading] = useState(true);

    // Filters & Search
    const [searchQuery, setSearchQuery] = useState('');
    const [roleFilter, setRoleFilter] = useState('');
    const [statusFilter, setStatusFilter] = useState('ALL'); // ALL, ACTIVE, INACTIVE

    // Sorting & Pagination
    const [sortBy, setSortBy] = useState('ID_ASC'); // ID_ASC, ID_DESC, NAME_ASC, NAME_DESC
    const [currentPage, setCurrentPage] = useState(1);
    const [itemsPerPage, setItemsPerPage] = useState(10);

    const [error, setError] = useState('');
    const [successMessage, setSuccessMessage] = useState('');

    const fetchUsers = async () => {
        try {
            setLoading(true);
            const res = await api.get('/principal/users'); // Fetch all to apply client side filters for instantaneous UX
            setUsers(res.data);
        } catch (err) {
            setError(err.response?.data?.error || 'Failed to load user directory.');
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchUsers();
    }, []);

    const handlePasswordReset = async (userId, username) => {
        if (!window.confirm(`Are you sure you want to FORCE reset the password for ${username}? (It will reset to username@123)`)) return;

        try {
            await api.post(`/principal/users/${userId}/reset-password`);
            setSuccessMessage(`Password reset successfully for ${username}.`);
            setTimeout(() => setSuccessMessage(''), 3000);
            fetchUsers();
        } catch (err) {
            setError(err.response?.data?.error || 'Password reset failed');
            setTimeout(() => setError(''), 3000);
        }
    };

    const handleToggleStatus = async (userId, username, isActive) => {
        if (!window.confirm(`Are you sure you want to ${isActive ? 'DEACTIVATE' : 'ACTIVATE'} ${username}?`)) return;

        try {
            await api.patch(`/principal/users/${userId}/toggle-status`);
            setSuccessMessage(`User status updated for ${username}.`);
            setTimeout(() => setSuccessMessage(''), 3000);
            fetchUsers();
        } catch (err) {
            setError(err.response?.data?.error || 'Status update failed');
            setTimeout(() => setError(''), 3000);
        }
    };

    // Apply Data Transformations (Filter -> Sort -> Paginate)
    let processedUsers = [...users];

    // 1. Search Filter
    if (searchQuery) {
        const query = searchQuery.toLowerCase();
        processedUsers = processedUsers.filter(u =>
            (u.username && u.username.toLowerCase().includes(query)) ||
            (u.email && u.email.toLowerCase().includes(query)) ||
            (u.id && u.id.toString().includes(query))
        );
    }

    // 2. Role Filter
    if (roleFilter) {
        processedUsers = processedUsers.filter(u => u.role === roleFilter);
    }

    // 3. Status Filter
    if (statusFilter !== 'ALL') {
        const isActive = statusFilter === 'ACTIVE';
        processedUsers = processedUsers.filter(u => u.active === isActive);
    }

    // 4. Sorting
    processedUsers.sort((a, b) => {
        switch (sortBy) {
            case 'ID_ASC': return a.id - b.id;
            case 'ID_DESC': return b.id - a.id;
            case 'NAME_ASC': return (a.username || '').localeCompare(b.username || '');
            case 'NAME_DESC': return (b.username || '').localeCompare(a.username || '');
            default: return 0;
        }
    });

    // 5. Pagination
    const totalPages = Math.ceil(processedUsers.length / itemsPerPage);
    const paginatedUsers = processedUsers.slice((currentPage - 1) * itemsPerPage, currentPage * itemsPerPage);

    // Reset page if out of bounds after filter change
    useEffect(() => {
        if (currentPage > totalPages && totalPages > 0) {
            setCurrentPage(1);
        }
    }, [processedUsers.length, totalPages, currentPage]);

    return (
        <div className="animate-fade-in dashboard-content">
            <div className="flex justify-between items-center mb-6">
                <div>
                    <h2 className="text-2xl font-bold" style={{ color: 'var(--text-main)' }}>Global User Directory</h2>
                    <p style={{ color: 'var(--text-muted)' }}>Institute-wide directory with administrative override controls</p>
                </div>
            </div>

            <div className="card" style={{ background: '#FFFFFF', padding: '24px', borderRadius: '12px', border: '1px solid #E5E7EB', marginBottom: '24px', boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.05)' }}>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '16px' }}>
                    {/* Search */}
                    <div>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: '600', color: '#374151', marginBottom: '8px', textTransform: 'uppercase' }}>Search Directory</label>
                        <input
                            type="text"
                            placeholder="ID, Username, Email..."
                            value={searchQuery}
                            onChange={(e) => setSearchQuery(e.target.value)}
                            style={{ width: '100%', padding: '10px 16px', borderRadius: '8px', border: '1px solid #E5E7EB', outline: 'none', fontSize: '0.9rem' }}
                        />
                    </div>

                    {/* Role Filter */}
                    <div>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: '600', color: '#374151', marginBottom: '8px', textTransform: 'uppercase' }}>Role Filter</label>
                        <select
                            value={roleFilter}
                            onChange={(e) => setRoleFilter(e.target.value)}
                            style={{ width: '100%', padding: '10px 16px', borderRadius: '8px', border: '1px solid #E5E7EB', outline: 'none', background: '#FFFFFF', fontSize: '0.9rem' }}
                        >
                            <option value="">All Roles</option>
                            <option value="STUDENT">Student</option>
                            <option value="FACULTY">Faculty</option>
                            <option value="HOD">HOD</option>
                            <option value="OFFICE">Office</option>
                            <option value="PRINCIPAL">Principal</option>
                        </select>
                    </div>

                    {/* Status Filter */}
                    <div>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: '600', color: '#374151', marginBottom: '8px', textTransform: 'uppercase' }}>Account Status</label>
                        <select
                            value={statusFilter}
                            onChange={(e) => setStatusFilter(e.target.value)}
                            style={{ width: '100%', padding: '10px 16px', borderRadius: '8px', border: '1px solid #E5E7EB', outline: 'none', background: '#FFFFFF', fontSize: '0.9rem' }}
                        >
                            <option value="ALL">All Statuses</option>
                            <option value="ACTIVE">Active Users</option>
                            <option value="INACTIVE">Suspended Users</option>
                        </select>
                    </div>

                    {/* Sort By */}
                    <div>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: '600', color: '#374151', marginBottom: '8px', textTransform: 'uppercase' }}>Sort Configuration</label>
                        <select
                            value={sortBy}
                            onChange={(e) => setSortBy(e.target.value)}
                            style={{ width: '100%', padding: '10px 16px', borderRadius: '8px', border: '1px solid #E5E7EB', outline: 'none', background: '#FFFFFF', fontSize: '0.9rem' }}
                        >
                            <option value="ID_ASC">ID (Low to High)</option>
                            <option value="ID_DESC">ID (High to Low)</option>
                            <option value="NAME_ASC">Username (A-Z)</option>
                            <option value="NAME_DESC">Username (Z-A)</option>
                        </select>
                    </div>
                </div>
            </div>

            {error && <div className="alert alert-error mb-4" style={{ background: '#fef2f2', color: '#b91c1c', padding: '1rem', borderRadius: '0.5rem' }}>{error}</div>}
            {successMessage && <div className="alert alert-success mb-4" style={{ background: '#f0fdf4', color: '#15803d', padding: '1rem', borderRadius: '0.5rem' }}>{successMessage}</div>}

            <div className="card" style={{ background: 'var(--bg-card)', border: '1px solid var(--border)', borderRadius: 'var(--radius)' }}>
                {loading ? (
                    <div className="p-8 text-center" style={{ color: 'var(--text-muted)' }}>Loading Users...</div>
                ) : (
                    <div style={{ overflowX: 'auto' }}>
                        <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                            <thead style={{ background: 'rgba(0,0,0,0.02)' }}>
                                <tr>
                                    <th style={{ padding: '1rem', textAlign: 'left', color: 'var(--text-secondary)' }}>ID</th>
                                    <th style={{ padding: '1rem', textAlign: 'left', color: 'var(--text-secondary)' }}>Username</th>
                                    <th style={{ padding: '1rem', textAlign: 'left', color: 'var(--text-secondary)' }}>Email</th>
                                    <th style={{ padding: '1rem', textAlign: 'center', color: 'var(--text-secondary)' }}>Role</th>
                                    <th style={{ padding: '1rem', textAlign: 'center', color: 'var(--text-secondary)' }}>Status</th>
                                    <th style={{ padding: '1rem', textAlign: 'center', color: 'var(--text-secondary)' }}>Override Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                {paginatedUsers.map(user => (
                                    <tr key={user.id} style={{ borderBottom: '1px solid var(--border)', transition: 'background 0.2s' }} onMouseEnter={(e) => e.currentTarget.style.background = '#F8FAFC'} onMouseLeave={(e) => e.currentTarget.style.background = 'transparent'}>
                                        <td style={{ padding: '1rem', color: '#6B7280', fontWeight: '600' }}>#{user.id}</td>
                                        <td style={{ padding: '1rem', fontWeight: '600', color: '#111827' }}>{user.username}</td>
                                        <td style={{ padding: '1rem', color: '#4B5563' }}>{user.email || 'N/A'}</td>
                                        <td style={{ padding: '1rem', textAlign: 'center' }}>
                                            <span style={{
                                                background: user.role === 'PRINCIPAL' ? '#F3E8FF' : (user.role === 'OFFICE' ? '#ECFDF5' : '#EFF6FF'),
                                                color: user.role === 'PRINCIPAL' ? '#7E22CE' : (user.role === 'OFFICE' ? '#047857' : '#1D4ED8'),
                                                padding: '4px 8px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: '700'
                                            }}>
                                                {user.role}
                                            </span>
                                        </td>
                                        <td style={{ padding: '1rem', textAlign: 'center' }}>
                                            {user.active ? (
                                                <span style={{ background: '#DCFCE7', color: '#166534', padding: '4px 8px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: '700' }}>Active</span>
                                            ) : (
                                                <span style={{ background: '#FEE2E2', color: '#991B1B', padding: '4px 8px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: '700' }}>Suspended</span>
                                            )}
                                        </td>
                                        <td style={{ padding: '1rem', textAlign: 'center' }}>
                                            <button
                                                onClick={() => handlePasswordReset(user.id, user.username)}
                                                className="btn btn-sm hover-lift"
                                                style={{ background: '#3b82f6', color: 'white', border: 'none', padding: '0.4rem 0.8rem', borderRadius: '4px', marginRight: '0.5rem', fontSize: '0.75rem', fontWeight: '600', cursor: 'pointer' }}
                                                title="Force reset password to username@123"
                                                disabled={user.role === 'PRINCIPAL'} // Prevent self lockout
                                            >
                                                Force Reset PW
                                            </button>
                                            <button
                                                onClick={() => handleToggleStatus(user.id, user.username, user.active)}
                                                className="btn btn-sm hover-lift"
                                                style={{ background: user.active ? '#ef4444' : '#10b981', color: 'white', border: 'none', padding: '0.4rem 0.8rem', borderRadius: '4px', fontSize: '0.75rem', fontWeight: '600', cursor: 'pointer', opacity: user.role === 'PRINCIPAL' ? 0.5 : 1 }}
                                                disabled={user.role === 'PRINCIPAL'}
                                            >
                                                {user.active ? 'Deactivate' : 'Activate'}
                                            </button>
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                        {paginatedUsers.length === 0 && <div className="p-6 text-center" style={{ color: '#6B7280', padding: '32px' }}>No users match the specific query configuration.</div>}

                        {/* Pagination Controls */}
                        {totalPages > 1 && (
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '16px 24px', borderTop: '1px solid #E5E7EB', background: '#F8FAFC' }}>
                                <div style={{ fontSize: '0.85rem', color: '#6B7280' }}>
                                    Showing {(currentPage - 1) * itemsPerPage + 1} to {Math.min(currentPage * itemsPerPage, processedUsers.length)} of {processedUsers.length} users
                                </div>
                                <div style={{ display: 'flex', gap: '8px', alignItems: 'center' }}>
                                    <select
                                        value={itemsPerPage}
                                        onChange={(e) => { setItemsPerPage(Number(e.target.value)); setCurrentPage(1); }}
                                        style={{ padding: '6px 12px', borderRadius: '4px', border: '1px solid #E5E7EB', fontSize: '0.85rem', outline: 'none' }}
                                    >
                                        <option value={10}>10 / page</option>
                                        <option value={20}>20 / page</option>
                                        <option value={50}>50 / page</option>
                                    </select>
                                    <button
                                        onClick={() => setCurrentPage(prev => Math.max(prev - 1, 1))}
                                        disabled={currentPage === 1}
                                        style={{ padding: '6px 12px', background: currentPage === 1 ? '#F3F4F6' : '#FFFFFF', border: '1px solid #E5E7EB', borderRadius: '4px', color: currentPage === 1 ? '#9CA3AF' : '#374151', cursor: currentPage === 1 ? 'not-allowed' : 'pointer', fontWeight: '600' }}
                                    >
                                        Prev
                                    </button>
                                    <span style={{ fontSize: '0.85rem', fontWeight: '600', color: '#374151', padding: '0 8px' }}>Page {currentPage} of {totalPages}</span>
                                    <button
                                        onClick={() => setCurrentPage(prev => Math.min(prev + 1, totalPages))}
                                        disabled={currentPage === totalPages}
                                        style={{ padding: '6px 12px', background: currentPage === totalPages ? '#F3F4F6' : '#FFFFFF', border: '1px solid #E5E7EB', borderRadius: '4px', color: currentPage === totalPages ? '#9CA3AF' : '#374151', cursor: currentPage === totalPages ? 'not-allowed' : 'pointer', fontWeight: '600' }}
                                    >
                                        Next
                                    </button>
                                </div>
                            </div>
                        )}
                    </div>
                )}
            </div>
        </div>
    );
};

export default UserOversight;
