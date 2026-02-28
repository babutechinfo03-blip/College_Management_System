import React from 'react';
import { useNavigate, Link } from 'react-router-dom';

const InstitutionSelection = () => {
    const navigate = useNavigate();

    const roles = [
        { id: 'principal-login', title: 'Principal', icon: '⚖️', desc: 'Strategic oversight, institutional analytics, and financial monitoring.', color: 'var(--primary)' },
        { id: 'office-login', title: 'Office', icon: '🏢', desc: 'Administrative operations, student records, and staff management.', color: 'var(--primary-dark)' },
        { id: 'staff-login', title: 'Staff', icon: '👨‍🏫', desc: 'Academic performance tracking, assignments, and attendance.', color: 'var(--primary-dark)' },
        { id: 'assistant-login', title: 'Assistant', icon: '🤝', desc: 'Non-academic operations and daily support services.', color: 'var(--text-secondary)' }
    ];

    return (
        <div style={{ padding: '6rem 1rem', minHeight: '100vh', background: 'var(--bg-main)', transition: 'var(--transition)' }}>
            <div className="container" style={{ maxWidth: '1000px' }}>
                <Link to="/" style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', color: 'var(--text-main)', textDecoration: 'none', marginBottom: '3rem', fontWeight: '700' }}>
                    <span>←</span> Return to home
                </Link>

                <div style={{ marginBottom: '4rem' }}>
                    <h2 style={{ fontSize: '3rem', marginBottom: '1rem', color: 'var(--text-main)' }}>Elite Institution <span style={{ color: 'var(--primary)' }}>Portal</span></h2>
                    <p style={{ color: 'var(--text-secondary)', fontSize: '1.1rem', maxWidth: '600px' }}>Select your authorized workspace to continue. Each portal is secured with end-to-end encryption.</p>
                </div>

                <div className="grid grid-cols-2 gap-lg" style={{ gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))' }}>
                    {roles.map((role, index) => (
                        <div key={role.id} className="card animate-fade-in" style={{
                            padding: '3rem 2rem',
                            textAlign: 'center',
                            animationDelay: `${index * 0.1}s`,
                            display: 'flex',
                            flexDirection: 'column'
                        }}>
                            <div style={{ fontSize: '3rem', marginBottom: '1.5rem', filter: 'drop-shadow(0 10px 10px rgba(0,0,0,0.1))' }}>{role.icon}</div>
                            <h3 style={{ fontSize: '1.5rem', marginBottom: '0.75rem', color: 'var(--text-main)' }}>{role.title}</h3>
                            <p style={{ fontSize: '0.95rem', color: 'var(--text-secondary)', marginBottom: '2.5rem', flex: 1, lineHeight: '1.7' }}>{role.desc}</p>
                            <button className="btn btn-primary btn-block" style={{ background: role.color, border: 'none', padding: '1rem' }} onClick={() => navigate(`/institution/${role.id}`)}>
                                Enter Workspace
                            </button>
                        </div>
                    ))}
                </div>
            </div>
        </div>
    );
};

export default InstitutionSelection;
