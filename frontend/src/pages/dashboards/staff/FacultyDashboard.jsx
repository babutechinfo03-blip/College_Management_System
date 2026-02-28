import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';

const DAYS = ['MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY'];
const HOURS = [1, 2, 3, 4, 5, 6, 7, 8];

const FacultyDashboard = ({ data }) => {
    const navigate = useNavigate();
    const assignments = data?.teachingAssignments || [];
    const [timetable, setTimetable] = useState([]);

    // Fetch individual timetable
    useEffect(() => {
        const fetchTimetable = async () => {
            try {
                const res = await axios.get('/api/staff/my-timetable');
                setTimetable(res.data);
            } catch (err) {
                console.error("Failed to fetch timetable", err);
            }
        };
        fetchTimetable();
    }, []);

    const getCell = (day, hour) => timetable.find(t => t.dayOfWeek === day && t.hour === hour);

    return (
        <div className="animate-fade-in">
            {/* Quick Actions / Assignments Card */}
            <div className="glass-card" style={{ marginBottom: '2rem', padding: '1.5rem' }}>
                <h3 style={{ fontSize: '1.25rem', marginBottom: '1rem' }}>My Subjects</h3>
                {assignments.length > 0 ? (
                    <div className="grid" style={{ gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1rem' }}>
                        {assignments.map((subject, idx) => (
                            <div key={idx} className="glass-card zoom-in-hover"
                                style={{ padding: '1rem', borderLeft: '3px solid var(--primary)', cursor: 'pointer', background: 'rgba(255,255,255,0.5)' }}
                                onClick={() => navigate('/staff/attendance')}>
                                <div style={{ fontSize: '0.85rem', fontWeight: 'bold' }}>{subject.subject}</div>
                                <div style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>{subject.classLabel}</div>
                            </div>
                        ))}
                    </div>
                ) : (
                    <p style={{ color: 'var(--text-muted)' }}>No subjects assigned yet.</p>
                )}
            </div>

            {/* Timetable Grid */}
            <h3 style={{ fontSize: '1.25rem', marginBottom: '1.5rem' }}>Weekly Schedule</h3>
            <div className="glass-card" style={{ padding: '1rem', overflowX: 'auto' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', minWidth: '700px' }}>
                    <thead>
                        <tr>
                            <th style={{ padding: '1rem', background: '#f8fafc', color: '#64748b' }}>Day / Period</th>
                            {HOURS.map(h => <th key={h} style={{ padding: '0.75rem', background: '#f8fafc', fontSize: '0.9rem' }}>{h}</th>)}
                        </tr>
                    </thead>
                    <tbody>
                        {DAYS.map(day => (
                            <tr key={day} style={{ borderBottom: '1px solid #e2e8f0' }}>
                                <td style={{ padding: '1rem', fontWeight: 'bold', fontSize: '0.85rem' }}>{day}</td>
                                {HOURS.map(h => {
                                    const entry = getCell(day, h);
                                    return (
                                        <td key={h} style={{
                                            padding: '0.5rem',
                                            borderLeft: '1px solid #f1f5f9',
                                            textAlign: 'center',
                                            fontSize: '0.8rem',
                                            background: entry ? '#eff6ff' : 'transparent',
                                            color: entry ? '#1d4ed8' : 'inherit'
                                        }}>
                                            {entry ? (
                                                <div className="animate-fade-in">
                                                    <div style={{ fontWeight: '700' }}>{entry.subjectCode}</div>
                                                    <div style={{ fontSize: '0.7rem' }}>Yr {entry.year} - {entry.department.code}</div>
                                                </div>
                                            ) : '-'}
                                        </td>
                                    );
                                })}
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
};

export default FacultyDashboard;
