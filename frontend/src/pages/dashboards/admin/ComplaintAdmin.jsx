import React, { useState, useEffect } from 'react';
import axios from 'axios';

const ComplaintAdmin = () => {
    const [complaints, setComplaints] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetchComplaints();
    }, []);

    const fetchComplaints = async () => {
        try {
            const res = await axios.get('/api/complaints/all'); // Need to ensure backend has this or principal can view all
            setComplaints(res.data);
        } catch (err) {
            console.error('Failed to fetch complaints', err);
        } finally {
            setLoading(false);
        }
    };

    const updateStatus = async (id, status) => {
        try {
            await axios.put(`/api/complaints/${id}/status?status=${status}`);
            fetchComplaints();
        } catch (err) {
            alert('Failed to update status');
        }
    };

    if (loading) return <div>Loading Complaints...</div>;

    return (
        <div className="management-view">
            <div className="view-header">
                <h3>System-wide Complaints</h3>
                <div className="filters">
                    <select className="form-control">
                        <option>All Departments</option>
                        <option>Status: Pending</option>
                    </select>
                </div>
            </div>

            <div className="complaints-grid mt-md">
                {complaints.length === 0 ? <p>No complaints found.</p> : complaints.map(complaint => (
                    <div key={complaint.id} className="card complaint-card">
                        <div className="d-flex justify-between">
                            <strong>{complaint.title || 'Inquiry'}</strong>
                            <span className={`badge status-${complaint.status?.toLowerCase()}`}>{complaint.status}</span>
                        </div>
                        <p className="description mt-xs">{complaint.description}</p>
                        <div className="footer mt-sm d-flex justify-between align-center">
                            <span className="text-secondary text-xs">By: {complaint.student?.firstName} | {complaint.department?.name}</span>
                            <div className="actions">
                                <button className="btn btn-sm" onClick={() => updateStatus(complaint.id, 'IN_REVIEW')}>Review</button>
                                <button className="btn btn-sm btn-success" onClick={() => updateStatus(complaint.id, 'RESOLVED')}>Resolve</button>
                            </div>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
};

export default ComplaintAdmin;
