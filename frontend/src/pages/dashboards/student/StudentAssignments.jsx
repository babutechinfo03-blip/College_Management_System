import React, { useState, useEffect } from 'react';
import api from '../../../services/api';

const StudentAssignments = () => {
    const [assignments, setAssignments] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchAssignments = async () => {
            try {
                const response = await api.get('/students/assignments');
                setAssignments(response.data);
            } catch (error) {
                console.error('Error fetching assignments:', error);
            } finally {
                setLoading(false);
            }
        };
        fetchAssignments();
    }, []);

    const handleUpload = async (id, file) => {
        if (!file) return;
        const formData = new FormData();
        formData.append('file', file);
        try {
            await api.post(`/students/assignments/${id}/submit`, formData, {
                headers: { 'Content-Type': 'multipart/form-data' }
            });
            alert('Assignment submitted successfully!');
            // Refresh list
            const response = await api.get('/students/assignments');
            setAssignments(response.data);
        } catch (error) {
            console.error('Submission error:', error);
            alert('Failed to submit assignment.');
        }
    };

    if (loading) return <div className="loading-spinner">Loading Assignments...</div>;

    return (
        <div className="assignments-container animate-fade-in">
            <header style={{ marginBottom: '2.5rem' }}>
                <h3 style={{ fontSize: '1.5rem', fontWeight: '800' }}>Academic Deliverables</h3>
                <p style={{ color: 'var(--text-secondary)' }}>Pending and completed task submissions.</p>
            </header>

            <div className="grid gap-md" style={{ gridTemplateColumns: 'repeat(auto-fill, minmax(350px, 1fr))' }}>
                {assignments.map((assignment) => (
                    <div key={assignment.id} className="card" style={{ display: 'flex', flexDirection: 'column', justifyContent: 'space-between' }}>
                        <div>
                            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '1rem' }}>
                                <span className="badge badge-info">{assignment.subjectCode}</span>
                                <span className={`perf-badge ${assignment.submissionStatus === 'PENDING' ? 'perf-risk' : 'perf-high'}`}>
                                    {assignment.submissionStatus}
                                </span>
                            </div>
                            <h4 style={{ marginBottom: '0.25rem' }}>{assignment.title}</h4>
                            <p style={{ fontSize: '0.85rem', color: 'var(--text-secondary)', marginBottom: '1rem', flex: 1 }}>
                                {assignment.description}
                                {assignment.attachmentPath && (
                                    <span style={{ display: 'block', marginTop: '0.5rem' }}>
                                        <a href="#" style={{ color: 'var(--accent)', textDecoration: 'none', fontWeight: 600, fontSize: '0.8rem' }}>📎 Download Attachment</a>
                                    </span>
                                )}
                            </p>
                            <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)' }}>
                                <strong>Deadline:</strong> <span style={{ color: 'var(--text-main)', fontWeight: 600 }}>{new Date(assignment.deadline).toLocaleString()}</span>
                            </div>
                            <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)', marginTop: '0.25rem' }}>
                                <strong>Faculty:</strong> <span style={{ color: 'var(--text-main)', fontWeight: 600 }}>Prof. {assignment.facultyName}</span>
                            </div>
                        </div>

                        <div style={{ marginTop: '1.5rem', paddingTop: '1rem', borderTop: '1px solid var(--border)' }}>
                            {assignment.submissionStatus === 'PENDING' ? (
                                <div style={{ display: 'flex', gap: '0.5rem' }}>
                                    <input
                                        type="file"
                                        id={`file-${assignment.id}`}
                                        style={{ display: 'none' }}
                                        onChange={(e) => handleUpload(assignment.id, e.target.files[0])}
                                    />
                                    <button
                                        className="btn btn-primary btn-block"
                                        onClick={() => document.getElementById(`file-${assignment.id}`).click()}
                                    >
                                        Upload Solution
                                    </button>
                                </div>
                            ) : (
                                <div style={{ textAlign: 'center', color: 'var(--success)', fontWeight: '600', fontSize: '0.9rem' }}>
                                    ✓ Submitted Successfully
                                    {assignment.marks && (
                                        <div style={{ color: 'var(--text-main)', marginTop: '0.5rem' }}>
                                            Grade: {assignment.marks} / 100
                                        </div>
                                    )}
                                </div>
                            )}
                        </div>
                    </div>
                ))}
                {assignments.length === 0 && (
                    <div style={{ gridColumn: '1/-1', padding: '4rem', textAlign: 'center', background: 'var(--card-bg)', borderRadius: 'var(--radius)', border: '1px dashed var(--border)' }}>
                        <p style={{ color: 'var(--text-muted)' }}>No assignments found for your section.</p>
                    </div>
                )}
            </div>
        </div>
    );
};

export default StudentAssignments;
