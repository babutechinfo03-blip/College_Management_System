import React, { useState, useEffect } from 'react';
import axios from 'axios';

const AcademicMonitoring = () => {
    const [academicYear, setAcademicYear] = useState('2023-2024'); // Default, make dynamic later
    const [semester, setSemester] = useState('EVEN'); // Default, make dynamic later
    const [control, setControl] = useState(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetchControlStatus();
    }, [academicYear, semester]);

    const fetchControlStatus = async () => {
        setLoading(true);
        try {
            const response = await axios.get('/api/principal/academic-control', {
                params: { academicYear, semester }
            });
            setControl(response.data);
        } catch (err) {
            console.error('Error fetching academic control:', err);
        } finally {
            setLoading(false);
        }
    };

    const handleToggleFreeze = async (field) => {
        if (!control) return;

        const updatedControl = {
            ...control,
            [field]: !control[field]
        };

        try {
            const response = await axios.post('/api/principal/academic-control', updatedControl);
            setControl(response.data);
        } catch (err) {
            console.error('Error updating academic control:', err);
        }
    };

    if (loading && !control) return <div className="p-6">Loading academic controls...</div>;

    return (
        <div className="animate-fade-in p-6">
            <h2 className="text-2xl font-bold mb-6" style={{ color: 'var(--text-main)' }}>Academic Monitoring & Control</h2>

            <div className="card p-6 mb-8" style={{ background: 'var(--bg-card)', border: '1px solid var(--border)', borderRadius: 'var(--radius)', padding: '1.5rem' }}>
                <h3 className="text-lg font-bold mb-4" style={{ color: 'var(--text-main)' }}>Freeze Controls ({academicYear} - {semester})</h3>

                <div className="grid grid-cols-3 gap-6" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1.5rem' }}>
                    {/* Attendance Freeze */}
                    <div style={{ padding: '1.5rem', border: '1px solid var(--border)', borderRadius: 'var(--radius)', background: 'var(--bg-main)' }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1rem' }}>
                            <h4 style={{ fontWeight: '600', color: 'var(--text-main)' }}>Attendance</h4>
                            <span style={{
                                fontSize: '1.5rem'
                            }}>📅</span>
                        </div>
                        <p style={{ fontSize: '0.875rem', color: 'var(--text-secondary)', marginBottom: '1rem' }}>
                            {control?.attendanceFrozen
                                ? 'Attendance marking is CURRENTLY FROZEN for this semester.'
                                : 'Attendance marking is OPEN for faculty.'}
                        </p>
                        <button
                            onClick={() => handleToggleFreeze('attendanceFrozen')}
                            className={`btn ${control?.attendanceFrozen ? 'btn-secondary' : 'btn-danger'}`}
                            style={{
                                width: '100%',
                                padding: '0.5rem',
                                border: 'none',
                                borderRadius: '4px',
                                background: control?.attendanceFrozen ? 'var(--text-secondary)' : 'var(--error)',
                                color: 'white',
                                cursor: 'pointer'
                            }}
                        >
                            {control?.attendanceFrozen ? 'Unfreeze Attendance' : 'Freeze Attendance'}
                        </button>
                    </div>

                    {/* Marks Freeze */}
                    <div style={{ padding: '1.5rem', border: '1px solid var(--border)', borderRadius: 'var(--radius)', background: 'var(--bg-main)' }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1rem' }}>
                            <h4 style={{ fontWeight: '600', color: 'var(--text-main)' }}>Internal Marks</h4>
                            <span style={{
                                fontSize: '1.5rem'
                            }}>📝</span>
                        </div>
                        <p style={{ fontSize: '0.875rem', color: 'var(--text-secondary)', marginBottom: '1rem' }}>
                            {control?.marksFrozen
                                ? 'Mark entry is CURRENTLY FROZEN for this semester.'
                                : 'Mark entry is OPEN for faculty.'}
                        </p>
                        <button
                            onClick={() => handleToggleFreeze('marksFrozen')}
                            className={`btn ${control?.marksFrozen ? 'btn-secondary' : 'btn-danger'}`}
                            style={{
                                width: '100%',
                                padding: '0.5rem',
                                border: 'none',
                                borderRadius: '4px',
                                background: control?.marksFrozen ? 'var(--text-secondary)' : 'var(--error)',
                                color: 'white',
                                cursor: 'pointer'
                            }}
                        >
                            {control?.marksFrozen ? 'Unfreeze Marks' : 'Freeze Marks'}
                        </button>
                    </div>

                    {/* Timetable Freeze */}
                    <div style={{ padding: '1.5rem', border: '1px solid var(--border)', borderRadius: 'var(--radius)', background: 'var(--bg-main)' }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1rem' }}>
                            <h4 style={{ fontWeight: '600', color: 'var(--text-main)' }}>Timetable</h4>
                            <span style={{
                                fontSize: '1.5rem'
                            }}>🕒</span>
                        </div>
                        <p style={{ fontSize: '0.875rem', color: 'var(--text-secondary)', marginBottom: '1rem' }}>
                            {control?.timetableFrozen
                                ? 'Timetable modification is FROZEN.'
                                : 'Timetable modification is OPEN.'}
                        </p>
                        <button
                            onClick={() => handleToggleFreeze('timetableFrozen')}
                            className={`btn ${control?.timetableFrozen ? 'btn-secondary' : 'btn-danger'}`}
                            style={{
                                width: '100%',
                                padding: '0.5rem',
                                border: 'none',
                                borderRadius: '4px',
                                background: control?.timetableFrozen ? 'var(--text-secondary)' : 'var(--error)',
                                color: 'white',
                                cursor: 'pointer'
                            }}
                        >
                            {control?.timetableFrozen ? 'Unfreeze Timetable' : 'Freeze Timetable'}
                        </button>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default AcademicMonitoring;
