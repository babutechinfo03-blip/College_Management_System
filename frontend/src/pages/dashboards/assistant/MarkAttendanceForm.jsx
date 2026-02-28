import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import api from '../../../services/api';

const MarkAttendanceForm = () => {
    const navigate = useNavigate();
    const [step, setStep] = useState(1);
    const [degrees, setDegrees] = useState([]);
    const [specializations, setSpecializations] = useState([]);

    const [formData, setFormData] = useState({
        programType: '',
        degreeId: '',
        specializationId: '',
        year: '1',
        semester: '1',
        date: new Date().toISOString().split('T')[0],
        hour: '1'
    });

    const [students, setStudents] = useState([]);
    const [attendanceRows, setAttendanceRows] = useState({});
    const [loading, setLoading] = useState(false);
    const [submitting, setSubmitting] = useState(false);
    const [error, setError] = useState('');

    // Fetch Degrees when Program Type changes
    useEffect(() => {
        if (formData.programType) {
            const fetchDegrees = async () => {
                try {
                    const res = await api.get('/attendance/degrees', { params: { programType: formData.programType } });
                    setDegrees(res.data);
                    setSpecializations([]); // Reset lower levels
                    setFormData(prev => ({ ...prev, degreeId: '', specializationId: '' }));
                } catch (err) {
                    console.error('Failed to fetch degrees');
                }
            };
            fetchDegrees();
        } else {
            setDegrees([]);
            setSpecializations([]);
        }
    }, [formData.programType]);

    // Fetch Specializations when Degree changes
    useEffect(() => {
        if (formData.degreeId) {
            const fetchSpecs = async () => {
                try {
                    const res = await api.get('/attendance/specializations', { params: { degreeId: formData.degreeId } });
                    setSpecializations(res.data);
                    setFormData(prev => ({ ...prev, specializationId: '' }));
                } catch (err) {
                    console.error('Failed to fetch specializations');
                }
            };
            fetchSpecs();
        } else {
            setSpecializations([]);
        }
    }, [formData.degreeId]);

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setFormData(prev => ({ ...prev, [name]: value }));
    };

    const loadStudents = async () => {
        if (!formData.specializationId) {
            setError('Please complete all academic selections (Program -> Degree -> Sub-Dept)');
            return;
        }
        setLoading(true);
        setError('');
        try {
            const res = await api.get('/attendance/students-list', {
                params: {
                    specializationId: formData.specializationId,
                    year: formData.year,
                    semester: formData.semester
                }
            });
            setStudents(res.data);
            const initialAttendance = {};
            res.data.forEach(s => initialAttendance[s.studentId] = 'PRESENT');
            setAttendanceRows(initialAttendance);
            setStep(2);
        } catch (err) {
            setError(err.response?.data?.error || 'Failed to load student list');
        } finally {
            setLoading(false);
        }
    };

    const toggleStatus = (studentId) => {
        setAttendanceRows(prev => ({
            ...prev,
            [studentId]: prev[studentId] === 'PRESENT' ? 'ABSENT' : 'PRESENT'
        }));
    };

    const bulkMark = (status) => {
        const updated = {};
        students.forEach(s => updated[s.studentId] = status);
        setAttendanceRows(updated);
    };

    const handleSubmit = async () => {
        setSubmitting(true);
        setError('');
        try {
            const payload = {
                ...formData,
                attendance: students.map(s => ({
                    studentId: s.studentId,
                    status: attendanceRows[s.studentId]
                }))
            };
            await api.post('/attendance/submit', payload);
            alert('Attendance submitted and locked successfully!');
            navigate('/assistant/attendance');
        } catch (err) {
            setError(err.response?.data?.error || 'Submission failed');
        } finally {
            setSubmitting(false);
        }
    };

    return (
        <div className="animate-fade-in">
            <div style={{ marginBottom: '2rem', display: 'flex', alignItems: 'center', gap: '1rem' }}>
                <button className="btn btn-secondary" onClick={() => step === 1 ? navigate('/assistant/attendance') : setStep(1)} style={{ padding: '0.5rem' }}>
                    ← Back
                </button>
                <h3 style={{ fontSize: '1.25rem' }}>{step === 1 ? 'Step 1: Academic Selection' : 'Step 2: Mark Students'}</h3>
            </div>

            {error && (
                <div style={{ padding: '1rem', background: '#fee2e2', color: '#991b1b', borderRadius: '8px', marginBottom: '1.5rem', fontSize: '0.875rem' }}>
                    {error}
                </div>
            )}

            {step === 1 ? (
                <div className="glass-card" style={{ padding: '2rem', maxWidth: '800px' }}>
                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem' }}>
                        <div>
                            <label className="form-label">Program Type *</label>
                            <select name="programType" className="form-control" value={formData.programType} onChange={handleInputChange}>
                                <option value="">Select Program</option>
                                <option value="UG">Undergraduate (UG)</option>
                                <option value="PG">Postgraduate (PG)</option>
                            </select>
                        </div>
                        <div>
                            <label className="form-label">Degree *</label>
                            <select name="degreeId" className="form-control" value={formData.degreeId} onChange={handleInputChange} disabled={!formData.programType}>
                                <option value="">Select Degree</option>
                                {degrees.map(d => (
                                    <option key={d.id} value={d.id}>{d.name} ({d.code})</option>
                                ))}
                            </select>
                        </div>
                        <div>
                            <label className="form-label">Sub-Department *</label>
                            <select name="specializationId" className="form-control" value={formData.specializationId} onChange={handleInputChange} disabled={!formData.degreeId}>
                                <option value="">Select Department</option>
                                {specializations.map(s => (
                                    <option key={s.id} value={s.id}>{s.name} ({s.code})</option>
                                ))}
                            </select>
                        </div>
                        <div>
                            <label className="form-label">Year *</label>
                            <select name="year" className="form-control" value={formData.year} onChange={handleInputChange}>
                                {[1, 2, 3, 4].map(y => <option key={y} value={y}>Year {y}</option>)}
                            </select>
                        </div>
                        <div>
                            <label className="form-label">Semester *</label>
                            <select name="semester" className="form-control" value={formData.semester} onChange={handleInputChange}>
                                {[1, 2, 3, 4, 5, 6, 7, 8].map(s => <option key={s} value={s}>Sem {s}</option>)}
                            </select>
                        </div>
                        <div>
                            <label className="form-label">Date *</label>
                            <input type="date" name="date" className="form-control" value={formData.date} onChange={handleInputChange} max={new Date().toISOString().split('T')[0]} />
                        </div>
                        <div>
                            <label className="form-label">Hour (1–8) *</label>
                            <select name="hour" className="form-control" value={formData.hour} onChange={handleInputChange}>
                                {[1, 2, 3, 4, 5, 6, 7, 8].map(h => <option key={h} value={h}>Hour {h}</option>)}
                            </select>
                        </div>
                        <div style={{ gridColumn: 'span 2', display: 'flex', justifyContent: 'flex-end', marginTop: '1rem' }}>
                            <button className="btn btn-primary" onClick={loadStudents} disabled={loading || !formData.specializationId}>
                                {loading ? 'Loading...' : 'Load Student List'}
                            </button>
                        </div>
                    </div>
                </div>
            ) : (
                <div style={{ display: 'grid', gap: '2rem' }}>
                    <div className="glass-card" style={{ padding: '1rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center', background: '#f8fafc' }}>
                        <div style={{ fontSize: '0.875rem' }}>
                            <strong>{students.length}</strong> Students loaded for <strong>Hour {formData.hour}</strong>
                        </div>
                        <div style={{ display: 'flex', gap: '0.5rem' }}>
                            <button className="btn btn-secondary" style={{ fontSize: '0.75rem', background: '#dcfce7', color: '#166534' }} onClick={() => bulkMark('PRESENT')}>Mark All P</button>
                            <button className="btn btn-secondary" style={{ fontSize: '0.75rem', background: '#fee2e2', color: '#991b1b' }} onClick={() => bulkMark('ABSENT')}>Mark All A</button>
                        </div>
                    </div>

                    <div className="glass-card" style={{ padding: '0', overflow: 'hidden' }}>
                        <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                            <thead style={{ background: 'var(--slate-50)', borderBottom: '1px solid var(--border)' }}>
                                <tr>
                                    <th style={{ padding: '1rem', textAlign: 'left' }}>Student</th>
                                    <th style={{ padding: '1rem', textAlign: 'center' }}>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                {students.map(s => (
                                    <tr key={s.studentId} style={{ borderBottom: '1px solid var(--border)' }}>
                                        <td style={{ padding: '1rem' }}>
                                            <div style={{ display: 'flex', alignItems: 'center', gap: '1rem' }}>
                                                {s.photoPath ? (
                                                    <img src={`${api.defaults.baseURL}/office/photos?path=${s.photoPath}`} alt="" style={{ width: '40px', height: '40px', borderRadius: '50%', objectFit: 'cover' }} />
                                                ) : (
                                                    <div style={{ width: '40px', height: '40px', borderRadius: '50%', background: 'var(--slate-100)', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '0.75rem', color: 'var(--text-muted)' }}>👤</div>
                                                )}
                                                <div>
                                                    <div style={{ fontWeight: '600', fontSize: '0.9rem' }}>{s.name}</div>
                                                    <div style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>{s.studentId}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td style={{ padding: '1rem', textAlign: 'center' }}>
                                            <button
                                                className={`btn ${attendanceRows[s.studentId] === 'PRESENT' ? 'btn-primary' : 'btn-secondary'}`}
                                                style={{ minWidth: '100px', background: attendanceRows[s.studentId] === 'PRESENT' ? '#10b981' : '#ef4444', color: 'white', border: 'none' }}
                                                onClick={() => toggleStatus(s.studentId)}
                                            >
                                                {attendanceRows[s.studentId]}
                                            </button>
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>

                    <div className="glass-card" style={{ padding: '1.5rem', display: 'flex', justifyContent: 'flex-end', gap: '1rem' }}>
                        <button className="btn btn-secondary" onClick={() => setStep(1)} disabled={submitting}>Edit Selection</button>
                        <button className="btn btn-primary" onClick={handleSubmit} disabled={submitting}>
                            {submitting ? 'Submitting...' : 'Submit & Lock Attendance'}
                        </button>
                    </div>
                </div>
            )}
        </div>
    );
};

export default MarkAttendanceForm;
