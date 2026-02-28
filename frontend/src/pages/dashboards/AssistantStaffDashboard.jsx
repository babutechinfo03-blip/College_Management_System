import React from 'react';
import { Routes, Route, Link, useLocation } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';
import AssistantAttendanceDashboard from './assistant/AssistantAttendanceDashboard';
import MarkAttendanceForm from './assistant/MarkAttendanceForm';
import AttendanceHistory from './assistant/AttendanceHistory';

const AssistantStaffDashboard = () => {
    const { user, logout } = useAuth();
    const location = useLocation();

    const isActive = (path) => location.pathname.startsWith(path) ? 'active' : '';

    return (
        <div className="dashboard-layout animate-fade-in">
            <aside className="sidebar">
                <div style={{ marginBottom: '3rem' }}>
                    <h1 className="logo" style={{ fontSize: '1.5rem' }}>Elite Support</h1>
                    <div style={{ fontSize: '0.75rem', color: 'var(--text-muted)', fontWeight: '600', textTransform: 'uppercase', letterSpacing: '1px', marginTop: '0.5rem' }}>
                        Operations Console
                    </div>
                </div>

                <nav style={{ flex: 1 }}>
                    <Link to="/assistant/attendance" className={`sidebar-item ${isActive('/assistant/attendance')}`}>
                        <span>📋</span> Attendance Register
                    </Link>
                </nav>

                <div style={{ marginTop: 'auto', paddingTop: '2rem', borderTop: '1px solid var(--border)' }}>
                    <div style={{ marginBottom: '1rem' }}>
                        <p style={{ fontWeight: '700', fontSize: '0.9rem' }}>{user?.username}</p>
                        <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>Assistant Staff</p>
                    </div>
                    <button className="btn btn-secondary" style={{ width: '100%', justifyContent: 'center', background: '#fef2f2', color: 'var(--error)', border: 'none' }} onClick={logout}>
                        Sign Out
                    </button>
                </div>
            </aside>

            <main className="main-content">
                <header style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
                    <div>
                        <h2 style={{ fontSize: '1.75rem' }}>Operational Workspace</h2>
                        <p style={{ color: 'var(--text-muted)' }}>Daily attendance tracking and support operations.</p>
                    </div>
                </header>

                <div className="dashboard-main">
                    <Routes>
                        <Route index element={<AssistantAttendanceDashboard />} />
                        <Route path="attendance" element={<AssistantAttendanceDashboard />} />
                        <Route path="attendance/mark" element={<MarkAttendanceForm />} />
                        <Route path="attendance/history" element={<AttendanceHistory />} />
                        <Route path="*" element={<AssistantAttendanceDashboard />} />
                    </Routes>
                </div>
            </main>
        </div>
    );
};

export default AssistantStaffDashboard;
