import React, { useState, useEffect } from 'react';
import axios from 'axios';

const PrincipalOverview = () => {
    const [stats, setStats] = useState({
        totalStudents: 0,
        totalFaculty: 0,
        totalOfficeStaff: 0,
        avgAttendance: 0
    });
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchStats = async () => {
            try {
                const response = await axios.get('/api/principal/dashboard-stats');
                setStats(response.data);
            } catch (error) {
                console.error('Error fetching dashboard stats:', error);
            } finally {
                setLoading(false);
            }
        };

        fetchStats();
        // Poll every 30 seconds for updates
        const interval = setInterval(fetchStats, 30000);
        return () => clearInterval(interval);
    }, []);

    const statCards = [
        { label: 'Total Students', value: stats.totalStudents, icon: '🎓', color: 'var(--primary)' },
        { label: 'Total Faculty', value: stats.totalFaculty, icon: '👨‍🏫', color: 'var(--secondary)' },
        { label: 'Office Staff', value: stats.totalOfficeStaff, icon: '🏢', color: 'var(--accent)' },
        { label: 'Avg Attendance', value: `${stats.avgAttendance}%`, icon: '📊', color: 'var(--success)' },
    ];

    if (loading) return <div className="p-4">Loading stats...</div>;

    return (
        <div className="animate-fade-in">
            <h2 className="text-2xl font-bold mb-6" style={{ color: 'var(--text-main)' }}>College Overview</h2>

            <div className="grid grid-cols-4 gap-6 mb-8" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))', gap: '1.5rem' }}>
                {statCards.map((stat, index) => (
                    <div key={index} className="card p-6 flex flex-col items-center justify-center text-center hover-lift" style={{ background: 'var(--bg-card)', border: '1px solid var(--border)', borderRadius: 'var(--radius)', padding: '1.5rem' }}>
                        <div className="text-4xl mb-2" style={{ fontSize: '2.5rem' }}>{stat.icon}</div>
                        <div className="text-3xl font-bold mb-1" style={{ color: stat.color, fontSize: '2rem' }}>{stat.value}</div>
                        <div className="text-sm font-medium" style={{ color: 'var(--text-secondary)' }}>{stat.label}</div>
                    </div>
                ))}
            </div>

            <div className="grid grid-cols-2 gap-6" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(400px, 1fr))', gap: '1.5rem' }}>
                <div className="card p-6" style={{ background: 'var(--bg-card)', border: '1px solid var(--border)', borderRadius: 'var(--radius)', padding: '1.5rem' }}>
                    <h3 className="text-lg font-bold mb-4" style={{ color: 'var(--text-main)' }}>Recent Alerts</h3>
                    <div className="text-sm" style={{ color: 'var(--text-muted)' }}>
                        No urgent alerts at this time.
                    </div>
                </div>
                <div className="card p-6" style={{ background: 'var(--bg-card)', border: '1px solid var(--border)', borderRadius: 'var(--radius)', padding: '1.5rem' }}>
                    <h3 className="text-lg font-bold mb-4" style={{ color: 'var(--text-main)' }}>Pending Approvals</h3>
                    <div className="text-sm" style={{ color: 'var(--text-muted)' }}>
                        All requests sourced.
                    </div>
                </div>
            </div>
        </div>
    );
};

export default PrincipalOverview;
