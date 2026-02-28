import React from 'react';
import { useNavigate, Link } from 'react-router-dom';

const StudentSelection = () => {
    const navigate = useNavigate();

    return (
        <div style={{ padding: '6rem 1rem', minHeight: '100vh', background: 'var(--slate-50)' }}>
            <div className="container" style={{ maxWidth: '800px' }}>
                <Link to="/" style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', color: 'var(--text-muted)', textDecoration: 'none', marginBottom: '3rem', fontWeight: '600' }}>
                    <span>←</span> Return to home
                </Link>

                <div style={{ marginBottom: '4rem' }}>
                    <h2 style={{ fontSize: '3rem', marginBottom: '1rem', color: 'var(--slate-900)' }}>Student & <span style={{ color: 'var(--primary)' }}>Parent Portal</span></h2>
                    <p style={{ color: 'var(--text-secondary)', fontSize: '1.1rem' }}>Your dedicated gateway for academic transparency and growth.</p>
                </div>

                <div className="grid grid-cols-2 gap-lg" style={{ gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))' }}>
                    <div className="card animate-fade-in" style={{ padding: '3.5rem 2.5rem', textAlign: 'center', borderTop: '4px solid var(--primary)' }}>
                        <div style={{ fontSize: '3.5rem', marginBottom: '2rem' }}>🎓</div>
                        <h3 style={{ fontSize: '1.75rem', marginBottom: '1rem' }}>Student Login</h3>
                        <p style={{ fontSize: '1rem', color: 'var(--text-secondary)', marginBottom: '2.5rem', lineHeight: '1.6' }}>
                            Access your personalized dashboard, view attendance, complete assignments, and track exam results.
                        </p>
                        <button className="btn btn-primary btn-block" onClick={() => navigate('/student/student-login')}>Launch Student Hub</button>
                    </div>

                    <div className="card animate-fade-in" style={{ padding: '3.5rem 2.5rem', textAlign: 'center', borderTop: '4px solid #be185d', animationDelay: '0.1s' }}>
                        <div style={{ fontSize: '3.5rem', marginBottom: '2rem' }}>👨‍👩‍👧‍👦</div>
                        <h3 style={{ fontSize: '1.75rem', marginBottom: '1rem' }}>Parent Login</h3>
                        <p style={{ fontSize: '1rem', color: 'var(--text-secondary)', marginBottom: '2.5rem', lineHeight: '1.6' }}>
                            Monitor your ward's academic progression, attendance history, and institutional communications.
                        </p>
                        <button className="btn btn-secondary btn-block" style={{ color: '#be185d', borderColor: '#be185d' }} onClick={() => navigate('/parent/parent-login')}>Access Parent Gateway</button>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default StudentSelection;
