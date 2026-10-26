import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { AuthProvider, useAuth } from './context/AuthContext';
import { SocketProvider } from './context/SocketContext';
import { ThemeProvider } from './context/ThemeContext';
import LandingPage from './pages/LandingPage.jsx';
import InstitutionSelection from './pages/InstitutionSelection.jsx';
import StudentSelection from './pages/StudentSelection.jsx';
import LoginPage from './pages/LoginPage.jsx';
import PrincipalDashboard from './pages/dashboards/PrincipalDashboard.jsx';
import OfficeDashboard from './pages/dashboards/OfficeDashboard.jsx';
import StaffDashboard from './pages/dashboards/StaffDashboard.jsx';
import StudentDashboard from './pages/dashboards/StudentDashboard.jsx';
import AssistantStaffDashboard from './pages/dashboards/AssistantStaffDashboard.jsx';
import ParentDashboard from './pages/dashboards/ParentDashboard.jsx';

const ProtectedRoute = ({ children, allowedRoles }) => {
    const { user } = useAuth();
    console.log('🛡️ ProtectedRoute check:', { user, allowedRoles });
    if (!user) {
        console.log('❌ No user found, redirecting to /');
        return <Navigate to="/" />;
    }
    if (allowedRoles && !allowedRoles.includes(user.role)) {
        console.log('❌ Role mismatch:', { userRole: user.role, allowedRoles });
        return <Navigate to="/" />;
    }
    console.log('✅ Access granted for role:', user.role);
    return children;
};

const AppContent = () => {
    return (
        <Routes>
            <Route path="/" element={<LandingPage />} />

            {/* Institution Flow */}
            <Route path="/institution" element={<InstitutionSelection />} />
            <Route path="/auth-flow/institution/:role" element={<LoginPage />} />

            {/* Student/Parent Flow */}
            <Route path="/portal" element={<StudentSelection />} />
            <Route path="/auth-flow/student/:role" element={<LoginPage />} />
            <Route path="/auth-flow/parent/:role" element={<LoginPage />} />

            <Route path="/principal/*" element={
                <ProtectedRoute allowedRoles={['PRINCIPAL']}>
                    <PrincipalDashboard />
                </ProtectedRoute>
            } />

            <Route path="/office/*" element={
                <ProtectedRoute allowedRoles={['OFFICE']}>
                    <OfficeDashboard />
                </ProtectedRoute>
            } />

            {/* ... other existing routes ... */}
            <Route path="/staff/*" element={
                <ProtectedRoute allowedRoles={['HOD', 'FACULTY', 'ADVISOR']}>
                    <StaffDashboard />
                </ProtectedRoute>
            } />

            <Route path="/student/*" element={
                <ProtectedRoute allowedRoles={['STUDENT']}>
                    <StudentDashboard />
                </ProtectedRoute>
            } />

            <Route path="/assistant/*" element={
                <ProtectedRoute allowedRoles={['ASSISTANT_STAFF']}>
                    <AssistantStaffDashboard />
                </ProtectedRoute>
            } />

            <Route path="/parent/*" element={
                <ProtectedRoute allowedRoles={['PARENT']}>
                    <ParentDashboard />
                </ProtectedRoute>
            } />

            {/* Fallback */}
            <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
    );
};

function App() {
    return (
        <ThemeProvider>
            <AuthProvider>
                <SocketProvider>
                    <Router>
                        <AppContent />
                    </Router>
                </SocketProvider>
            </AuthProvider>
        </ThemeProvider>
    );
}

export default App;
