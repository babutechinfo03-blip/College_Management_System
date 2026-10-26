import React from 'react';
import { Routes, Route, Link, useLocation } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';
import StaffOverview from './staff/StaffOverview.jsx';
import AttendanceMarking from './staff/AttendanceMarking.jsx';
import AssignmentManager from './staff/AssignmentManager.jsx';
import MarkEntry from './staff/MarkEntry.jsx';
import AdvisorDashboard from './staff/AdvisorDashboard.jsx';
import HodDashboard from './staff/HodDashboard.jsx';

import SubjectManager from './staff/hod/SubjectManager.jsx';
import TimetableScheduler from './staff/hod/TimetableScheduler.jsx';
import StudentList from './staff/hod/StudentList.jsx';
import MarkApproval from './staff/hod/MarkApproval.jsx';
import ClassAdvisorManager from './staff/hod/ClassAdvisorManager.jsx';

import CircularManager from './circular/CircularManager.jsx';



const StaffDashboard = () => {
    // ... existing hook ...
    const { user, logout, switchRole } = useAuth();
    const location = useLocation();

    const isActive = (path) => location.pathname === path ? 'active' : '';

    const handleRoleChange = (e) => {
        switchRole(e.target.value);
    };

    const isAdminOrHod = user?.staffRoles?.includes('HOD'); // Unused but kept
    const isAdvisor = user?.staffRoles?.includes('CLASS_ADVISOR'); // Unused but kept

    return (
        <div className="dashboard-layout">
            <aside className="sidebar" style={{ background: '#0f172a' }}>
                <div style={{ marginBottom: '2rem' }}>
                    <h1 className="logo" style={{ color: 'white', fontSize: '1.75rem', fontWeight: '800' }}>
                        Staff<span style={{ color: 'var(--primary)' }}>Hub</span>
                    </h1>
                    <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)', textTransform: 'uppercase', letterSpacing: '1px', marginTop: '0.5rem', fontWeight: '700' }}>
                        {user?.staffRoles?.includes('HOD') ? 'Department Console' : 'Academic Console'}
                    </p>
                </div>

                <nav style={{ flex: 1 }}>
                    {/* Common Link */}
                    <Link to="/staff" className={`sidebar-item ${isActive('/staff')}`}>
                        <span style={{ fontSize: '1.25rem' }}>📅</span> Overview
                    </Link>

                    {/* Faculty Specific (Available to all staff as they are all faculty) */}
                    {(user?.staffRoles?.includes('FACULTY') || user?.staffRoles?.includes('HOD')) && (
                        <>
                            <div style={{ marginTop: '1.5rem', marginBottom: '0.5rem', fontSize: '0.65rem', color: '#64748b', textTransform: 'uppercase', letterSpacing: '1px', fontWeight: '800', paddingLeft: '1rem' }}>My Classes</div>
                            <Link to="/staff/attendance" className={`sidebar-item ${isActive('/staff/attendance')}`}>
                                <span style={{ fontSize: '1.25rem' }}>✅</span> Attendance
                            </Link>
                            <Link to="/staff/assignments" className={`sidebar-item ${isActive('/staff/assignments')}`}>
                                <span style={{ fontSize: '1.25rem' }}>📚</span> Assignments
                            </Link>
                            <Link to="/staff/marks" className={`sidebar-item ${isActive('/staff/marks')}`}>
                                <span style={{ fontSize: '1.25rem' }}>🎯</span> Internal Marks
                            </Link>
                            <Link to="/staff/circulars" className={`sidebar-item ${isActive('/staff/circulars')}`}>
                                <span style={{ fontSize: '1.25rem' }}>📢</span> Circulars
                            </Link>
                        </>
                    )}

                    {/* Class Advisor Specific */}
                    {user?.staffRoles?.includes('CLASS_ADVISOR') && (
                        <>
                            <div style={{ marginTop: '1.5rem', marginBottom: '0.5rem', fontSize: '0.65rem', color: '#64748b', textTransform: 'uppercase', letterSpacing: '1px', fontWeight: '800', paddingLeft: '1rem' }}>Advisory</div>
                            <Link to="/staff/advisor/class" className={`sidebar-item ${isActive('/staff/advisor/class')}`}>
                                <span style={{ fontSize: '1.25rem' }}>👨‍🎓</span> My Class
                            </Link>
                            <Link to="/staff/advisor/reports" className={`sidebar-item ${isActive('/staff/advisor/reports')}`}>
                                <span style={{ fontSize: '1.25rem' }}>📊</span> Reports
                            </Link>
                        </>
                    )}

                    {/* HOD Specific */}
                    {user?.staffRoles?.includes('HOD') && (
                        <>
                            <div style={{ marginTop: '1.5rem', marginBottom: '0.5rem', fontSize: '0.65rem', color: '#64748b', textTransform: 'uppercase', letterSpacing: '1px', fontWeight: '800', paddingLeft: '1rem' }}>Department</div>
                            <Link to="/staff/hod/department" className={`sidebar-item ${isActive('/staff/hod/department')}`}>
                                <span style={{ fontSize: '1.25rem' }}>🏢</span> Dept Analytics
                            </Link>
                            <Link to="/staff/hod/subjects" className={`sidebar-item ${isActive('/staff/hod/subjects')}`}>
                                <span style={{ fontSize: '1.25rem' }}>📘</span> Allocations
                            </Link>
                            <Link to="/staff/hod/timetable" className={`sidebar-item ${isActive('/staff/hod/timetable')}`}>
                                <span style={{ fontSize: '1.25rem' }}>📅</span> Timetable
                            </Link>
                            <Link to="/staff/hod/advisors" className={`sidebar-item ${isActive('/staff/hod/advisors')}`}>
                                <span style={{ fontSize: '1.25rem' }}>🎓</span> Class Advisors
                            </Link>
                            <Link to="/staff/hod/faculty" className={`sidebar-item ${isActive('/staff/hod/faculty')}`}>
                                <span style={{ fontSize: '1.25rem' }}>👥</span> Workload
                            </Link>
                        </>
                    )}
                </nav>

                <div style={{ marginTop: 'auto', borderTop: '1px solid rgba(255,255,255,0.1)', paddingTop: '2rem' }}>
                    <div style={{ marginBottom: '1.5rem' }}>
                        <p style={{ fontSize: '0.875rem', color: 'white', fontWeight: '600' }}>{user?.username}</p>
                        <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                            {user?.staffRoles?.join(' • ').replace(/_/g, ' ')}
                        </p>
                    </div>
                    <button className="btn btn-secondary btn-block" style={{ background: 'rgba(255,255,255,0.05)', color: 'white', border: 'none', justifyContent: 'center' }} onClick={logout}>
                        Sign Out
                    </button>
                </div>
            </aside>

            <main className="main-content">
                <header style={{ marginBottom: '2.5rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <div className="animate-fade-in">
                        <h2 style={{ fontSize: '1.75rem', color: 'var(--slate-900)' }}>
                            {user?.staffRoles?.includes('HOD') ? 'Department Console' :
                                user?.staffRoles?.includes('CLASS_ADVISOR') ? 'Advisor Console' :
                                    'Academic Console'}
                        </h2>
                        <p style={{ color: 'var(--text-secondary)', fontWeight: '500' }}>
                            {user?.staffRoles?.includes('HOD') ? 'Manage department-wide academic operations and your own classes.' :
                                user?.staffRoles?.includes('CLASS_ADVISOR') ? 'Monitor student performance and approve leaves.' :
                                    'Manage your classes and evaluate student performance.'}
                        </p>
                    </div>
                </header>

                <div className="dashboard-main animate-fade-in">
                    <Routes>
                        <Route index element={<StaffOverview />} />
                        <Route path="attendance" element={<AttendanceMarking />} />
                        <Route path="assignments" element={<AssignmentManager />} />
                        <Route path="marks" element={<MarkEntry />} />
                        <Route path="advisor/*" element={<AdvisorDashboard />} />

                        {/* HOD Routes */}
                        <Route path="hod/department" element={<HodDashboard data={{ hodAnalytics: { departmentName: 'Loading...' } }} />} />
                        <Route path="hod/subjects" element={<SubjectManager />} />
                        <Route path="hod/timetable" element={<TimetableScheduler />} />
                        <Route path="hod/advisors" element={<ClassAdvisorManager />} />
                        <Route path="hod/students" element={<StudentList />} />
                        <Route path="hod/marks" element={<MarkApproval />} />
                        <Route path="hod/*" element={<HodDashboard />} />

                        {/* Common Staff Routes */}
                        <Route path="circulars" element={<CircularManager />} />

                        <Route path="*" element={<StaffOverview />} />
                    </Routes>
                </div>
            </main>
        </div>
    );
};

export default StaffDashboard;
