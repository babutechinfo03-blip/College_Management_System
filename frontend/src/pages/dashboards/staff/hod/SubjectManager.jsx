import React, { useState, useEffect } from 'react';
import api from '../../../../services/api';

const SubjectManager = () => {
    // 1. State for form and data
    const [facultyList, setFacultyList] = useState([]);
    const [departments, setDepartments] = useState([]);
    const [assignments, setAssignments] = useState([]);
    const [formData, setFormData] = useState({
        departmentId: '',
        year: 1,
        semester: 1,
        subjectName: '',
        subjectCode: '',
        facultyId: ''
    });
    const [loading, setLoading] = useState(false);

    // 2. Fetch Initial Data
    useEffect(() => {
        const fetchMeta = async () => {
            try {
                // Fetch Dept Faculty (Scoped)
                const facultyRes = await api.get('/hod/faculty');
                setFacultyList(facultyRes.data);

                // Auto-set Department
                const profileRes = await api.get('/staff/dashboard?activeRole=HOD');
                if (profileRes.data.profile.departmentId) {
                    setDepartments([{ id: profileRes.data.profile.departmentId, name: profileRes.data.profile.department }]);
                    setFormData(prev => ({ ...prev, departmentId: profileRes.data.profile.departmentId }));
                }

                loadAssignments();
            } catch (err) {
                console.error("Failed to load metadata", err);
            }
        };
        fetchMeta();
    }, []);

    const loadAssignments = async () => {
        try {
            const res = await api.get('/hod/assignments');
            setAssignments(res.data);
        } catch (err) {
            console.error("Failed to load assignments");
        }
    };

    // 3. Handlers
    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        try {
            await api.post('/hod/assign-subject', formData);
            alert('Subject Assigned Successfully!');
            loadAssignments();
        } catch (err) {
            alert('Failed to assign: ' + (err.response?.data?.error || err.message));
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="animate-fade-in">
            <h2 style={{ fontSize: '1.5rem', marginBottom: '2rem' }}>Subject Allocation Manager</h2>

            <div className="glass-card" style={{ padding: '2rem', marginBottom: '2rem' }}>
                <form onSubmit={handleSubmit} className="grid" style={{ gridTemplateColumns: '1fr 1fr 1fr', gap: '1.5rem' }}>
                    <div className="form-group">
                        <label className="form-label">Department</label>
                        <select className="form-control" onChange={e => setFormData({ ...formData, departmentId: e.target.value })} required>
                            <option value="">Select Dept</option>
                            {departments.map(d => <option key={d.id} value={d.id}>{d.name}</option>)}
                        </select>
                    </div>
                    <div className="form-group">
                        <label className="form-label">Year</label>
                        <select className="form-control" onChange={e => setFormData({ ...formData, year: e.target.value })} required>
                            <option value="1">Year 1</option>
                            <option value="2">Year 2</option>
                            <option value="3">Year 3</option>
                            <option value="4">Year 4</option>
                        </select>
                    </div>
                    <div className="form-group">
                        <label className="form-label">Semester</label>
                        <input type="number" className="form-control" min="1" max="8" value={formData.semester} onChange={e => setFormData({ ...formData, semester: e.target.value })} required />
                    </div>

                    <div className="form-group">
                        <label className="form-label">Subject Name</label>
                        <input type="text" className="form-control" placeholder="e.g. Data Structures" onChange={e => setFormData({ ...formData, subjectName: e.target.value })} required />
                    </div>
                    <div className="form-group">
                        <label className="form-label">Subject Code</label>
                        <input type="text" className="form-control" placeholder="e.g. CS201" onChange={e => setFormData({ ...formData, subjectCode: e.target.value })} required />
                    </div>

                    <div className="form-group">
                        <label className="form-label">Assign Faculty</label>
                        <select className="form-control" onChange={e => setFormData({ ...formData, facultyId: e.target.value })} required>
                            <option value="">Select Faculty</option>
                            {facultyList.map(f => (
                                <option key={f.id} value={f.id}>{f.firstName} {f.lastName} ({f.department})</option>
                            ))}
                        </select>
                    </div>

                    <button className="btn btn-primary" type="submit" disabled={loading} style={{ gridColumn: 'span 3' }}>
                        {loading ? 'Assigning...' : 'Assign Subject'}
                    </button>
                </form>
            </div>

            <h3 style={{ fontSize: '1.2rem', marginBottom: '1rem' }}>Current Assignments</h3>
            <div className="glass-card" style={{ padding: 0 }}>
                <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                    <thead style={{ background: '#f8fafc' }}>
                        <tr>
                            <th style={{ padding: '1rem', textAlign: 'left' }}>Subject</th>
                            <th style={{ padding: '1rem', textAlign: 'left' }}>Class</th>
                            <th style={{ padding: '1rem', textAlign: 'left' }}>Faculty</th>
                        </tr>
                    </thead>
                    <tbody>
                        {assignments.map(a => (
                            <tr key={a.id} style={{ borderBottom: '1px solid var(--border)' }}>
                                <td style={{ padding: '1rem' }}>{a.subject}</td>
                                <td style={{ padding: '1rem' }}>{a.class}</td>
                                <td style={{ padding: '1rem' }}>{a.facultyName}</td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
};

export default SubjectManager;
