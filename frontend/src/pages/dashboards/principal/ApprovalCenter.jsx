import React, { useState, useEffect } from 'react';
import api from '../../../services/api';

const ApprovalCenter = () => {
    const [pending, setPending] = useState({ timetables: [], circulars: [] });
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');
    const [successMessage, setSuccessMessage] = useState('');

    const fetchApprovals = async () => {
        try {
            setLoading(true);
            const response = await api.get('/principal/approvals/pending');
            setPending({
                timetables: response.data.timetables || [],
                circulars: response.data.circulars || []
            });
        } catch (err) {
            setError(err.response?.data?.error || 'Failed to load pending approvals');
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchApprovals();
    }, []);

    const handleAction = async (type, id, approve, remarks = '') => {
        try {
            const endpoint = type === 'timetable' ? `/principal/approvals/timetables/${id}` : `/principal/approvals/circulars/${id}`;
            await api.post(`${endpoint}?approve=${approve}&remarks=${remarks}`);
            setSuccessMessage(`${type.charAt(0).toUpperCase() + type.slice(1)} ${approve ? 'Approved' : 'Rejected'} Successfully`);
            fetchApprovals();
            setTimeout(() => setSuccessMessage(''), 3000);
        } catch (err) {
            setError(err.response?.data?.error || 'Action failed');
            setTimeout(() => setError(''), 3000);
        }
    };

    if (loading) return <div className="p-4 text-center">Loading Executive Inbox...</div>;

    return (
        <div className="animate-fade-in dashboard-content">
            <div className="flex justify-between items-center mb-6">
                <div>
                    <h2 className="text-2xl font-bold" style={{ color: 'var(--text-main)' }}>Approval Center</h2>
                    <p style={{ color: 'var(--text-muted)' }}>Centralized inbox for cross-college approvals</p>
                </div>
                <div className="flex gap-4">
                    <div className="counter-badge" style={{ background: 'rgba(239, 68, 68, 0.1)', color: '#ef4444', padding: '0.5rem 1rem', borderRadius: '1rem', fontWeight: 'bold' }}>
                        {pending.timetables.length} Pending Timetables
                    </div>
                    <div className="counter-badge" style={{ background: 'rgba(59, 130, 246, 0.1)', color: '#3b82f6', padding: '0.5rem 1rem', borderRadius: '1rem', fontWeight: 'bold' }}>
                        {pending.circulars.length} Pending Circulars
                    </div>
                </div>
            </div>

            {error && <div className="alert alert-error mb-4" style={{ background: '#fef2f2', color: '#b91c1c', padding: '1rem', borderRadius: '0.5rem' }}>{error}</div>}
            {successMessage && <div className="alert alert-success mb-4" style={{ background: '#f0fdf4', color: '#15803d', padding: '1rem', borderRadius: '0.5rem' }}>{successMessage}</div>}

            <div className="grid gap-6">
                {/* TIMETABLES SECTION */}
                <div className="card" style={{ background: 'var(--bg-card)', border: '1px solid var(--border)', borderRadius: 'var(--radius)' }}>
                    <div className="card-header" style={{ padding: '1.5rem', borderBottom: '1px solid var(--border)', display: 'flex', justifyContent: 'space-between' }}>
                        <h3 className="font-bold text-lg" style={{ color: 'var(--text-main)' }}>Department Timetables</h3>
                    </div>
                    <div className="card-body p-0">
                        {pending.timetables.length === 0 ? (
                            <div className="p-6 text-center" style={{ color: 'var(--text-muted)' }}>No pending timetables for approval.</div>
                        ) : (
                            <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                                <thead style={{ background: 'rgba(0,0,0,0.02)' }}>
                                    <tr>
                                        <th style={{ padding: '1rem', textAlign: 'left', color: 'var(--text-secondary)' }}>Department</th>
                                        <th style={{ padding: '1rem', textAlign: 'left', color: 'var(--text-secondary)' }}>Term</th>
                                        <th style={{ padding: '1rem', textAlign: 'left', color: 'var(--text-secondary)' }}>Submitted</th>
                                        <th style={{ padding: '1rem', textAlign: 'center', color: 'var(--text-secondary)' }}>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {pending.timetables.map(t => (
                                        <tr key={t.id} style={{ borderBottom: '1px solid var(--border)' }}>
                                            <td style={{ padding: '1rem', fontWeight: '500', color: 'var(--text-main)' }}>{t.department}</td>
                                            <td style={{ padding: '1rem', color: 'var(--text-main)' }}>{t.academicYear} - Sem {t.semester}</td>
                                            <td style={{ padding: '1rem', color: 'var(--text-muted)' }}>{new Date(t.submittedAt).toLocaleDateString()}</td>
                                            <td style={{ padding: '1rem', textAlign: 'center' }}>
                                                <button onClick={() => handleAction('timetable', t.id, true)} className="btn btn-sm" style={{ background: '#10b981', color: 'white', border: 'none', padding: '0.3rem 0.8rem', borderRadius: '0.3rem', marginRight: '0.5rem' }}>Approve & Lock</button>
                                                <button onClick={() => handleAction('timetable', t.id, false, 'Needs Revision')} className="btn btn-sm" style={{ background: '#ef4444', color: 'white', border: 'none', padding: '0.3rem 0.8rem', borderRadius: '0.3rem' }}>Reject</button>
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        )}
                    </div>
                </div>

                {/* CIRCULARS SECTION */}
                <div className="card" style={{ background: 'var(--bg-card)', border: '1px solid var(--border)', borderRadius: 'var(--radius)' }}>
                    <div className="card-header" style={{ padding: '1.5rem', borderBottom: '1px solid var(--border)' }}>
                        <h3 className="font-bold text-lg" style={{ color: 'var(--text-main)' }}>Circular Overrides</h3>
                    </div>
                    <div className="card-body p-0">
                        {pending.circulars.length === 0 ? (
                            <div className="p-6 text-center" style={{ color: 'var(--text-muted)' }}>No pending circulars for authorization.</div>
                        ) : (
                            <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                                <thead style={{ background: 'rgba(0,0,0,0.02)' }}>
                                    <tr>
                                        <th style={{ padding: '1rem', textAlign: 'left', color: 'var(--text-secondary)' }}>Subject</th>
                                        <th style={{ padding: '1rem', textAlign: 'left', color: 'var(--text-secondary)' }}>Type/Priority</th>
                                        <th style={{ padding: '1rem', textAlign: 'center', color: 'var(--text-secondary)' }}>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {pending.circulars.map(c => (
                                        <tr key={c.id} style={{ borderBottom: '1px solid var(--border)' }}>
                                            <td style={{ padding: '1rem' }}>
                                                <div style={{ fontWeight: '500', color: 'var(--text-main)' }}>{c.title}</div>
                                                <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)', marginTop: '0.2rem' }}>{c.description.substring(0, 50)}...</div>
                                            </td>
                                            <td style={{ padding: '1rem' }}>
                                                <span className="badge" style={{ background: 'var(--bg-secondary)', padding: '0.2rem 0.5rem', borderRadius: '0.25rem', fontSize: '0.75rem', marginRight: '0.5rem' }}>{c.type}</span>
                                                {c.priority === 'HIGH' && <span className="badge" style={{ background: '#fee2e2', color: '#ef4444', padding: '0.2rem 0.5rem', borderRadius: '0.25rem', fontSize: '0.75rem' }}>HIGH PRIORITY</span>}
                                            </td>
                                            <td style={{ padding: '1rem', textAlign: 'center' }}>
                                                <button onClick={() => handleAction('circular', c.id, true)} className="btn btn-sm" style={{ background: '#10b981', color: 'white', border: 'none', padding: '0.3rem 0.8rem', borderRadius: '0.3rem', marginRight: '0.5rem' }}>Authorize</button>
                                                <button onClick={() => handleAction('circular', c.id, false, 'Denied by Principal')} className="btn btn-sm" style={{ background: '#ef4444', color: 'white', border: 'none', padding: '0.3rem 0.8rem', borderRadius: '0.3rem' }}>Deny</button>
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        )}
                    </div>
                </div>
            </div>
        </div>
    );
};

export default ApprovalCenter;
