import React, { createContext, useContext, useState, useEffect, useCallback } from 'react';
import api from '../services/api';

const OfficeContext = createContext();

export const useOffice = () => {
    const context = useContext(OfficeContext);
    if (!context) {
        throw new Error('useOffice must be used within an OfficeProvider');
    }
    return context;
};

export const OfficeProvider = ({ children }) => {
    const [stats, setStats] = useState({
        totalStudents: 0,
        totalFaculty: 0,
        totalAssistants: 0
    });
    const [activities, setActivities] = useState([]);
    const [loading, setLoading] = useState(true);
    const [refreshKey, setRefreshKey] = useState(0);

    const fetchOfficeData = useCallback(async () => {
        try {
            const [statsRes, activityRes] = await Promise.all([
                api.get('/office/dashboard/stats'),
                api.get('/office/activity')
            ]);
            setStats(statsRes.data);
            setActivities(activityRes.data);
        } catch (error) {
            console.error('Error fetching office data:', error);
        } finally {
            setLoading(false);
        }
    }, []);

    useEffect(() => {
        fetchOfficeData();
    }, [fetchOfficeData, refreshKey]);

    const refreshOfficeData = () => {
        setRefreshKey(prev => prev + 1);
    };

    return (
        <OfficeContext.Provider value={{
            stats,
            activities,
            loading,
            refreshOfficeData,
            refreshKey
        }}>
            {children}
        </OfficeContext.Provider>
    );
};
