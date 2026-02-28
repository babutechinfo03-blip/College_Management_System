import React, { useState, useEffect } from 'react';
import api from '../../../services/api';

const AttendanceHistory = () => {
    const [history, setHistory] = useState([]);
    const [loading, setLoading] = useState(true);

    // Filters state
    const [filters, setFilters] = useState({
        programType: '',
        degreeId: '',
        specializationId: '',
        year: '',
        semester: '',
        startDate: '',
        endDate: ''
    });

    const [degrees, setDegrees] = useState([]);
    const [specializations, setSpecializations] = useState([]);

    const fetchHistory = async () => {
        setLoading(true);
        try {
            const res = await api.get('/attendance/history', { params: filters });
            setHistory(res.data);
        } catch (err) {
            console.error('Failed to fetch history');
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchHistory();
    }, [filters]);

    // Handle cascading dropdowns for filters
    useEffect(() => {
        if (filters.programType) {
            api.get('/attendance/degrees', { params: { programType: filters.programType } })
                .then(res => setDegrees(res.data))
                .catch(err => console.error(err));
        } else {
            setDegrees([]);
        }
    }, [filters.programType]);

    useEffect(() => {
        if (filters.degreeId) {
            api.get('/attendance/specializations', { params: { degreeId: filters.degreeId } })
                .then(res => setSpecializations(res.data))
                .catch(err => console.error(err));
        } else {
            setSpecializations([]);
        }
    }, [filters.degreeId]);

    const handleFilterChange = (e) => {
        const { name, value } = e.target;
        setFilters(prev => {
            const updated = { ...prev, [name]: value };
            if (name === 'programType') { updated.degreeId = ''; updated.specializationId = ''; }
            if (name === 'degreeId') { updated.specializationId = ''; }
            return updated;
        });
    };

    const resetFilters = () => {
        setFilters({
            programType: '',
            degreeId: '',
            specializationId: '',
            year: '',
            semester: '',
            startDate: '',
            endDate: ''
        });
    };

    return (
        <div className="animate-fade-in">
            <h3 style={{ fontSize: '1.25rem', marginBottom: '1.5rem' }}>Attendance History</h3>

            <div className="glass-card" style={{ padding: '1.5rem', marginBottom: '2rem' }}>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(150px, 1fr))', gap: '1rem' }}>
                    <div>
                        <label className="form-label" style={{ fontSize: '0.7rem' }}>Program</label>
                        <select name="programType" className="form-control" value={filters.programType} onChange={handleFilterChange}>
                            <option value="">All</option>
                            <option value="UG">UG</option>
                            <option value="PG">PG</option>
                        </select>
                    </div>
                    <div>
                        <label className="form-label" style={{ fontSize: '0.7rem' }}>Degree</label>
                        <select name="degreeId" className="form-control" value={filters.degreeId} onChange={handleFilterChange} disabled={!filters.programType}>
                            <option value="">All</option>
                            {degrees.map(d => <option key={d.id} value={d.id}>{d.name}</option>)}
                        </select>
                    </div>
                    <div>
                        <label className="form-label" style={{ fontSize: '0.7rem' }}>Sub-Dept</label>
                        <select name="specializationId" className="form-control" value={filters.specializationId} onChange={handleFilterChange} disabled={!filters.degreeId}>
                            <option value="">All</option>
                            {specializations.map(s => <option key={s.id} value={s.id}>{s.name}</option>)}
                        </select>
                    </div>
                    <div>
                        <label className="form-label" style={{ fontSize: '0.7rem' }}>Year</label>
                        <select name="year" className="form-control" value={filters.year} onChange={handleFilterChange}>
                            <option value="">All</option>
                            {[1, 2, 3, 4].map(y => <option key={y} value={y}>Y{y}</option>)}
                        </select>
                    </div>
                    <div>
                        <label className="form-label" style={{ fontSize: '0.7rem' }}>Sem</label>
                        <select name="semester" className="form-control" value={filters.semester} onChange={handleFilterChange}>
                            <option value="">All</option>
                            {[1, 2, 3, 4, 5, 6, 7, 8].map(s => <option key={s} value={s}>S{s}</option>)}
                        </select>
                    </div>
                    <div>
                        <label className="form-label" style={{ fontSize: '0.7rem' }}>Start Date</label>
                        <input type="date" name="startDate" className="form-control" value={filters.startDate} onChange={handleFilterChange} />
                    </div>
                    <div>
                        <label className="form-label" style={{ fontSize: '0.7rem' }}>End Date</label>
                        <input type="date" name="endDate" className="form-control" value={filters.endDate} onChange={handleFilterChange} />
                    </div>
                    <div style={{ display: 'flex', alignItems: 'flex-end' }}>
                        <button className="btn btn-secondary" style={{ width: '100%', fontSize: '0.8rem' }} onClick={resetFilters}>Reset</button>
                    </div>
                </div>
            </div>

            {loading ? (
                <div className="text-center p-xl">Loading history...</div>
            ) : history.length > 0 ? (
                <div className="glass-card" style={{ padding: '0', overflow: 'hidden' }}>
                    <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead style={{ background: '#f8fafc', borderBottom: '1px solid var(--border)' }}>
                            <tr>
                                <th style={{ padding: '1rem', textAlign: 'left' }}>Date & Target</th>
                                <th style={{ padding: '1rem', textAlign: 'center' }}>Hour</th>
                                <th style={{ padding: '1rem', textAlign: 'center' }}>Students (P/A/T)</th>
                                <th style={{ padding: '1rem', textAlign: 'left' }}>Marked By</th>
                                <th style={{ padding: '1rem', textAlign: 'center' }}>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            {history.map(item => (
                                <tr key={item.id} style={{ borderBottom: '1px solid var(--border)' }}>
                                    <td style={{ padding: '1rem' }}>
                                        <div style={{ fontWeight: '700', fontSize: '0.85rem' }}>{item.date}</div>
                                        <div style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                                            {item.programType} | {item.degree} | {item.specialization?.name} (Y{item.year}/S{item.semester})
                                        </div>
                                    </td>
                                    <td style={{ padding: '1rem', textAlign: 'center' }}>
                                        <div style={{ width: '28px', height: '28px', borderRadius: '50%', background: 'var(--primary)', color: 'white', display: 'flex', alignItems: 'center', justifyContent: 'center', margin: '0 auto', fontSize: '0.8rem', fontWeight: '700' }}>
                                            {item.hour}
                                        </div>
                                    </td>
                                    <td style={{ padding: '1rem', textAlign: 'center' }}>
                                        <div style={{ display: 'flex', justifyContent: 'center', gap: '0.5rem' }}>
                                            <span style={{ color: '#059669', fontWeight: '700' }}>{item.presentCount}</span>
                                            <span>/</span>
                                            <span style={{ color: '#dc2626', fontWeight: '700' }}>{item.absentCount}</span>
                                            <span>/</span>
                                            <span style={{ fontWeight: '700' }}>{item.totalStudents}</span>
                                        </div>
                                        <div style={{ fontSize: '0.65rem', color: 'var(--text-muted)' }}>PRESENT / ABSENT / TOTAL</div>
                                    </td>
                                    <td style={{ padding: '1rem', fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                                        <div>{item.markedBy}</div>
                                        <div>{new Date(item.submittedAt).toLocaleString('en-IN', { hour: '2-digit', minute: '2-digit', day: '2-digit', month: 'short' })}</div>
                                    </td>
                                    <td style={{ padding: '1rem', textAlign: 'center' }}>
                                        <span style={{ padding: '0.2rem 0.4rem', borderRadius: '4px', background: '#dcfce7', color: '#166534', fontSize: '0.65rem', fontWeight: '800' }}>
                                            LOCKED
                                        </span>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            ) : (
                <div className="glass-card" style={{ padding: '3rem', textAlign: 'center', color: 'var(--text-muted)' }}>
                    No attendance records found for the selected filters.
                </div>
            )}
        </div>
    );
};

export default AttendanceHistory;
