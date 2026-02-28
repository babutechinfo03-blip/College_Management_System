import React from 'react';
import { Routes, Route, Link, useLocation } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';
import ThemeToggle from '../../components/ThemeToggle';
import PrincipalOverview from './principal/PrincipalOverview.jsx';
import OfficeManagement from './principal/OfficeManagement.jsx';
import AcademicMonitoring from './principal/AcademicMonitoring.jsx';
import DepartmentView from './principal/DepartmentView.jsx';

const PrincipalDashboard = () => {
  const { user, logout } = useAuth();
  const location = useLocation();

  const isActive = (path) => location.pathname === path ? 'active' : '';

  return (
    <div className="dashboard-layout">
      <aside className="sidebar" style={{ background: '#0f172a' }}>
        <div style={{ marginBottom: '3rem' }}>
          <h1 className="logo" style={{ color: 'white', fontSize: '1.75rem', fontWeight: '800' }}>
            Elite<span style={{ color: 'var(--primary)' }}>Admin</span>
          </h1>
          <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)', textTransform: 'uppercase', letterSpacing: '1px', marginTop: '0.5rem', fontWeight: '700' }}>
            Executive Control
          </p>
        </div>

        <nav style={{ flex: 1 }}>
          <Link to="/principal" className={`sidebar-item ${isActive('/principal')}`}>
            <span style={{ fontSize: '1.25rem' }}>📊</span> Overview
          </Link>
          <Link to="/principal/office" className={`sidebar-item ${isActive('/principal/office')}`}>
            <span style={{ fontSize: '1.25rem' }}>🏢</span> Office Mgmt
          </Link>
          <Link to="/principal/academics" className={`sidebar-item ${isActive('/principal/academics')}`}>
            <span style={{ fontSize: '1.25rem' }}>🎓</span> Academics
          </Link>
          <Link to="/principal/departments" className={`sidebar-item ${isActive('/principal/departments')}`}>
            <span style={{ fontSize: '1.25rem' }}>🏛️</span> Departments
          </Link>
        </nav>

        <div style={{ marginTop: 'auto', borderTop: '1px solid rgba(255,255,255,0.1)', paddingTop: '2rem' }}>
          <div style={{ marginBottom: '1.5rem' }}>
            <p style={{ fontSize: '0.875rem', color: 'white', fontWeight: '600' }}>{user?.username}</p>
            <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>Administrative Head</p>
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
              {location.pathname === '/principal' && 'Governance Console'}
              {location.pathname === '/principal/office' && 'Office Management'}
              {location.pathname === '/principal/academics' && 'Academic Control'}
            </h2>
            <p style={{ color: 'var(--text-secondary)', fontWeight: '500' }}>
              {location.pathname === '/principal' && 'Monitoring institutional performance and vital operations.'}
              {location.pathname === '/principal/office' && 'Manage office staff access and operations.'}
              {location.pathname === '/principal/academics' && 'Monitor academic progress and freeze controls.'}
              {location.pathname === '/principal/departments' && 'Oversee departments and assign HODs.'}
            </p>
          </div>
          <ThemeToggle />
        </header>

        <div className="dashboard-view animate-fade-in">
          <Routes>
            <Route index element={<PrincipalOverview />} />
            <Route path="office" element={<OfficeManagement />} />
            <Route path="academics" element={<AcademicMonitoring />} />
            <Route path="departments" element={<DepartmentView />} />
            <Route path="*" element={<PrincipalOverview />} />
          </Routes>
        </div>
      </main>
    </div>
  );
};

export default PrincipalDashboard;
