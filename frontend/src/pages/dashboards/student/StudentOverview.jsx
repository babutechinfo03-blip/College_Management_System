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
        <div className="student-overview animate-fade-in">
            {profile && (
                <div className="glass-card" style={{ padding: '1.5rem', marginBottom: '2rem', display: 'flex', alignItems: 'center', gap: '2rem' }}>
                    <div style={{ position: 'relative' }}>
                        {profile.photoPath ? (
                            <img
                                src={`http://localhost:8080${profile.photoPath}`}
                                alt="Profile"
                                style={{ width: '100px', height: '100px', borderRadius: '50%', objectFit: 'cover', border: '3px solid var(--primary)' }}
                                onError={(e) => {
                                    e.target.onerror = null;
                                    e.target.style.display = 'none';
                                    e.target.nextSibling.style.display = 'flex';
                                }}
                            />
                        ) : null}
                        <div style={{
                            width: '100px',
                            height: '100px',
                            borderRadius: '50%',
                            background: 'var(--primary)',
                            color: 'white',
                            display: profile.photoPath ? 'none' : 'flex',
                            alignItems: 'center',
                            justifyContent: 'center',
                            fontSize: '2.5rem',
                            fontWeight: 'bold'
                        }}>
                            {profile.firstName?.[0]}{profile.lastName?.[0]}
                        </div>
                    </div>
                    <div>
                        <h2 style={{ fontSize: '1.5rem', fontWeight: '700', marginBottom: '0.5rem', color: 'var(--slate-900)' }}>
                            Welcome back, {profile.firstName} {profile.lastName}!
                        </h2>
                        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '0.5rem 2rem', fontSize: '0.9rem', color: 'var(--slate-600)' }}>
                            <p><strong>Student ID:</strong> {profile.studentId}</p>
                            <p><strong>Major:</strong> {profile.degree} - {profile.specialization}</p>
                            <p><strong>Enrollment:</strong> {profile.batch} Batch</p>
                            <p><strong>Current Status:</strong> Year {profile.currentYear}, Semester {profile.currentSemester}</p>
                        </div>
                    </div>
                </div>
            )}

            <div className="stats-grid">
                <div className="stat-card">
                    <div className="stat-header">
                        <span className="stat-title">Overall Attendance</span>
                        <span style={{ fontSize: '1.5rem' }}>📅</span>
                    </div>
                    <div className="stat-value" style={{ color: 'var(--success)' }}>{stats.attendance}</div>
                    <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)', marginTop: '0.5rem' }}>Fetched from real-time logs</div>
                </div>

                <div className="stat-card">
                    <div className="stat-header">
                        <span className="stat-title">Academic Score</span>
                        <span style={{ fontSize: '1.5rem' }}>🎯</span>
                    </div>
                    <div className="stat-value">{stats.avgMarks}</div>
                    <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)', marginTop: '0.5rem' }}>Avg. Internal Marks</div>
                </div>

                <div className="stat-card" style={{ borderLeft: '4px solid var(--secondary)' }}>
                    <div className="stat-header">
                        <span className="stat-title">Pending Tasks</span>
                        <span style={{ fontSize: '1.5rem' }}>📝</span>
                    </div>
                    <div className="stat-value" style={{ color: 'var(--secondary)' }}>{stats.pendingAssignments}</div>
                    <div style={{ fontSize: '0.8rem', color: 'var(--error)', marginTop: '0.5rem' }}>Check Course Portals</div>
                </div>

                <div className="stat-card">
                    <div className="stat-header">
                        <span className="stat-title">Goal Tracker</span>
                        <span style={{ fontSize: '1.5rem' }}>🏆</span>
                    </div>
                    <div className="stat-value">{stats.nextExam}</div>
                    <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)', marginTop: '0.5rem' }}>Next Assessment</div>
                </div>
            </div>

            <div className="grid" style={{ gridTemplateColumns: '1.5fr 1fr', marginTop: '2.5rem' }}>
                <div className="glass-card" style={{ padding: '2rem' }}>
                    <h3 style={{ fontSize: '1.25rem', marginBottom: '1.5rem', color: 'var(--slate-900)' }}>Academic Summary</h3>
                    <div style={{ padding: '2rem', background: 'var(--slate-50)', borderRadius: '12px', textAlign: 'center' }}>
                        <p style={{ color: 'var(--slate-500)' }}>Detailed course-wise analytics will appear here as faculty updates records.</p>
                    </div>
                </div>

                <div className="glass-card" style={{ padding: '2rem' }}>
                    <h3 style={{ fontSize: '1.25rem', marginBottom: '1.5rem', color: 'var(--slate-900)' }}>Notice Board</h3>
                    <div className="space-y-4">
                        <div style={{ padding: '1rem', background: '#f8fafc', borderRadius: '0.5rem' }}>
                            <p style={{ fontSize: '0.9rem', color: 'var(--slate-600)' }}>Welcome to your new Student Portal. All your academic records are now synchronized directly with the Office database.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default StudentOverview;
