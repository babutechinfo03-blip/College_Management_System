import React, { useState, useEffect } from 'react';
import axios from 'axios';

const StaffManagement = () => {
    const [staff, setStaff] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchStaff = async () => {
            try {
                const res = await axios.get('/api/admin/staff');
                setStaff(res.data);
            } catch (err) {
                console.error('Failed to fetch staff', err);
            } finally {
                setLoading(false);
            }
        };
        fetchStaff();
    }, []);

    if (loading) return <div>Loading Staff Directory...</div>;

    return (
        <div className="management-view">
            <div className="view-header">
                <h3>Staff Directory</h3>
                <div className="search-bar">
                    <input type="text" placeholder="Search staff by name or ID..." className="form-control" />
                </div>
            </div>

            <table className="admin-table">
                <thead>
                    <tr>
                        <th>Staff ID</th>
                        <th>Name</th>
                        <th>Department</th>
                        <th>Designation</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    {staff.map(member => (
                        <tr key={member.id}>
                            <td>{member.staffId}</td>
                            <td>{`${member.firstName} ${member.lastName || ''}`}</td>
                            <td>{member.department?.name}</td>
                            <td><span className="badge">{member.designation}</span></td>
                            <td>
                                <button className="btn btn-sm btn-outline">View Activity</button>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default StaffManagement;
