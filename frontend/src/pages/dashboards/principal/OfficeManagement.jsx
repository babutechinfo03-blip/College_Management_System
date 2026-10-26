import React, { useState, useEffect } from 'react';
import axios from 'axios';

const OfficeManagement = () => {
    const [users, setUsers] = useState([]);
    const [loading, setLoading] = useState(true);
    const [newUser, setNewUser] = useState({ username: '', email: '', password: '' });
    const [error, setError] = useState('');
    const [success, setSuccess] = useState('');

    useEffect(() => {
        fetchUsers();
    }, []);

    const fetchUsers = async () => {
        try {
            const response = await axios.get('/api/principal/office-users');

            // Auto-create hook if no office accounts exist
            if (response.data && response.data.length === 0) {
                try {
                    await axios.post('/api/principal/office-users', {
                        username: 'office_admin',
                        email: 'office@college.edu',
                        password: 'password'
                    });
                    // Re-fetch after auto-creation
                    const refresh = await axios.get('/api/principal/office-users');
                    setUsers(refresh.data);
                    setSuccess('Default office_admin account auto-created.');
                    setTimeout(() => setSuccess(''), 4000);
                } catch (createErr) {
                    console.error('Failed to auto-create default office admin:', createErr);
                }
            } else {
                setUsers(response.data);
            }

            setLoading(false);
        } catch (err) {
            console.error('Error fetching office users:', err);
            setLoading(false);
        }
    };

    const handleToggleStatus = async (userId) => {
        if (!window.confirm(`Are you sure you want to toggle this user's status?`)) return;
        try {
            await axios.patch(`/api/principal/users/${userId}/toggle-status`);
            fetchUsers(); // Refresh list
            setSuccess('User status updated.');
            setTimeout(() => setSuccess(''), 3000);
        } catch (err) {
            console.error('Error toggling status:', err);
            setError('Failed to toggle status.');
            setTimeout(() => setError(''), 3000);
        }
    };

    const handleResetPassword = async (userId, username) => {
        if (!window.confirm(`Are you sure you want to FORCE reset the password for ${username}? (It will reset to username@123)`)) return;

        try {
            await axios.post(`/api/principal/users/${userId}/reset-password`);
            setSuccess(`Password for ${username} reset successfully.`);
            setTimeout(() => setSuccess(''), 3000);
        } catch (err) {
            setError(err.response?.data?.error || 'Password reset failed');
            setTimeout(() => setError(''), 3000);
        }
    };

    const handleCreateUser = async (e) => {
        e.preventDefault();
        setError('');
        setSuccess('');
        try {
            await axios.post('/api/principal/office-users', newUser);
            setSuccess('Office user created successfully');
            setNewUser({ username: '', email: '', password: '' });
            fetchUsers();
        } catch (err) {
            setError(err.response?.data?.message || 'Failed to create user');
        }
    };

    return (
        <div className="animate-fade-in p-6">
            <h2 className="text-2xl font-bold mb-6" style={{ color: 'var(--text-main)' }}>Office Staff Management</h2>

            <div className="grid gap-8" style={{ display: 'grid', gridTemplateColumns: '1fr 2fr', gap: '2rem' }}>
                {/* Create User Form */}
                <div className="card p-6" style={{ background: 'var(--bg-card)', border: '1px solid var(--border)', borderRadius: 'var(--radius)', padding: '1.5rem', height: 'fit-content' }}>
                    <h3 className="text-lg font-bold mb-4" style={{ color: 'var(--text-main)' }}>Add New User</h3>
                    {error && <div style={{ color: 'var(--error)', marginBottom: '1rem', fontSize: '0.875rem' }}>{error}</div>}
                    {success && <div style={{ color: 'var(--success)', marginBottom: '1rem', fontSize: '0.875rem' }}>{success}</div>}

                    <form onSubmit={handleCreateUser} style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                        <div>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', color: 'var(--text-secondary)' }}>Username</label>
                            <input
                                type="text"
                                value={newUser.username}
                                onChange={(e) => setNewUser({ ...newUser, username: e.target.value })}
                                required
                                style={{ width: '100%', padding: '0.5rem', borderRadius: '4px', border: '1px solid var(--border)', background: 'var(--bg-main)', color: 'var(--text-main)' }}
                            />
                        </div>
                        <div>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', color: 'var(--text-secondary)' }}>Email</label>
                            <input
                                type="email"
                                value={newUser.email}
                                onChange={(e) => setNewUser({ ...newUser, email: e.target.value })}
                                required
                                style={{ width: '100%', padding: '0.5rem', borderRadius: '4px', border: '1px solid var(--border)', background: 'var(--bg-main)', color: 'var(--text-main)' }}
                            />
                        </div>
                        <div>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', color: 'var(--text-secondary)' }}>Password</label>
                            <input
                                type="password"
                                value={newUser.password}
                                onChange={(e) => setNewUser({ ...newUser, password: e.target.value })}
                                required
                                style={{ width: '100%', padding: '0.5rem', borderRadius: '4px', border: '1px solid var(--border)', background: 'var(--bg-main)', color: 'var(--text-main)' }}
                            />
                        </div>
                        <button type="submit" className="btn btn-primary" style={{ marginTop: '1rem', padding: '0.75rem', background: 'var(--primary)', color: 'white', border: 'none', borderRadius: '4px', cursor: 'pointer' }}>
                            Create User
                        </button>
                    </form>
                </div>

                {/* User List */}
                <div className="card p-6" style={{ background: 'var(--bg-card)', border: '1px solid var(--border)', borderRadius: 'var(--radius)', padding: '1.5rem' }}>
                    <h3 className="text-lg font-bold mb-4" style={{ color: 'var(--text-main)' }}>Existing Staff</h3>

                    {loading ? (
                        <div>Loading users...</div>
                    ) : (
                        <div style={{ overflowX: 'auto' }}>
                            <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                                <thead>
                                    <tr style={{ borderBottom: '2px solid var(--border)', textAlign: 'left' }}>
                                        <th style={{ padding: '0.75rem', color: 'var(--text-secondary)' }}>Username</th>
                                        <th style={{ padding: '0.75rem', color: 'var(--text-secondary)' }}>Email</th>
                                        <th style={{ padding: '0.75rem', color: 'var(--text-secondary)' }}>Status</th>
                                        <th style={{ padding: '0.75rem', color: 'var(--text-secondary)' }}>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {users.map(user => (
                                        <tr key={user.id} style={{ borderBottom: '1px solid var(--border)' }}>
                                            <td style={{ padding: '0.75rem', color: 'var(--text-main)' }}>{user.username}</td>
                                            <td style={{ padding: '0.75rem', color: 'var(--text-secondary)' }}>{user.email}</td>
                                            <td style={{ padding: '0.75rem' }}>
                                                <span style={{
                                                    padding: '0.25rem 0.5rem',
                                                    borderRadius: '4px',
                                                    fontSize: '0.75rem',
                                                    background: user.active ? 'rgba(16, 185, 129, 0.1)' : 'rgba(239, 68, 68, 0.1)',
                                                    color: user.active ? 'var(--success)' : 'var(--error)'
                                                }}>
                                                    {user.active ? 'Active' : 'Inactive'}
                                                </span>
                                            </td>
                                            <td style={{ padding: '0.75rem', display: 'flex', gap: '8px', alignItems: 'center' }}>
                                                <button
                                                    onClick={() => handleResetPassword(user.id, user.username)}
                                                    className="btn btn-sm hover-lift"
                                                    style={{ border: 'none', background: '#3b82f6', color: 'white', padding: '0.4rem 0.8rem', borderRadius: '4px', cursor: 'pointer', fontWeight: '600', fontSize: '0.75rem' }}
                                                >
                                                    Reset PW
                                                </button>
                                                <button
                                                    onClick={() => handleToggleStatus(user.id)}
                                                    className="btn btn-sm hover-lift"
                                                    style={{
                                                        border: 'none',
                                                        background: user.active ? '#ef4444' : '#10b981',
                                                        color: 'white',
                                                        padding: '0.4rem 0.8rem',
                                                        borderRadius: '4px',
                                                        cursor: 'pointer',
                                                        fontWeight: '600',
                                                        fontSize: '0.75rem'
                                                    }}
                                                >
                                                    {user.active ? 'Deactivate' : 'Activate'}
                                                </button>
                                            </td>
                                        </tr>
                                    ))}
                                    {users.length === 0 && (
                                        <tr>
                                            <td colSpan="4" style={{ padding: '2rem', textAlign: 'center', color: 'var(--text-muted)' }}>
                                                No office users found.
                                            </td>
                                        </tr>
                                    )}
                                </tbody>
                            </table>
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
};

export default OfficeManagement;
