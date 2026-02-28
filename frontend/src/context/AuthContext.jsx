import React, { createContext, useContext, useState } from 'react';
import api from '../services/api';

const AuthContext = createContext(null);

export const AuthProvider = ({ children }) => {
    const [user, setUser] = useState(() => {
        try {
            const savedUser = localStorage.getItem('user');
            return savedUser ? JSON.parse(savedUser) : null;
        } catch (error) {
            console.error('Failed to parse user from localStorage:', error);
            localStorage.removeItem('user');
            return null;
        }
    });

    const login = async (username, password, endpoint = '/auth/login') => {
        try {
            console.log('🔐 Login attempt:', { username, endpoint });
            const response = await api.post(endpoint, { username, password });
            const userData = response.data;

            // Set initial active role for staff
            if (userData.staffRoles && userData.staffRoles.length > 0) {
                userData.activeRole = userData.staffRoles.includes('HOD') ? 'HOD' :
                    userData.staffRoles.includes('CLASS_ADVISOR') ? 'CLASS_ADVISOR' :
                        userData.staffRoles[0];
            } else {
                userData.activeRole = userData.role;
            }

            console.log('✅ Login response:', userData);
            setUser(userData);
            localStorage.setItem('user', JSON.stringify(userData));
            return userData;
        } catch (error) {
            console.error('❌ Login error:', error);
            throw error;
        }
    };

    const switchRole = (roleName) => {
        setUser(prev => {
            const updated = { ...prev, activeRole: roleName };
            localStorage.setItem('user', JSON.stringify(updated));
            return updated;
        });
    };

    const logout = () => {
        setUser(null);
        localStorage.removeItem('user');
    };

    return (
        <AuthContext.Provider value={{ user, login, logout, switchRole }}>
            {children}
        </AuthContext.Provider>
    );
};

export const useAuth = () => useContext(AuthContext);
