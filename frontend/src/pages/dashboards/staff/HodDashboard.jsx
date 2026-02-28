import React from 'react';
import { useNavigate } from 'react-router-dom';

const HodDashboard = ({ data }) => {
    const navigate = useNavigate();
    const stats = data?.hodAnalytics || {};

    if (!stats.departmentName) {
        return (
            <div className="glass-card" style={{ padding: '2rem', textAlign: 'center' }}>
                <p>Department analytics not available.</p>
            </div>
        );
    }

    return (
        <div className="animate-fade-in">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
                <h3 style={{ fontSize: '1.25rem' }}>Department Analytics - <span style={{ color: 'var(--primary)' }}>{stats.departmentName}</span></h3>
                <button className="btn btn-outline" onClick={() => navigate('/staff/hod/department')}>View Dept Details</button>
            </div>

            <div className="grid" style={{ gridTemplateColumns: 'repeat(4, 1fr)', gap: '1.5rem' }}>
                <div className="glass-card" style={{ padding: '1.5rem', textAlign: 'center' }}>
                    <div style={{ fontSize: '2rem', marginBottom: '0.5rem' }}>👥</div>
                    <div style={{ fontSize: '1.5rem', fontWeight: '800' }}>{stats.totalFaculty}</div>
                    <div style={{ fontSize: '0.75rem', color: 'var(--text-muted)', textTransform: 'uppercase' }}>Total Faculty</div>
                </div>

                <div className="glass-card" style={{ padding: '1.5rem', textAlign: 'center' }}>
                    <div style={{ fontSize: '2rem', marginBottom: '0.5rem' }}>🎓</div>
                    <div style={{ fontSize: '1.5rem', fontWeight: '800', color: '#166534' }}>{stats.totalStudents}</div>
                    <div style={{ fontSize: '0.75rem', color: 'var(--text-muted)', textTransform: 'uppercase' }}>Total Students</div>
                </div>

                <div className="glass-card" style={{ padding: '1.5rem', textAlign: 'center' }}>
                    <div style={{ fontSize: '2rem', marginBottom: '0.5rem' }}>🛠️</div>
                    <div style={{ fontSize: '1.5rem', fontWeight: '800', color: '#2563eb' }}>{stats.totalAssistantStaff}</div>
                    <div style={{ fontSize: '0.75rem', color: 'var(--text-muted)', textTransform: 'uppercase' }}>Assistant Staff</div>
                </div>

                <div className="glass-card" style={{ padding: '1.5rem', textAlign: 'center' }}>
                    <div style={{ fontSize: '2rem', marginBottom: '0.5rem' }}>📅</div>
                    <div style={{ fontSize: '1.5rem', fontWeight: '800', color: '#eab308' }}>{stats.todayClasses}</div>
                    <div style={{ fontSize: '0.75rem', color: 'var(--text-muted)', textTransform: 'uppercase' }}>Today's Classes</div>
                </div>
            </div>

            <div className="grid" style={{ gridTemplateColumns: '1fr 1fr', gap: '1.5rem', marginTop: '1.5rem' }}>
                <div className="glass-card" style={{ padding: '1.5rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <div>
                        <h4 style={{ fontSize: '1.1rem' }}>Marks Status</h4>
                        <div style={{ display: 'flex', gap: '1.5rem', marginTop: '0.5rem' }}>
                            <div>
                                <span style={{ fontSize: '1.25rem', fontWeight: '700', color: '#d97706' }}>{stats.marksPending}</span>
                                <span style={{ fontSize: '0.75rem', marginLeft: '0.5rem', color: 'var(--text-muted)' }}>Pending</span>
                            </div>
                            <div>
                                <span style={{ fontSize: '1.25rem', fontWeight: '700', color: '#166534' }}>{stats.marksApproved}</span>
                                <span style={{ fontSize: '0.75rem', marginLeft: '0.5rem', color: 'var(--text-muted)' }}>Approved</span>
                            </div>
                        </div>
                    </div>
                    <button className="btn btn-sm btn-outline" onClick={() => navigate('/staff/hod/marks')}>Manage Marks</button>
                </div>

                <div className="glass-card" style={{ padding: '1.5rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <div>
                        <h4 style={{ fontSize: '1.1rem' }}>Student Management</h4>
                        <p style={{ fontSize: '0.85rem', color: 'var(--text-muted)' }}>View all students in department</p>
                    </div>
                    <button className="btn btn-sm btn-primary" onClick={() => navigate('/staff/hod/students')}>View Students</button>
                </div>
            </div>
        </div>
    );
};

export default HodDashboard;
