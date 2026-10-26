import React, { useState, useEffect } from 'react';
import api from '../../../services/api';

const StudentCourses = () => {
    const [courses, setCourses] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchCourses = async () => {
            try {
                const response = await api.get('/students/courses');
                setCourses(response.data);
            } catch (error) {
                console.error('Error fetching courses:', error);
            } finally {
                setLoading(false);
            }
        };
        fetchCourses();
    }, []);

    if (loading) return <div className="loading-spinner">Loading Courses...</div>;

    return (
        <div className="courses-container animate-fade-in">
            <div className="glass-card" style={{ padding: '2rem', borderLeft: '6px solid var(--primary)' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '1rem', marginBottom: '2rem' }}>
                    <span style={{ fontSize: '2rem' }}>📚</span>
                    <h3 style={{ fontSize: '1.5rem', margin: 0 }}>Registered Courses</h3>
                </div>

                <div className="courses-grid" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))', gap: '1.5rem' }}>
                    {courses.map((course, idx) => (
                        <div key={idx} className="card hover-glow" style={{ padding: '1.5rem', border: '1px solid var(--border)' }}>
                            <div style={{ color: 'var(--primary)', fontWeight: 'bold', marginBottom: '0.5rem' }}>{course.subjectCode}</div>
                            <h4 style={{ margin: '0 0 1rem 0' }}>{course.subjectName}</h4>
                            <div style={{ fontSize: '0.85rem', color: 'var(--text-secondary)' }}>
                                <div><strong>Faculty:</strong> {course.faculty?.firstName} {course.faculty?.lastName}</div>
                                <div><strong>Dept:</strong> {course.department?.name}</div>
                                <div style={{ marginTop: '0.5rem', display: 'flex', gap: '0.5rem' }}>
                                    <span className="badge-blue">Semester {course.semester}</span>
                                    <span className="badge-green">Credits: 4</span>
                                </div>
                            </div>
                        </div>
                    ))}
                    {courses.length === 0 && (
                        <div style={{ gridColumn: '1/-1', textAlign: 'center', padding: '3rem', color: 'var(--text-muted)' }}>
                            No active courses found for the current semester.
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
};

export default StudentCourses;
