import React, { useState, useEffect } from 'react';
import api from '../../../services/api';

const StudentCirculars = () => {
    const [circulars, setCirculars] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchCirculars = async () => {
            try {
                const response = await api.get('/students/circulars');
                setCirculars(response.data);
            } catch (error) {
                console.error('Error fetching circulars:', error);
            } finally {
                setLoading(false);
            }
        };
        fetchCirculars();
    }, []);

    const markAsRead = async (id) => {
        try {
            await api.post(`/students/circulars/${id}/read`);
            setCirculars(prev => prev.map(c => c.id === id ? { ...c, isRead: true } : c));
        } catch (error) {
            console.error('Error marking as read:', error);
        }
    };

    if (loading) return <div className="loading-spinner">Syncing Notice Board...</div>;

    return (
        <div className="circulars-container animate-fade-in">
            <header style={{ marginBottom: '2.5rem' }}>
                <h3 style={{ fontSize: '1.5rem', fontWeight: '800' }}>Official Communication</h3>
                <p style={{ color: 'var(--text-secondary)' }}>Direct notices from Principal, Office and Department.</p>
            </header>

            <div className="space-y-4" style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                {circulars.map((circle) => (
                    <div
                        key={circle.id}
                        className={`card ${circle.isRead ? '' : 'unread-border'}`}
                        style={{
                            padding: '1.5rem',
                            borderLeft: circle.status === 'URGENT' ? '5px solid var(--error)' : '5px solid var(--accent)',
                            position: 'relative',
                            background: circle.isRead ? 'var(--card-bg)' : 'rgba(59, 130, 246, 0.02)'
                        }}
                    >
                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.75rem' }}>
                            <div style={{ display: 'flex', gap: '0.5rem', alignItems: 'center' }}>
                                <span className={`badge ${circle.status === 'URGENT' ? 'badge-error' : 'badge-info'}`}>
                                    {circle.status || 'NOTICE'}
                                </span>
                                <span style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                                    {new Date(circle.createdAt).toLocaleDateString()}
                                </span>
                            </div>
                            {!circle.isRead && <span className="badge badge-warning">NEW</span>}
                        </div>
                        <h4 style={{ marginBottom: '0.5rem' }}>{circle.title}</h4>
                        <p style={{ fontSize: '0.9rem', color: 'var(--text-secondary)', lineHeight: '1.5' }}>
                            {circle.content}
                        </p>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: '1rem' }}>
                            <div style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                                issued by: <strong>{circle.createdRole}</strong>
                            </div>
                            {!circle.isRead && (
                                <button className="btn btn-secondary" style={{ padding: '0.4rem 1rem', fontSize: '0.75rem' }} onClick={() => markAsRead(circle.id)}>
                                    Mark as Seen
                                </button>
                            )}
                        </div>
                    </div>
                ))}
                {circulars.length === 0 && (
                    <div style={{ padding: '4rem', textAlign: 'center', background: 'var(--card-bg)', borderRadius: 'var(--radius)', border: '1px solid var(--border)' }}>
                        <p style={{ color: 'var(--text-muted)' }}>Notice board is empty.</p>
                    </div>
                )}
            </div>
        </div>
    );
};

export default StudentCirculars;
