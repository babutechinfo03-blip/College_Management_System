import React, { useState, useEffect } from 'react';
import { useAuth } from '../../../context/AuthContext';
import api from '../../../services/api';
import FacultyDashboard from './FacultyDashboard';
import AdvisorDashboard from './AdvisorDashboard';
import HodDashboard from './HodDashboard';

const StaffOverview = () => {
    const { user } = useAuth();
    const [dashboardData, setDashboardData] = useState(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchDashboard = async () => {
            setLoading(true); // Ensure loading state is set on role change
            try {
                // Pass activeRole to the backend to get specific data
                const response = await api.get(`/staff/dashboard?activeRole=${user.activeRole}`);
                setDashboardData(response.data);
            } catch (error) {
                console.error('Failed to fetch dashboard data:', error);
            } finally {
                setLoading(false);
            }
        };
        fetchDashboard();
    }, [user.activeRole]); // Re-fetch when role switches

    if (loading) return <div>Synchronizing Dashboard...</div>;

    const renderSecondaryDashboard = () => {
        switch (user.activeRole) {
            case 'FACULTY': return <FacultyDashboard data={dashboardData} />;
            case 'CLASS_ADVISOR': return <AdvisorDashboard data={dashboardData} />;
            case 'HOD': return <HodDashboard data={dashboardData} />;
            default: return <FacultyDashboard data={dashboardData} />;
        }
    };

    return (
        <div className="animate-fade-in">
            {/* 1. Role-Specific Component */}
            <div style={{ marginBottom: '3rem' }}>
                {renderSecondaryDashboard()}
            </div>

            {/* 2. Common Real-Time Widgets */}
            <div className="grid" style={{ gridTemplateColumns: '1.5fr 1fr', gap: '2rem' }}>
                {/* Timetable Widget */}
                <div className="glass-card" style={{ padding: '2rem' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
                        <h3 style={{ fontSize: '1.25rem' }}>Today's Interactive Timetable</h3>
                        <span className="badge badge-primary">Real-time</span>
                    </div>
                    <div className="space-y-4">
                        {dashboardData?.timetable?.map((item, idx) => (
                            <div key={idx} style={{ padding: '1.25rem', background: '#f8fafc', borderRadius: '0.75rem', borderLeft: '4px solid var(--primary)', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                                <div>
                                    <p style={{ fontWeight: '800', fontSize: '0.95rem', color: 'var(--slate-900)' }}>{item.time}</p>
                                    <p style={{ color: 'var(--text-secondary)', fontSize: '0.85rem', marginTop: '0.25rem' }}>{item.subject} — <span style={{ fontWeight: '600' }}>{item.class}</span></p>
                                </div>
                                <button className="btn btn-secondary btn-xs">Joint Meet</button>
                            </div>
                        ))}
                    </div>
                </div>

                {/* Recent Activity Widget */}
                <div className="glass-card" style={{ padding: '2rem' }}>
                    <h3 style={{ fontSize: '1.25rem', marginBottom: '1.5rem' }}>Recent Academic Activity</h3>
                    <div className="activity-list">
                        {dashboardData?.recentActivity?.length > 0 ? (
                            dashboardData.recentActivity.map((activity, idx) => (
                                <div key={idx} style={{ display: 'flex', gap: '1rem', paddingBottom: '1.25rem', borderBottom: idx !== dashboardData.recentActivity.length - 1 ? '1px solid #f1f5f9' : 'none', marginBottom: idx !== dashboardData.recentActivity.length - 1 ? '1.25rem' : '0' }}>
                                    <div style={{ width: '40px', height: '40px', background: 'rgba(59, 130, 246, 0.1)', borderRadius: '50%', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                                        <span style={{ fontSize: '1.1rem' }}>⚡</span>
                                    </div>
                                    <div style={{ flex: 1 }}>
                                        <p style={{ fontSize: '0.9rem', fontWeight: '700', color: 'var(--slate-800)' }}>{activity.action}</p>
                                        <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)', marginTop: '0.15rem' }}>{activity.details}</p>
                                        <p style={{ fontSize: '0.65rem', color: 'var(--primary)', fontWeight: '600', textTransform: 'uppercase', marginTop: '0.25rem' }}>{activity.time}</p>
                                    </div>
                                </div>
                            ))
                        ) : (
                            <div style={{ textAlign: 'center', padding: '2rem', color: 'var(--text-muted)' }}>
                                <p style={{ fontSize: '0.9rem' }}>No recent activities found.</p>
                            </div>
                        )}
                    </div>
                </div>
            </div>

            {/* Notifications & Alerts Hook */}
            {dashboardData?.alerts?.length > 0 && (
                <div style={{ marginTop: '2rem' }}>
                    {dashboardData.alerts.map((alert, idx) => (
                        <div key={idx} style={{ padding: '1rem 1.5rem', background: alert.type === 'attendance' ? 'rgba(239, 68, 68, 0.05)' : 'rgba(245, 158, 11, 0.05)', border: `1px solid ${alert.type === 'attendance' ? 'rgba(239, 68, 68, 0.1)' : 'rgba(245, 158, 11, 0.1)'}`, borderRadius: '0.75rem', marginBottom: '1rem', display: 'flex', alignItems: 'center', gap: '1rem' }}>
                            <span style={{ fontSize: '1.25rem' }}>{alert.type === 'attendance' ? '🚩' : '💡'}</span>
                            <p style={{ fontSize: '0.9rem', color: alert.type === 'attendance' ? '#991b1b' : '#92400e', fontWeight: '600' }}>{alert.msg}</p>
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
};

export default StaffOverview;
