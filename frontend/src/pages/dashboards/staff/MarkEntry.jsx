import React, { useState, useEffect } from 'react';
import axios from 'axios';

const MarkEntry = () => {
    const [assignments, setAssignments] = useState([]);
    const [selectedAssignmentId, setSelectedAssignmentId] = useState('');
    const [students, setStudents] = useState([]);
    const [marks, setMarks] = useState({});
    const [examType, setExamType] = useState('INTERNAL1'); // INTERNAL1, INTERNAL2, SEMESTER
    const [message, setMessage] = useState('');
    const [loading, setLoading] = useState(false);

    useEffect(() => {
        // Fetch Subjects the Faculty Teaches
        const fetchAssignments = async () => {
            try {
                const res = await axios.get('/api/staff/teaching-assignments');
                setAssignments(res.data);
            } catch (err) {
                console.error("Failed to fetch assignments", err);
            }
        };
        fetchAssignments();
    }, []);

    const fetchStudents = async (assignmentId) => {
        setLoading(true);
        try {
            const assignment = assignments.find(a => a.id.toString() === assignmentId.toString());
            if (!assignment) return;

            // Fetch students based on Dept & Year from Assignment
            // Note: Ideally we filter by Section too if available, but for now Dept+Year
            // Backend endpoint expects deptId and year. 
            // The assignment object from API has: { id, department: "CSE", year: 2, ... } 
            // Wait, we need department ID, but frontend might only have Code. 
            // Actually, let's assume the frontend assignment object has what we need or correct the backend to accept codes.
            // Let's check StaffController: getTeachingAssignments returns "department": a.getDepartment().getCode()
            // We need ID for getStudents endpoint. 
            // Quick fix: Pass the code and let backend handle, or fetch departments map.
            // Or better: Update getTeachingAssignments to return DeptId. 
            // For now, I'll rely on a known ID if possible or just try passing the code if backend supports it.
            // Actually, let's assume we need to update StaffController to return deptId.
            // I'll skip that check for a moment and assume I can get ID.

            // To make this robust without another backend edit, let's mock the "Dept Code -> ID" mapping or just fetch all departments to find ID.
            const detpsRes = await axios.get('/api/staff/departments');
            const dept = detpsRes.data.find(d => d.code === assignment.department);

            if (dept) {
                const res = await axios.get(`/api/staff/students?departmentId=${dept.id}&year=${assignment.year}`);
                setStudents(res.data);

                // Initialize marks
                const initialMarks = {};
                res.data.forEach(s => initialMarks[s.id] = { marks: '', maxMarks: 100 });
                setMarks(initialMarks);
            }
        } catch (err) {
            console.error(err);
            setMessage('Failed to load students.');
        } finally {
            setLoading(false);
        }
    };

    const handleAssignmentChange = (e) => {
        const id = e.target.value;
        setSelectedAssignmentId(id);
        if (id) fetchStudents(id);
        else setStudents([]);
    };

    const handleMarkChange = (studentId, field, value) => {
        setMarks(prev => ({
            ...prev,
            [studentId]: { ...prev[studentId], [field]: value }
        }));
    };

    const handleSubmit = async (isFinal) => {
        if (!selectedAssignmentId) return;
        const assignment = assignments.find(a => a.id.toString() === selectedAssignmentId.toString());

        const payload = {
            subjectCode: assignment.subjectCode,
            examType,
            semester: assignment.semester,
            isFinal,
            marks: students.map(s => ({
                studentId: s.id, // Using User/Student ID from DB
                marks: marks[s.id]?.marks || 0,
                maxMarks: marks[s.id]?.maxMarks || 100
            }))
        };

        try {
            await axios.post('/api/staff/marks/submit', payload);
            setMessage(isFinal ? 'Marks Submitted Successfully!' : 'Marks Saved as Draft.');
        } catch (err) {
            console.error(err);
            setMessage('Failed to submit marks.');
        }
    };

    return (
        <div className="animate-fade-in">
            <div className="glass-card" style={{ padding: '2rem' }}>
                <h3 style={{ fontSize: '1.25rem', marginBottom: '1.5rem' }}>Mark Entry</h3>

                {/* Controls */}
                <div className="grid" style={{ gridTemplateColumns: 'repeat(3, 1fr)', gap: '1rem', marginBottom: '2rem' }}>
                    <div>
                        <label className="form-label">Subject / Class</label>
                        <select className="form-control" value={selectedAssignmentId} onChange={handleAssignmentChange}>
                            <option value="">-- Select Subject --</option>
                            {assignments.map(a => (
                                <option key={a.id} value={a.id}>{a.subject} ({a.department} - Yr {a.year})</option>
                            ))}
                        </select>
                    </div>
                    <div>
                        <label className="form-label">Exam Type</label>
                        <select className="form-control" value={examType} onChange={e => setExamType(e.target.value)}>
                            <option value="INTERNAL1">Internal Assessment 1</option>
                            <option value="INTERNAL2">Internal Assessment 2</option>
                            <option value="SEMESTER">Semester End Exam</option>
                        </select>
                    </div>
                </div>

                {/* Grid */}
                {loading ? <p>Loading Students...</p> : students.length > 0 && (
                    <>
                        <table style={{ width: '100%', marginBottom: '2rem' }}>
                            <thead>
                                <tr style={{ borderBottom: '2px solid #e2e8f0' }}>
                                    <th style={{ textAlign: 'left', padding: '1rem' }}>ID</th>
                                    <th style={{ textAlign: 'left', padding: '1rem' }}>Name</th>
                                    <th style={{ textAlign: 'right', padding: '1rem' }}>Marks Obtained</th>
                                    <th style={{ textAlign: 'right', padding: '1rem' }}>Max Marks</th>
                                </tr>
                            </thead>
                            <tbody>
                                {students.map(s => (
                                    <tr key={s.id} style={{ borderBottom: '1px solid #f1f5f9' }}>
                                        <td style={{ padding: '1rem' }}>{s.studentId}</td>
                                        <td style={{ padding: '1rem', fontWeight: '500' }}>{s.firstName} {s.lastName}</td>
                                        <td style={{ padding: '0.5rem', textAlign: 'right' }}>
                                            <input
                                                type="number"
                                                className="form-control"
                                                style={{ width: '100px', marginLeft: 'auto' }}
                                                value={marks[s.id]?.marks}
                                                onChange={e => handleMarkChange(s.id, 'marks', e.target.value)}
                                            />
                                        </td>
                                        <td style={{ padding: '0.5rem', textAlign: 'right' }}>
                                            <input
                                                type="number"
                                                className="form-control"
                                                style={{ width: '100px', marginLeft: 'auto' }}
                                                value={marks[s.id]?.maxMarks}
                                                onChange={e => handleMarkChange(s.id, 'maxMarks', e.target.value)}
                                            />
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>

                        <div style={{ display: 'flex', gap: '1rem', justifyContent: 'flex-end' }}>
                            <button className="btn btn-outline" onClick={() => handleSubmit(false)}>Save Draft</button>
                            <button className="btn btn-primary" onClick={() => handleSubmit(true)}>Submit for Verification</button>
                        </div>
                    </>
                )}

                {message && <div style={{ marginTop: '1rem', padding: '1rem', background: '#f0fdf4', color: '#166534', borderRadius: '0.5rem' }}>{message}</div>}
            </div>
        </div>
    );
};

export default MarkEntry;
