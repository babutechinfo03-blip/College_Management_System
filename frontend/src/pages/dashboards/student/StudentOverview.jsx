import React, { useState, useEffect } from 'react';
import api from '../../../services/api';
import { useAuth } from '../../../context/AuthContext';

const StudentOverview = () => {
    const { user } = useAuth();
    const [profile, setProfile] = useState(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetchProfile();
    }, []);

    const fetchProfile = async () => {
        try {
            console.log('[DEBUG] Fetching fresh student profile and dynamic stats from database...');
            const response = await api.get('/students/profile');
            console.log('[DEBUG] Student profile received:', response.data);
            setProfile(response.data);
        } catch (error) {
            console.error('[ERROR] Failed to fetch student profile:', error);
        } finally {
            setLoading(false);
        }
    };

    if (loading) {
        return (
            <div style={{
                height: '80vh',
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                justifyContent: 'center',
                gap: '1rem',
                color: 'var(--slate-600)'
            }}>
                <div className="spinner"></div>
                <p>Fetching your latest academic data...</p>
            </div>
        );
    }

    const stats = profile?.stats || {
        attendance: '0%',
        avgMarks: '0.0',
        pendingAssignments: '0',
        nextExam: 'Upcoming'
    };

    return (
        <div className="student-overview animate-fade-in" style={{ paddingBottom: '4rem' }}>
            <header style={{ marginBottom: '2.5rem' }}>
                <h2 style={{ fontSize: '1.75rem', fontWeight: '800', color: 'var(--primary)' }}>
                    Academic Workspace
                </h2>
                <p style={{ color: 'var(--text-secondary)' }}>Welcome back, {profile?.firstName}. Here is your current academic standing.</p>
            </header>

            <div className="grid" style={{ gridTemplateColumns: 'minmax(300px, 400px) 1fr', gap: '3rem', alignItems: 'start' }}>
                {/* Digital ID Section */}
                <div className="digital-id-card">
                    <div className="id-header">
                        <div>
                            <div className="id-chip"></div>
                            <h4 style={{ margin: 0, fontSize: '1rem', letterSpacing: '1px' }}>STUDENT ID</h4>
                            <p style={{ fontSize: '0.7rem', opacity: 0.8 }}>OFFICIAL ACADEMIC CARD</p>
                        </div>
                        <img
                            src={profile?.photoPath ? `http://localhost:8080${profile.photoPath}` : `https://ui-avatars.com/api/?name=${profile?.firstName}+${profile?.lastName}&background=3b82f6&color=fff`}
                            className="id-photo"
                            alt="Student"
                        />
                    </div>

                    <div>
                        <div style={{ fontSize: '1.25rem', fontWeight: '700', textTransform: 'uppercase' }}>
                            {profile?.firstName} {profile?.lastName}
                        </div>
                        <div style={{ fontSize: '0.85rem', opacity: 0.9, marginTop: '0.25rem' }}>
                            {profile?.degree} | {profile?.specialization}
                        </div>
                    </div>

                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end' }}>
                        <div>
                            <div style={{ fontSize: '0.65rem', opacity: 0.7, textTransform: 'uppercase' }}>Register Number</div>
                            <div style={{ fontSize: '1rem', fontWeight: '600', letterSpacing: '1px' }}>{profile?.studentId}</div>
                        </div>
                        <div className="id-barcode"></div>
                    </div>
                </div>

                {/* Quick Stats Dashboard */}
                <div className="stats-grid" style={{ margin: 0 }}>
                    <div className="stat-card" style={{ borderTop: '4px solid var(--success)' }}>
                        <div className="stat-header">
                            <span className="stat-title">Attendance</span>
                            <span style={{ fontSize: '1.25rem' }}>📈</span>
                        </div>
                        <div className="stat-value" style={{ color: 'var(--success)' }}>{stats.attendance}</div>
                        <div className="progress-track" style={{ marginTop: '1rem' }}>
                            <div className="progress-fill" style={{
                                width: stats.attendance,
                                background: parseInt(stats.attendance) < 75 ? 'var(--error)' : 'var(--success)'
                            }}></div>
                        </div>
                        {parseInt(stats.attendance) < 75 && (
                            <p style={{ fontSize: '0.75rem', color: 'var(--error)', marginTop: '0.5rem', fontWeight: '600' }}>⚠️ Below required 75%</p>
                        )}
                    </div>

                    <div className="stat-card" style={{ borderTop: '4px solid var(--primary)' }}>
                        <div className="stat-header">
                            <span className="stat-title">Avg. Internal</span>
                            <span style={{ fontSize: '1.25rem' }}>🎯</span>
                        </div>
                        <div className="stat-value">{stats.avgMarks}</div>
                        <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)', marginTop: '0.5rem' }}>Out of 100.00</p>
                    </div>

                    <div className="stat-card" style={{ borderTop: '4px solid var(--warning)' }}>
                        <div className="stat-header">
                            <span className="stat-title">Pending Tasks</span>
                            <span style={{ fontSize: '1.25rem' }}>📝</span>
                        </div>
                        <div className="stat-value" style={{ color: 'var(--warning)' }}>{stats.pendingAssignments}</div>
                        <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)', marginTop: '0.5rem' }}>Actions Required</p>
                    </div>
                </div>
            </div>

            <div className="grid" style={{ gridTemplateColumns: '1.5fr 1fr', gap: '2rem', marginTop: '3rem' }}>
                {/* Secondary modules would go here */}
            </div>
        </div>
    );
};

export default StudentOverview;
