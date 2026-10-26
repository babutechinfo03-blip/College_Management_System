import React, { useState, useEffect } from 'react';
import api from '../../../services/api';

const StudentAttendance = () => {
    const [attendance, setAttendance] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchAttendance = async () => {
            try {
                const response = await api.get('/students/attendance');
                setAttendance(response.data);
            } catch (error) {
                console.error('Error fetching attendance:', error);
            } finally {
                setLoading(false);
            }
        };
        fetchAttendance();
    }, []);

    if (loading) return <div className="loading-spinner">Loading Records...</div>;

    return (
        <div className="attendance-container animate-fade-in">
            <header style={{ marginBottom: '2.5rem' }}>
                <h3 style={{ fontSize: '1.5rem', fontWeight: '800' }}>Attendance Analytics</h3>
                <p style={{ color: 'var(--text-secondary)' }}>Detailed subject-wise tracking for the current semester.</p>
            </header>

            <div className="glass-card" style={{ padding: '0', overflow: 'hidden' }}>
                <table className="premium-table">
                    <thead>
                        <tr>
                            <th>Subject</th>
                            <th>Present</th>
                            <th>Total Sessions</th>
                            <th>Percentage</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        {attendance.map((record, index) => (
                            <tr key={index}>
                                <td style={{ fontWeight: '600' }}>{record.subjectName}</td>
                                <td>{record.present}</td>
                                <td>{record.total}</td>
                                <td style={{ fontWeight: '800', color: record.percentage >= 75 ? 'var(--success)' : 'var(--error)' }}>
                                    {record.percentage}%
                                </td>
                                <td>
                                    <span className={`perf-badge ${record.percentage >= 75 ? 'perf-high' : 'perf-risk'}`}>
                                        {record.percentage >= 75 ? 'Safe' : 'Shortage'}
                                    </span>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
                {attendance.length === 0 && (
                    <div style={{ padding: '4rem', textAlign: 'center', color: 'var(--text-muted)' }}>
                        No attendance records found yet.
                    </div>
                )}
            </div>
        </div>
    );
};

export default StudentAttendance;
