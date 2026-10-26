import React, { useState, useEffect } from 'react';
import api from '../../../services/api';

const StudentResults = () => {
    const [data, setData] = useState({ results: [], cgpa: "0.00" });
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchResults = async () => {
            try {
                const response = await api.get('/students/results');
                setData(response.data);
            } catch (error) {
                console.error('Error fetching results:', error);
            } finally {
                setLoading(false);
            }
        };
        fetchResults();
    }, []);

    if (loading) return <div className="loading-spinner">Calculating Academic Profile...</div>;

    const semesters = [...new Set(data.results.map(r => r.semester))].sort();

    return (
        <div className="results-container animate-fade-in">
            <header style={{ marginBottom: '2.5rem', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                <div>
                    <h3 style={{ fontSize: '1.5rem', fontWeight: '800' }}>Official Academic Records</h3>
                    <p style={{ color: 'var(--text-secondary)' }}>Consolidated semester grades and CGPA data.</p>
                </div>
                <div className="glass-card" style={{ padding: '1rem 1.5rem', textAlign: 'center', borderTop: '4px solid var(--primary)' }}>
                    <div style={{ fontSize: '0.7rem', fontWeight: '700', color: 'var(--text-muted)', textTransform: 'uppercase' }}>CUMULATIVE GPA</div>
                    <div style={{ fontSize: '2rem', fontWeight: '800', color: 'var(--primary)' }}>{data.cgpa}</div>
                </div>
            </header>

            {semesters.map(sem => (
                <div key={sem} style={{ marginBottom: '3rem' }}>
                    <h4 style={{ marginBottom: '1rem', paddingBottom: '0.5rem', borderBottom: '2px solid var(--border)', display: 'inline-block' }}>
                        Semester {sem} Performance
                    </h4>
                    <div className="glass-card" style={{ padding: '0', overflow: 'hidden' }}>
                        <table className="premium-table">
                            <thead>
                                <tr>
                                    <th>Course Code</th>
                                    <th>Subject Name</th>
                                    <th>Credits</th>
                                    <th>Grade</th>
                                    <th>Result</th>
                                </tr>
                            </thead>
                            <tbody>
                                {data.results.filter(r => r.semester === sem).map((row, idx) => (
                                    <tr key={idx}>
                                        <td style={{ fontWeight: '600' }}>{row.subjectCode}</td>
                                        <td>{row.subjectName}</td>
                                        <td>{row.credits}</td>
                                        <td style={{ fontWeight: '800' }}>{row.grade}</td>
                                        <td>
                                            <span className={`perf-badge ${row.resultStatus === 'PASS' ? 'perf-high' : 'perf-risk'}`}>
                                                {row.resultStatus}
                                            </span>
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                </div>
            ))}

            {data.results.length === 0 && (
                <div style={{ padding: '4rem', textAlign: 'center', color: 'var(--text-muted)' }}>
                    No results have been published for your profile yet.
                </div>
            )}
        </div>
    );
};

export default StudentResults;
