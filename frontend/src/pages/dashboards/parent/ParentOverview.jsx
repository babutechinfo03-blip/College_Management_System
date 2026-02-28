import React from 'react';

const ParentOverview = () => {
    return (
        <div className="parent-overview animate-fade-in">
            <div className="stats-grid">
                <div className="stat-card">
                    <div className="stat-header">
                        <span className="stat-title">Ward Attendance</span>
                        <span style={{ fontSize: '1.5rem' }}>🛡️</span>
                    </div>
                    <div className="stat-value" style={{ color: 'var(--success)' }}>92%</div>
                    <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)', marginTop: '0.5rem' }}>Satisfactory Attendance</div>
                </div>

                <div className="stat-card">
                    <div className="stat-header">
                        <span className="stat-title">Last Assessment</span>
                        <span style={{ fontSize: '1.5rem' }}>📊</span>
                    </div>
                    <div className="stat-value">84/100</div>
                    <div style={{ fontSize: '0.8rem', color: 'var(--success)', marginTop: '0.5rem' }}>First Class Distinction</div>
                </div>

                <div className="stat-card">
                    <div className="stat-header">
                        <span className="stat-title">Academic Standing</span>
                        <span style={{ fontSize: '1.5rem' }}>🏅</span>
                    </div>
                    <div className="stat-value">Rank 5</div>
                    <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)', marginTop: '0.5rem' }}>Top 10% of Class</div>
                </div>
            </div>

            <div className="glass-card" style={{ padding: '2.5rem', marginTop: '2.5rem' }}>
                <h3 style={{ fontSize: '1.25rem', marginBottom: '2rem' }}>Performance Analysis</h3>
                <div style={{ padding: '3rem', background: '#f8fafc', borderRadius: '1rem', textAlign: 'center', border: '2px dashed var(--border)' }}>
                    <p style={{ color: 'var(--text-muted)' }}>Interactive performance graphs will be available once the semester results are officially published.</p>
                </div>
            </div>
        </div>
    );
};

export default ParentOverview;
