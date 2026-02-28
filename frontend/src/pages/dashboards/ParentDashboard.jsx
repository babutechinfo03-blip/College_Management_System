import React from 'react';
import { Routes, Route, Link, useLocation } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';
import ParentOverview from './parent/ParentOverview.jsx';

const ParentDashboard = () => {
    const { user, logout } = useAuth();
    const location = useLocation();

    const isActive = (path) => location.pathname === path ? 'active' : '';

    return (
        <div className="dashboard-layout">
            <aside className="sidebar" style={{ background: '#831843' }}>
                <div style={{ marginBottom: '3rem' }}>
                    <h1 className="logo" style={{ color: 'white', fontSize: '1.75rem', fontWeight: '800' }}>
                        Guardian<span style={{ color: '#fbcfe8' }}>Hub</span>
                    </h1>
                    <p style={{ fontSize: '0.75rem', color: '#fbcfe8', textTransform: 'uppercase', letterSpacing: '1px', marginTop: '0.5rem', fontWeight: '700' }}>
                        Performance Gateway
                    </p>
                </div>

                <nav style={{ flex: 1 }}>
                    <Link to="/parent" className={`sidebar-item ${isActive('/parent')}`}>
                        <span style={{ fontSize: '1.25rem' }}>👀</span> Overview
                    </Link>
                    <Link to="/parent/performance" className={`sidebar-item ${isActive('/parent/performance')}`}>
                        <span style={{ fontSize: '1.25rem' }}>📈</span> Performance
                    </Link>
                </nav>

                <div style={{ marginTop: 'auto', borderTop: '1px solid rgba(255,255,255,0.1)', paddingTop: '2rem' }}>
                    <div style={{ marginBottom: '1.5rem' }}>
                        <p style={{ fontSize: '0.875rem', color: 'white', fontWeight: '600' }}>{user?.username}</p>
                        <p style={{ fontSize: '0.75rem', color: '#fbcfe8' }}>Registered Guardian</p>
                    </div>
                    <button className="btn btn-secondary btn-block" style={{ background: 'rgba(255,255,255,0.05)', color: 'white', border: 'none', justifyContent: 'center' }} onClick={logout}>
                        Log Out
                    </button>
                </div>
            </aside>

            <main className="main-content">
                <header style={{ marginBottom: '3rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <div className="animate-fade-in">
                        <h2 style={{ fontSize: '2rem', color: 'var(--slate-900)' }}>Guardian Workspace</h2>
                        <p style={{ color: 'var(--text-secondary)', fontWeight: '500' }}>Monitor your ward academic performance and milestones.</p>
                    </div>
                </header>

                <div className="dashboard-main animate-fade-in">
                    <Routes>
                        <Route index element={<ParentOverview />} />
                        <Route path="performance" element={<ParentOverview />} />
                        <Route path="*" element={<ParentOverview />} />
                    </Routes>
                </div>
            </main>
        </div>
    );
};

export default ParentDashboard;
