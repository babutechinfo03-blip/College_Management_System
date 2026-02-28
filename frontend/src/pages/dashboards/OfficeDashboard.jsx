import React from 'react';
import { Routes, Route, Link, useLocation } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';
import { OfficeProvider } from '../../context/OfficeContext.jsx';
import ThemeToggle from '../../components/ThemeToggle';
import DashboardOverview from './office/DashboardOverview.jsx';
import AddStudent from './office/AddStudent.jsx';
import AddStaff from './office/AddStaff.jsx';
import AddAssistantStaff from './office/AddAssistantStaff.jsx';
import ManageRecords from './office/ManageRecords.jsx';

const OfficeDashboardContent = () => {
    const { user, logout } = useAuth();
    const location = useLocation();

    const isActive = (path) => location.pathname === path ? 'active' : '';

    return (
        <div className="dashboard-layout">
            <aside className="sidebar" style={{ background: '#1e293b' }}>
                <div style={{ marginBottom: '3rem' }}>
                    <h1 className="logo" style={{ color: 'white', fontSize: '1.75rem', fontWeight: '800' }}>
                        Elite<span style={{ color: 'var(--primary)' }}>Office</span>
                    </h1>
                    <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)', textTransform: 'uppercase', letterSpacing: '1px', marginTop: '0.5rem', fontWeight: '700' }}>
                        Administration Hub
                    </p>
                </div>

                <nav style={{ flex: 1 }}>
                    <Link to="/office" className={`sidebar-item ${isActive('/office')}`}>
                        <span style={{ fontSize: '1.25rem' }}>📊</span> Dashboard
                    </Link>
                    <Link to="/office/add-student" className={`sidebar-item ${isActive('/office/add-student')}`}>
                        <span style={{ fontSize: '1.25rem' }}>➕</span> Add Student
                    </Link>
                    <Link to="/office/add-staff" className={`sidebar-item ${isActive('/office/add-staff')}`}>
                        <span style={{ fontSize: '1.25rem' }}>➕</span> Add Faculty
                    </Link>
                    <Link to="/office/add-assistant-staff" className={`sidebar-item ${isActive('/office/add-assistant-staff')}`}>
                        <span style={{ fontSize: '1.25rem' }}>➕</span> Add Assistant Staff
                    </Link>
                    <Link to="/office/manage-records" className={`sidebar-item ${isActive('/office/manage-records')}`}>
                        <span style={{ fontSize: '1.25rem' }}>📋</span> Manage Records
                    </Link>
                </nav>

                <div style={{ marginTop: 'auto', borderTop: '1px solid rgba(255,255,255,0.1)', paddingTop: '2rem' }}>
                    <div style={{ marginBottom: '1.5rem' }}>
                        <p style={{ fontSize: '0.875rem', color: 'white', fontWeight: '600' }}>{user?.username}</p>
                        <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>Office Administrator</p>
                    </div>
                    <button className="btn btn-secondary btn-block" style={{ background: 'rgba(255,255,255,0.05)', color: 'white', border: 'none', justifyContent: 'center' }} onClick={logout}>
                        Sign Out
                    </button>
                </div>
            </aside>

            <main className="main-content">
                <header style={{ marginBottom: '3rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <div className="animate-fade-in">
                        <h2 style={{ fontSize: '2rem', color: 'var(--text-main)' }}>
                            {location.pathname === '/office' && 'Dashboard Overview'}
                            {location.pathname === '/office/add-student' && 'Add Student'}
                            {location.pathname === '/office/add-staff' && 'Add Faculty'}
                            {location.pathname === '/office/add-assistant-staff' && 'Add Assistant Staff'}
                            {location.pathname === '/office/manage-records' && 'Manage Records'}
                        </h2>
                        <p style={{ color: 'var(--text-secondary)', fontWeight: '500' }}>
                            {location.pathname === '/office' && 'Institutional record maintenance and user provisioning.'}
                            {location.pathname === '/office/add-student' && 'Register new student with complete academic details.'}
                            {location.pathname === '/office/add-staff' && 'Create faculty account with role assignments.'}
                            {location.pathname === '/office/add-assistant-staff' && 'Register lab/office assistants.'}
                            {location.pathname === '/office/manage-records' && 'View, edit, and manage all student and faculty records.'}
                        </p>
                    </div>
                    <ThemeToggle />
                </header>

                <div className="dashboard-main animate-fade-in">
                    <Routes>
                        <Route index element={<DashboardOverview />} />
                        <Route path="add-student" element={<AddStudent />} />
                        <Route path="add-staff" element={<AddStaff />} />
                        <Route path="add-assistant-staff" element={<AddAssistantStaff />} />
                        <Route path="manage-records" element={<ManageRecords />} />
                        <Route path="*" element={<DashboardOverview />} />
                    </Routes>
                </div>
            </main>
        </div>
    );
};

const OfficeDashboard = () => (
    <OfficeProvider>
        <OfficeDashboardContent />
    </OfficeProvider>
);

export default OfficeDashboard;
