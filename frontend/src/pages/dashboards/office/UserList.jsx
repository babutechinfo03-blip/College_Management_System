import React, { useState, useEffect } from 'react';
import axios from 'axios';

const UserList = () => {
    const [users, setUsers] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetchUsers();
    }, []);

    const fetchUsers = async () => {
        try {
            const res = await axios.get('/api/office/users');
            setUsers(res.data);
        } catch (err) {
            console.error('Failed to fetch users', err);
        } finally {
            setLoading(false);
        }
    };

    const toggleUserStatus = async (userId, currentStatus) => {
        try {
            await axios.put(`/api/office/users/${userId}/status?active=${!currentStatus}`);
            fetchUsers();
        } catch (err) {
            alert('Failed to update user status');
        }
    };

    if (loading) return <div>Loading Users...</div>;

    return (
        <div className="management-view">
            <div className="view-header">
                <h3>User Management</h3>
                <p className="text-secondary">Manage all system users</p>
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
                            <td><span className="badge">{user.role}</span></td>
                            <td>
                                <span className={`status-dot ${user.active ? 'active' : 'inactive'}`}></span>
                                {user.active ? 'Active' : 'Disabled'}
                            </td>
                            <td>
                                <button
                                    className={`btn btn-sm ${user.active ? 'btn-error' : 'btn-success'}`}
                                    onClick={() => toggleUserStatus(user.id, user.active)}
                                >
                                    {user.active ? 'Disable' : 'Enable'}
                                </button>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default UserList;
