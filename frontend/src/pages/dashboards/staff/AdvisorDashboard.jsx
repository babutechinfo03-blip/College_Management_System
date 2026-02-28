import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';

const AdvisorDashboard = ({ data }) => {
    const navigate = useNavigate();
    const stats = data?.advisorSummary || {};
    const [pendingMarks, setPendingMarks] = useState([]);
    const [loading, setLoading] = useState(false);

    useEffect(() => {
        const fetchPending = async () => {
            setLoading(true);
            try {
                const res = await axios.get('/api/staff/marks/pending');
                setPendingMarks(res.data);
            } catch (err) {
                console.error(err);
            } finally {
                setLoading(false);
            }
        };
        fetchPending();
    }, []);

    const handleVerify = async (entryId) => {
        try {
            await axios.post('/api/staff/marks/verify', { entryId });
            setPendingMarks(prev => prev.filter(m => m.id !== entryId));
            alert("Marks Verified!");
        } catch (err) {
            alert("Verification Failed");
        }
    };

    if (!stats.assignedClass) {
        return (
            <div className="glass-card" style={{ padding: '2rem', textAlign: 'center' }}>
                <p>You are not assigned as a Class Advisor for any active class.</p>
            </div>
        );
    }

    return (
        <div className="animate-fade-in">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
                <h3 style={{ fontSize: '1.25rem' }}>Class Advisor Console - <span style={{ color: 'var(--primary)' }}>{stats.assignedClass}</span></h3>
                <button className="btn btn-outline" onClick={() => navigate('/staff/advisor/class')}>View Full Class</button>
            </div>

            <div className="grid" style={{ gridTemplateColumns: 'repeat(4, 1fr)', gap: '1.5rem', marginBottom: '2rem' }}>
                <div className="glass-card" style={{ padding: '1.5rem', textAlign: 'center' }}>
                    <div style={{ fontSize: '2rem', marginBottom: '0.5rem' }}>👨‍🎓</div>
                    <div style={{ fontSize: '1.5rem', fontWeight: '800' }}>{stats.totalStudents}</div>
                    <div style={{ fontSize: '0.75rem', color: 'var(--text-muted)', textTransform: 'uppercase' }}>Total Students</div>
                </div>

                <div className="glass-card" style={{ padding: '1.5rem', textAlign: 'center' }}>
                    <div style={{ fontSize: '2rem', marginBottom: '0.5rem' }}>📈</div>
                    <div style={{ fontSize: '1.5rem', fontWeight: '800', color: '#166534' }}>{stats.avgAttendance}</div>
                    <div style={{ fontSize: '0.75rem', color: 'var(--text-muted)', textTransform: 'uppercase' }}>Avg Attendance</div>
                </div>

                <div className="glass-card" style={{ padding: '1.5rem', textAlign: 'center' }}>
                    <div style={{ fontSize: '2rem', marginBottom: '0.5rem' }}>⚠️</div>
                    <div style={{ fontSize: '1.5rem', fontWeight: '800', color: '#dc2626' }}>{stats.defaultersCount}</div>
                    <div style={{ fontSize: '0.75rem', color: 'var(--text-muted)', textTransform: 'uppercase' }}>Defaulters</div>
                </div>

                <div className="glass-card" style={{ padding: '1.5rem', textAlign: 'center' }}>
                    <div style={{ fontSize: '2rem', marginBottom: '0.5rem' }}>📝</div>
                    <div style={{ fontSize: '1.5rem', fontWeight: '800', color: '#eab308' }}>{pendingMarks.length}</div>
                    <div style={{ fontSize: '0.75rem', color: 'var(--text-muted)', textTransform: 'uppercase' }}>Pending Approvals</div>
                </div>
            </div>

            {/* Pending Verifications */}
            <h3 style={{ fontSize: '1.25rem', marginBottom: '1rem' }}>Pending Mark Verifications</h3>
            {pendingMarks.length > 0 ? (
                <div className="glass-card" style={{ padding: '0', overflow: 'hidden' }}>
                    <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead style={{ background: '#f8fafc' }}>
                            <tr>
                                <th style={{ padding: '1rem', textAlign: 'left' }}>Student</th>
                                <th style={{ padding: '1rem', textAlign: 'left' }}>Subject</th>
                                <th style={{ padding: '1rem', textAlign: 'right' }}>Marks</th>
                                <th style={{ padding: '1rem', textAlign: 'center' }}>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            {pendingMarks.map(m => (
                                <tr key={m.id} style={{ borderBottom: '1px solid #e2e8f0' }}>
                                    <td style={{ padding: '1rem' }}>{m.studentName}</td>
                                    <td style={{ padding: '1rem' }}>{m.subjectCode}</td>
                                    <td style={{ padding: '1rem', textAlign: 'right' }}>{m.marks} / {m.maxMarks}</td>
                                    <td style={{ padding: '1rem', textAlign: 'center' }}>
                                        <button className="btn btn-sm btn-primary" onClick={() => handleVerify(m.id)}>Verify</button>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            ) : (
                <div className="glass-card" style={{ padding: '2rem', textAlign: 'center', color: 'var(--text-muted)' }}>
                    No marks pending for verification.
                </div>
            )}
        </div>
    );
};

export default AdvisorDashboard;
