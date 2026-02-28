import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { useSocket } from '../../../context/SocketContext';

const AdminOverview = () => {
    const [stats, setStats] = useState({
        totalStudents: 0,
        totalStaff: 0,
        attendanceToday: '0%',
        pendingComplaints: 0
    });
    const [auditLogs, setAuditLogs] = useState([]);
    const [loading, setLoading] = useState(true);
    const { stompClient, connected } = useSocket();

    useEffect(() => {
        const fetchData = async () => {
            try {
                const [statsRes, logsRes] = await Promise.all([
                    axios.get('/api/principal/stats'),
                    axios.get('/api/principal/audit-logs')
                ]);
                setStats(statsRes.data);
                setAuditLogs(logsRes.data);
            } catch (err) {
                console.error('Failed to fetch dashboard data', err);
            } finally {
                setLoading(false);
            }
        };
        fetchData();

        if (connected && stompClient) {
            const subscription = stompClient.subscribe('/topic/complaints', (message) => {
                const updatedStats = JSON.parse(message.body);
                setStats(prev => ({ ...prev, pendingComplaints: updatedStats.pendingCount }));
            });
            return () => subscription.unsubscribe();
        }
    }, [connected, stompClient]);

    const statCards = [
        { label: 'Total Students', value: stats.totalStudents, color: 'var(--primary)' },
        { label: 'Faculty Members', value: stats.totalStaff, color: 'var(--text-main)' },
        { label: 'Avg Attendance', value: stats.attendanceToday, color: 'var(--success)' },
        { label: 'Open Complaints', value: stats.pendingComplaints, color: stats.pendingComplaints > 0 ? 'var(--error)' : 'var(--text-muted)' }
    ];

    if (loading) return <div className="text-center p-xl">Loading analysis...</div>;

    return (
        <div className="animate-fade-in">
            <div className="stats-grid">
                {statCards.map((s, i) => (
                    <div key={i} className="stat-card">
                        <div className="stat-title">{s.label}</div>
                        <div className="stat-value" style={{ color: s.color }}>{s.value}</div>
                    </div>
                ))}
            </div>

            <div className="grid grid-cols-2 gap-lg" style={{ gridTemplateColumns: '1.5fr 1fr' }}>
                <div className="card">
                    <h3 style={{ marginBottom: '1.5rem', fontSize: '1.1rem' }}>System Audit Logs</h3>
                    <div style={{ overflowX: 'auto' }}>
                        <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.875rem' }}>
                            <thead>
                                <tr style={{ textAlign: 'left', borderBottom: '2px solid var(--border)' }}>
                                    <th style={{ padding: '0.75rem 0' }}>Timestamp</th>
                                    <th style={{ padding: '0.75rem 0' }}>Action</th>
                                    <th style={{ padding: '0.75rem 0' }}>User</th>
                                </tr>
                            </thead>
                            <tbody>
                                {auditLogs.map((log, i) => (
                                    <tr key={i} style={{ borderBottom: '1px solid var(--border)' }}>
                                        <td style={{ padding: '0.75rem 0', color: 'var(--text-secondary)' }}>
                                            {new Date(log.timestamp).toLocaleString()}
                                        </td>
                                        <td style={{ padding: '0.75rem 0', fontWeight: '500' }}>{log.action}</td>
                                        <td style={{ padding: '0.75rem 0' }}>{log.username}</td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                </div>

                <div className="card">
                    <h3 style={{ marginBottom: '1.5rem', fontSize: '1.1rem' }}>Department Performance</h3>
                    <div style={{ padding: '2rem', textAlign: 'center', background: 'var(--bg-main)', borderRadius: 'var(--radius)' }}>
                        <p style={{ color: 'var(--text-muted)', fontSize: '0.875rem' }}>No data trends available for the current semester yet.</p>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default AdminOverview;
