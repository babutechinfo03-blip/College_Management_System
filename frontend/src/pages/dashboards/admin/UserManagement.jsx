import React, { useState, useEffect } from 'react';
import axios from 'axios';

const UserManagement = () => {
    const [users, setUsers] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetchUsers();
    }, []);

    const fetchUsers = async () => {
        try {
            const res = await axios.get('/api/admin/users');
            setUsers(res.data);
        } catch (err) {
            console.error('Failed to fetch users', err);
        } finally {
            setLoading(false);
        }
    };

    const toggleStatus = async (userId, currentStatus) => {
        try {
            await axios.put(`/api/admin/users/${userId}/status?active=${!currentStatus}`);
            fetchUsers();
        } catch (err) {
            alert('Status update failed');
        }
    };

    if (loading) return <div>Loading User Directory...</div>;

    return (
        <div className="management-view">
            <div className="view-header">
                <h3>User Management</h3>
                <button className="btn btn-primary">Add New User</button>
            </div>

            <table className="admin-table">
                <thead>
                    <tr>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    {users.map(user => (
                        <tr key={user.id}>
                            <td>{user.username}</td>
                            <td>{user.email}</td>
                            <td><span className={`badge role-${user.role.toLowerCase()}`}>{user.role}</span></td>
                            <td>
                                <span className={`status-dot ${user.active ? 'active' : 'inactive'}`}></span>
                                {user.active ? 'Active' : 'Disabled'}
                            </td>
                            <td>
                                <button className="btn btn-sm" onClick={() => toggleStatus(user.id, user.active)}>
                                    {user.active ? 'Disable' : 'Enable'}
                                </button>
                                <button className="btn btn-sm btn-outline">Reset Pwd</button>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default UserManagement;
