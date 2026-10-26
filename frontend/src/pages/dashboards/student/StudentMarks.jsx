import React, { useState, useEffect } from 'react';
import api from '../../../services/api';

const StudentMarks = () => {
    const [marks, setMarks] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchMarks = async () => {
            try {
                const response = await api.get('/students/marks');
                setMarks(response.data);
            } catch (error) {
                console.error('Error fetching marks:', error);
            } finally {
                setLoading(false);
            }
        };
        fetchMarks();
    }, []);

    if (loading) return <div className="loading-spinner">Validating Performance...</div>;

    return (
        <div className="marks-container animate-fade-in">
            <header style={{ marginBottom: '2.5rem' }}>
                <h3 style={{ fontSize: '1.5rem', fontWeight: '800' }}>Internal Validation Records</h3>
                <p style={{ color: 'var(--text-secondary)' }}>Verified academic scores after Faculty & HOD approval.</p>
            </header>

            <div className="glass-card" style={{ padding: '0', overflow: 'hidden' }}>
                <table className="premium-table">
                    <thead>
                        <tr>
                            <th>Subject & Code</th>
                            <th>Exam Type</th>
                            <th>Score</th>
                            <th>Weightage</th>
                            <th>Validation</th>
                        </tr>
                    </thead>
                    <tbody>
                        {marks.map((mark, index) => (
                            <tr key={index}>
                                <td>
                                    <div style={{ fontWeight: '600' }}>{mark.subjectCode}</div>
                                    <div style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>Semester {mark.semester}</div>
                                </td>
                                <td>{mark.examType}</td>
                                <td style={{ fontSize: '1.25rem', fontWeight: '800', color: (mark.marksObtained / mark.maxMarks) >= 0.5 ? 'var(--text-main)' : 'var(--error)' }}>
                                    {mark.marksObtained} <span style={{ fontSize: '0.8rem', color: 'var(--text-muted)' }}>/ {mark.maxMarks}</span>
                                </td>
                                <td>
                                    <div className="progress-track" style={{ width: '100px' }}>
                                        <div className="progress-fill" style={{
                                            width: `${(mark.marksObtained / mark.maxMarks) * 100}%`,
                                            background: (mark.marksObtained / mark.maxMarks) >= 0.75 ? 'var(--success)' : 'var(--accent)'
                                        }}></div>
                                    </div>
                                </td>
                                <td>
                                    <span className="perf-badge perf-high">APPROVED</span>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
                {marks.length === 0 && (
                    <div style={{ padding: '4rem', textAlign: 'center', color: 'var(--text-muted)' }}>
                        No approved marks found yet. Verification pending by HOD.
                    </div>
                )}
            </div>
        </div>
    );
};

export default StudentMarks;
