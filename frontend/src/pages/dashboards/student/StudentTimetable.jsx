import React, { useState, useEffect } from 'react';
import api from '../../../services/api';
import './StudentTimetable.css';

const StudentTimetable = () => {
    const [timetable, setTimetable] = useState({});
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchTimetable = async () => {
            try {
                const response = await api.get('/students/timetable');
                setTimetable(response.data);
            } catch (error) {
                console.error('Error fetching timetable:', error);
            } finally {
                setLoading(false);
            }
        };
        fetchTimetable();
    }, []);

    const days = ['MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY'];
    const hours = [1, 2, 3, 4, 5, 6, 7, 8];

    const getEntry = (day, hour) => {
        return timetable[day]?.find(e => e.hour === hour);
    };

    if (loading) return <div className="loading-spinner">Loading Timetable...</div>;

    return (
        <div className="timetable-container animate-fade-in">
            <div className="glass-card" style={{ padding: '2rem', borderLeft: '6px solid var(--primary)' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '1rem', marginBottom: '2rem' }}>
                    <span style={{ fontSize: '2rem' }}>📅</span>
                    <h3 style={{ fontSize: '1.5rem', margin: 0 }}>Weekly Class Schedule</h3>
                </div>

                <div className="timetable-grid">
                    <div className="timetable-header-cell">Time / Day</div>
                    {days.map(day => (
                        <div key={day} className="timetable-header-cell">{day}</div>
                    ))}

                    {hours.map(hour => (
                        <React.Fragment key={hour}>
                            <div className="timetable-time-cell">Hour {hour}</div>
                            {days.map(day => {
                                const entry = getEntry(day, hour);
                                return (
                                    <div key={`${day}-${hour}`} className={`timetable-slot ${entry ? 'active-slot' : ''}`}>
                                        {entry ? (
                                            <>
                                                <div className="slot-subject">{entry.subjectName}</div>
                                                <div className="slot-code">{entry.subjectCode}</div>
                                                <div className="slot-faculty">{entry.faculty?.firstName}</div>
                                            </>
                                        ) : '-'}
                                    </div>
                                );
                            })}
                        </React.Fragment>
                    ))}
                </div>
            </div>
        </div>
    );
};

export default StudentTimetable;
