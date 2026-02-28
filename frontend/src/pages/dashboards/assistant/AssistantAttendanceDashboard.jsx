import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import api from '../../../services/api';

const AssistantAttendanceDashboard = () => {
    const [stats, setStats] = useState({ submittedToday: 0, totalAssigned: 'Loading...' });
    const [recentActivity, setRecentActivity] = useState([]);
    const [loading, setLoading] = useState(true);
    const navigate = useNavigate();

    const fetchDashboardData = async () => {
        try {
            const [statsRes, historyRes] = await Promise.all([
                api.get('/attendance/stats'),
                api.get('/attendance/history') // Reusing history for recent activity
            ]);
            setStats(statsRes.data);
            setRecentActivity(historyRes.data.slice(0, 10)); // Last 10
        } catch (err) {
            console.error('Failed to fetch dashboard data', err);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchDashboardData();
        // Setup a small interval for "real-time" feel if user stays on page
        const interval = setInterval(fetchDashboardData, 30000); // 30s
        return () => clearInterval(interval);
    }, []);

    const today = new Date().toLocaleDateString('en-IN', {
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    });

    return (
        <div className="animate-fade-in">
            <div className="glass-card" style={{ padding: '2rem', marginBottom: '2rem', background: 'linear-gradient(135deg, #6366f1 0%, #4f46e5 100%)', color: 'white' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <div>
                        <h2 style={{ fontSize: '1.5rem', marginBottom: '0.5rem' }}>Attendance Overview</h2>
                        <p style={{ opacity: 0.9 }}>{today}</p>
                    </div>
                    <div style={{ textAlign: 'right' }}>
                        <div style={{ fontSize: '2.5rem', fontWeight: '800' }}>{stats.submittedToday}</div>
                        <p style={{ fontSize: '0.875rem', opacity: 0.9 }}>Entries Submitted Today</p>
                    </div>
                </div>
            </div>

            <div className="grid" style={{ gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))', gap: '1.5rem', marginBottom: '3rem' }}>
                <div className="glass-card" style={{ padding: '1.5rem', display: 'flex', flexDirection: 'column', gap: '1rem', background: '#f8fafc' }}>
                    <div style={{ fontSize: '2rem' }}>🕒</div>
                    <div>
                        <h4 style={{ fontSize: '1.125rem', marginBottom: '0.25rem' }}>Daily Status</h4>
                        <div style={{ display: 'flex', justifyContent: 'space-between', marginTop: '0.5rem' }}>
                            <span style={{ fontSize: '0.8rem', color: 'var(--text-muted)' }}>Classes Submitted:</span>
                            <span style={{ fontWeight: '700' }}>{stats.submittedToday}</span>
                        </div>
                        <div style={{ display: 'flex', justifyContent: 'space-between' }}>
                            <span style={{ fontSize: '0.8rem', color: 'var(--text-muted)' }}>Students Marked:</span>
                            <span style={{ fontWeight: '700' }}>{stats.studentsMarkedToday || 0}</span>
                        </div>
                        <div style={{ display: 'flex', justifyContent: 'space-between' }}>
                            <span style={{ fontSize: '0.8rem', color: 'var(--text-muted)' }}>Pending Classes:</span>
                            <span style={{ fontWeight: '700', color: '#eab308' }}>{stats.pendingClasses}</span>
                        </div>
                    </div>
                </div>

                <div className="glass-card" style={{ padding: '1.5rem', display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                    <div style={{ fontSize: '2rem' }}>➕</div>
                    <div>
                        <h4 style={{ fontSize: '1.125rem', marginBottom: '0.25rem' }}>Mark Attendance</h4>
                        <p style={{ color: 'var(--text-muted)', fontSize: '0.875rem' }}>Record daily attendance.</p>
                    </div>
                    <button className="btn btn-primary" style={{ marginTop: 'auto' }} onClick={() => navigate('/assistant/attendance/mark')}>
                        Start Marking
                    </button>
                </div>

                <div className="glass-card" style={{ padding: '1.5rem', display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                    <div style={{ fontSize: '2rem' }}>📊</div>
                    <div>
                        <h4 style={{ fontSize: '1.125rem', marginBottom: '0.25rem' }}>View History</h4>
                        <p style={{ color: 'var(--text-muted)', fontSize: '0.875rem' }}>Review submitted records.</p>
                    </div>
                    <button className="btn btn-secondary" style={{ marginTop: 'auto' }} onClick={() => navigate('/assistant/attendance/history')}>
                        View History
                    </button>
                </div>
            </div>

            {/* --- Recent Activity Section --- */}
            <h3 style={{ fontSize: '1.25rem', marginBottom: '1.5rem' }}>Recent Activity</h3>
            <div className="glass-card" style={{ padding: '0', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                    <thead style={{ background: '#f8fafc', borderBottom: '1px solid var(--border)' }}>
                        <tr>
                            <th style={{ padding: '1rem', textAlign: 'left' }}>Session Info</th>
                            <th style={{ padding: '1rem', textAlign: 'center' }}>Hour</th>
                            <th style={{ padding: '1rem', textAlign: 'center' }}>Counts</th>
                            <th style={{ padding: '1rem', textAlign: 'left' }}>Submission Time</th>
                        </tr>
                    </thead>
                    <tbody>
                        {recentActivity.length > 0 ? (
                            recentActivity.map(item => (
                                <tr
                                    key={item.id}
                                    style={{ borderBottom: '1px solid var(--border)', cursor: 'pointer' }}
                                    className="hover-row"
                                    onClick={() => navigate('/assistant/attendance/history')}
                                >
                                    <td style={{ padding: '1rem' }}>
                                        <div style={{ fontWeight: '700', fontSize: '0.85rem' }}>{item.date}</div>
                                        <div style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                                            {item.programType} | {item.degree} | {item.specialization?.code}
                                        </div>
                                    </td>
                                    <td style={{ padding: '1rem', textAlign: 'center' }}>
                                        <div style={{ width: '24px', height: '24px', borderRadius: '50%', background: 'var(--primary)', color: 'white', display: 'flex', alignItems: 'center', justifyContent: 'center', margin: '0 auto', fontSize: '0.75rem', fontWeight: '700' }}>
                                            {item.hour}
                                        </div>
                                    </td>
                                    <td style={{ padding: '1rem', textAlign: 'center' }}>
                                        <div style={{ fontSize: '0.75rem', fontWeight: '600' }}>
                                            <span style={{ color: '#166534' }}>{item.presentCount} P</span> / <span style={{ color: '#991b1b' }}>{item.absentCount} A</span>
                                        </div>
                                    </td>
                                    <td style={{ padding: '1rem', fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                                        {new Date(item.submittedAt).toLocaleString('en-IN', { hour: '2-digit', minute: '2-digit', day: '2-digit', month: 'short' })}
                                    </td>
                                </tr>
                            ))
                        ) : (
                            <tr>
                                <td colSpan="4" style={{ padding: '2rem', textAlign: 'center', color: 'var(--text-muted)' }}>
                                    No recent activity found.
                                </td>
                            </tr>
                        )}
                    </tbody>
                </table>
            </div>

            <style dangerouslySetInnerHTML={{
                __html: `
                .hover-row:hover { background: #f1f5f9; }
            `}} />
        </div>
    );
};

export default AssistantAttendanceDashboard;
