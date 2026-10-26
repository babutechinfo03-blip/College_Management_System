import React from 'react';
import { Routes, Route, Link, useLocation } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';
import ThemeToggle from '../../components/ThemeToggle';
import StudentOverview from './student/StudentOverview.jsx';
import StudentAttendance from './student/StudentAttendance.jsx';
import StudentAssignments from './student/StudentAssignments.jsx';
import StudentResults from './student/StudentResults.jsx';
import StudentTimetable from './student/StudentTimetable.jsx';
import StudentCourses from './student/StudentCourses.jsx';
import StudentMarks from './student/StudentMarks.jsx';
import StudentCirculars from './student/StudentCirculars.jsx';

const StudentDashboard = () => {
    const { user, logout } = useAuth();
    const location = useLocation();

    const isActive = (path) => location.pathname === path ? 'active' : '';

    return (
        <div className="dashboard-layout">
            <aside className="sidebar">
                <div style={{ marginBottom: '3rem' }}>
                    <h1 className="logo" style={{ color: 'white', fontSize: '1.75rem', fontWeight: '800' }}>
                        Student<span style={{ color: '#93c5fd' }}>Portal</span>
                    </h1>
                    <p style={{ fontSize: '0.75rem', color: '#bfdbfe', textTransform: 'uppercase', letterSpacing: '1px', marginTop: '0.5rem', fontWeight: '700' }}>
                        Academic Records
                    </p>
                </div>

                <nav style={{ flex: 1 }}>
                    <Link to="/student/overview" className={`sidebar-item ${isActive('/student/overview')}`}>
                        <span style={{ fontSize: '1.25rem' }}>🏠</span> Overview
                    </Link>
                    <Link to="/student/timetable" className={`sidebar-item ${isActive('/student/timetable')}`}>
                        <span style={{ fontSize: '1.25rem' }}>📅</span> Time Table
                    </Link>
                    <Link to="/student/attendance" className={`sidebar-item ${isActive('/student/attendance')}`}>
                        <span style={{ fontSize: '1.25rem' }}>📊</span> Attendance
                    </Link>
                    <Link to="/student/courses" className={`sidebar-item ${isActive('/student/courses')}`}>
                        <span style={{ fontSize: '1.25rem' }}>📚</span> Courses
                    </Link>
                    <Link to="/student/assignments" className={`sidebar-item ${isActive('/student/assignments')}`}>
                        <span style={{ fontSize: '1.25rem' }}>📄</span> Assignments
                    </Link>
                    <Link to="/student/results" className={`sidebar-item ${isActive('/student/results')}`}>
                        <span style={{ fontSize: '1.25rem' }}>🎓</span> Results
                    </Link>
                    <Link to="/student/marks" className={`sidebar-item ${isActive('/student/marks')}`}>
                        <span style={{ fontSize: '1.25rem' }}>🎯</span> Marks
                    </Link>
                    <Link to="/student/circulars" className={`sidebar-item ${isActive('/student/circulars')}`}>
                        <span style={{ fontSize: '1.25rem' }}>📢</span> Circulars
                    </Link>
                </nav>

                <div style={{ marginTop: 'auto', borderTop: '1px solid rgba(255,255,255,0.1)', paddingTop: '2rem' }}>
                    <div style={{ marginBottom: '1.5rem' }}>
                        <p style={{ fontSize: '0.875rem', color: 'white', fontWeight: '600' }}>{user?.username}</p>
                        <p style={{ fontSize: '0.75rem', color: '#bfdbfe' }}>Registered Student</p>
                    </div>
                    <button className="btn btn-secondary btn-block" style={{ background: 'rgba(255,255,255,0.05)', color: 'white', border: 'none', justifyContent: 'center' }} onClick={logout}>
                        Log Out
                    </button>
                </div>
            </aside>

            <main className="main-content">
                <header style={{ marginBottom: '3rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <div className="animate-fade-in">
                        <h2 style={{ fontSize: '2rem', color: 'var(--text-main)' }}>Student Workspace</h2>
                        <p style={{ color: 'var(--text-secondary)', fontWeight: '500' }}>Track your academic progress and upcoming deadlines.</p>
                    </div>
                    <ThemeToggle />
                </header>

                <div className="dashboard-main animate-fade-in">
                    <Routes>
                        <Route index element={<StudentOverview />} />
                        <Route path="timetable" element={<StudentTimetable />} />
                        <Route path="attendance" element={<StudentAttendance />} />
                        <Route path="assignments" element={<StudentAssignments />} />
                        <Route path="results" element={<StudentResults />} />
                        <Route path="courses" element={<StudentCourses />} />
                        <Route path="marks" element={<StudentMarks />} />
                        <Route path="circulars" element={<StudentCirculars />} />
                        <Route path="*" element={<StudentOverview />} />
                    </Routes>
                </div>
            </main>
        </div>
    );
};

export default StudentDashboard;
