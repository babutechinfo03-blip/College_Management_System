import React, { useState, useEffect, useCallback } from 'react';
import api from '../../../../services/api';

const SEM_MAP = { 1: [1, 2], 2: [3, 4], 3: [5, 6], 4: [7, 8] };

const SubjectManager = () => {
    const [activeTab, setActiveTab] = useState('ASSIGN'); // ASSIGN or APPROVALS

    const [profile, setProfile] = useState(null);
    const [allFaculty, setAllFaculty] = useState([]);
    const [sections, setSections] = useState([]);

    const [assignments, setAssignments] = useState([]);
    const [pendingRequests, setPendingRequests] = useState([]);

    const [loading, setLoading] = useState(false);
    const [toast, setToast] = useState(null);

    const [form, setForm] = useState({
        year: 1, semester: 1, sectionId: '',
        subjectName: '', subjectCode: '', facultyId: ''
    });
    const [filter, setFilter] = useState({ year: '', query: '' });

    const showToast = (msg, ok = true) => {
        setToast({ msg, ok });
        setTimeout(() => setToast(null), 3000);
    };

    // Init All Data
    useEffect(() => {
        const init = async () => {
            try {
                const [profRes, facRes] = await Promise.all([
                    api.get('/staff/dashboard?activeRole=HOD'),
                    api.get('/hod/faculty/all'),
                ]);
                setProfile(profRes.data.profile);
                const dept = profRes.data.profile;
                setForm(f => ({ ...f, departmentId: dept.departmentId }));
                setAllFaculty(facRes.data);
            } catch (err) { console.error(err); }
        };
        init();
        loadAssignments();
        loadPendingRequests();
    }, []);

    // Load sections when year changes
    useEffect(() => {
        const fetchSections = async () => {
            try {
                const res = await api.get(`/hod/sections?year=${form.year}`);
                setSections(res.data);
                if (res.data.length > 0) setForm(f => ({ ...f, sectionId: String(res.data[0].id) }));
                else setForm(f => ({ ...f, sectionId: '' }));
            } catch (e) { console.error(e); }
        };
        fetchSections();
        setForm(f => ({ ...f, semester: SEM_MAP[form.year]?.[0] || 1 }));
    }, [form.year]);

    const loadAssignments = useCallback(async () => {
        try {
            const res = await api.get('/hod/assignments');
            setAssignments(res.data);
        } catch (e) { console.error(e); }
    }, []);

    const loadPendingRequests = useCallback(async () => {
        try {
            const res = await api.get('/hod/cross-dept-requests');
            setPendingRequests(res.data);
        } catch (e) { console.error(e); }
    }, []);

    // Form Submit (Assign Subject)
    const handleSubmit = async (e) => {
        e.preventDefault();
        if (!form.subjectName.trim() || !form.subjectCode.trim() || !form.facultyId) {
            showToast('Please fill all required fields', false);
            return;
        }
        setLoading(true);
        try {
            const res = await api.post('/hod/assign-subject', {
                departmentId: Number(profile?.departmentId),
                year: Number(form.year),
                semester: Number(form.semester),
                sectionId: form.sectionId ? Number(form.sectionId) : null,
                subjectName: form.subjectName.trim(),
                subjectCode: form.subjectCode.trim().toUpperCase(),
                facultyId: Number(form.facultyId),
            });
            showToast(res.data.message || 'Subject assigned successfully ✓');
            setForm(f => ({ ...f, subjectName: '', subjectCode: '', facultyId: '' }));
            await loadAssignments();
        } catch (err) {
            showToast('Failed: ' + (err.response?.data?.error || err.message), false);
        } finally { setLoading(false); }
    };

    const handleDelete = async (id) => {
        if (!window.confirm('Remove this assignment?')) return;
        try {
            await api.delete(`/hod/assignments/${id}`);
            showToast('Assignment removed');
            await loadAssignments();
        } catch (err) { showToast('Failed to delete', false); }
    };

    // Handle Approvals
    const handleApproval = async (id, approve) => {
        try {
            const res = await api.post(`/hod/assignments/${id}/approve`, { approve });
            showToast(res.data.message);
            await loadPendingRequests();
        } catch (err) {
            showToast('Failed to process: ' + (err.response?.data?.error || err.message), false);
        }
    };

    // Group dept-wise for faculty dropdown
    // HOD's dept first, then alphabetized
    const myDept = profile?.departmentCode || profile?.department || '';
    const groupedFacs = allFaculty.reduce((acc, f) => {
        const dept = f.department || 'Other';
        if (!acc[dept]) acc[dept] = [];
        acc[dept].push(f);
        return acc;
    }, {});

    const sortedDepts = Object.keys(groupedFacs).sort((a, b) => {
        if (a === myDept) return -1;
        if (b === myDept) return 1;
        return a.localeCompare(b);
    });

    // Filter displayed assignments
    const filtered = assignments.filter(a => {
        const yearOk = !filter.year || String(a.year) === String(filter.year);
        const q = filter.query.toLowerCase();
        const queryOk = !q ||
            (a.subjectName || '').toLowerCase().includes(q) ||
            (a.subjectCode || '').toLowerCase().includes(q) ||
            (a.facultyName || '').toLowerCase().includes(q);
        return yearOk && queryOk;
    });

    const getStatusStyle = (status) => {
        if (status === 'APPROVED') return { bg: '#f0fdf4', color: '#15803d' };
        if (status === 'PENDING') return { bg: '#fff7ed', color: '#c2410c' };
        if (status === 'REJECTED') return { bg: '#fef2f2', color: '#b91c1c' };
        return { bg: '#f1f5f9', color: '#475569' };
    };

    return (
        <div className="animate-fade-in" style={{ padding: '0.5rem' }}>

            {/* Toast */}
            {toast && (
                <div style={{
                    position: 'fixed', top: '1.5rem', right: '1.5rem', zIndex: 9999,
                    background: toast.ok ? '#22c55e' : '#ef4444',
                    color: '#fff', padding: '0.75rem 1.5rem', borderRadius: '8px',
                    fontWeight: 600, boxShadow: '0 4px 20px rgba(0,0,0,0.2)',
                }}>
                    {toast.msg}
                </div>
            )}

            {/* Header & Tabs */}
            <div style={{ marginBottom: '1.5rem', borderBottom: '1px solid var(--border,#e2e8f0)', paddingBottom: '1rem', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end' }}>
                <div>
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 800, color: 'var(--text-main)', margin: 0 }}>
                        📚 Subject Allocation Manager
                    </h2>
                    <p style={{ color: 'var(--text-secondary)', margin: '0.25rem 0 0', fontSize: '0.875rem' }}>
                        {profile?.department} — Manage subjects and cross-department assignments
                    </p>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '1rem', marginBottom: '2rem' }}>
                <button
                    onClick={() => setActiveTab('ASSIGN')}
                    style={{
                        padding: '0.75rem 1.5rem', fontSize: '0.9rem', fontWeight: 700, borderRadius: '8px',
                        background: activeTab === 'ASSIGN' ? 'var(--primary)' : 'transparent',
                        color: activeTab === 'ASSIGN' ? '#fff' : 'var(--text-secondary)',
                        border: activeTab === 'ASSIGN' ? 'none' : '1px solid var(--border)',
                        cursor: 'pointer', transition: 'all 0.2s'
                    }}>
                    Assign Subjects
                </button>
                <button
                    onClick={() => setActiveTab('APPROVALS')}
                    style={{
                        padding: '0.75rem 1.5rem', fontSize: '0.9rem', fontWeight: 700, borderRadius: '8px',
                        background: activeTab === 'APPROVALS' ? 'var(--secondary-color, #f43f5e)' : 'transparent',
                        color: activeTab === 'APPROVALS' ? '#fff' : 'var(--text-secondary)',
                        border: activeTab === 'APPROVALS' ? 'none' : '1px solid var(--border)',
                        cursor: 'pointer', transition: 'all 0.2s', display: 'flex', alignItems: 'center', gap: '0.5rem'
                    }}>
                    Cross-Dept Requests
                    {pendingRequests.length > 0 && (
                        <span style={{ background: '#fff', color: 'var(--secondary-color, #f43f5e)', padding: '2px 8px', borderRadius: '12px', fontSize: '0.75rem' }}>
                            {pendingRequests.length}
                        </span>
                    )}
                </button>
            </div>

            {activeTab === 'ASSIGN' && (
                <>
                    {/* Assignment Form */}
                    <div className="glass-card" style={{ padding: '1.75rem', marginBottom: '2rem' }}>
                        <h3 style={{ margin: '0 0 1.5rem', fontSize: '1rem', fontWeight: 700, color: 'var(--text-main)' }}>
                            + New Subject Assignment
                        </h3>
                        <form onSubmit={handleSubmit}>
                            {/* Row 1: Year / Semester / Section */}
                            <div className="grid" style={{ gridTemplateColumns: '1fr 1fr 1fr', gap: '1rem', marginBottom: '1rem' }}>
                                <div className="form-group" style={{ margin: 0 }}>
                                    <label className="form-label" style={{ fontSize: '0.75rem', fontWeight: 700 }}>YEAR *</label>
                                    <select className="form-control"
                                        value={form.year}
                                        onChange={e => setForm(f => ({ ...f, year: Number(e.target.value) }))}>
                                        {[1, 2, 3, 4].map(y => <option key={y} value={y}>Year {y}</option>)}
                                    </select>
                                </div>
                                <div className="form-group" style={{ margin: 0 }}>
                                    <label className="form-label" style={{ fontSize: '0.75rem', fontWeight: 700 }}>SEMESTER *</label>
                                    <select className="form-control"
                                        value={form.semester}
                                        onChange={e => setForm(f => ({ ...f, semester: Number(e.target.value) }))}>
                                        {(SEM_MAP[form.year] || []).map(s => <option key={s} value={s}>Semester {s}</option>)}
                                    </select>
                                </div>
                                <div className="form-group" style={{ margin: 0 }}>
                                    <label className="form-label" style={{ fontSize: '0.75rem', fontWeight: 700 }}>SECTION</label>
                                    <select className="form-control"
                                        value={form.sectionId}
                                        onChange={e => setForm(f => ({ ...f, sectionId: e.target.value }))}>
                                        <option value="">All Sections</option>
                                        {sections.map(s => <option key={s.id} value={String(s.id)}>Section {s.name}</option>)}
                                    </select>
                                </div>
                            </div>

                            {/* Row 2: Subject Name / Subject Code */}
                            <div className="grid" style={{ gridTemplateColumns: '1fr 1fr', gap: '1rem', marginBottom: '1rem' }}>
                                <div className="form-group" style={{ margin: 0 }}>
                                    <label className="form-label" style={{ fontSize: '0.75rem', fontWeight: 700 }}>SUBJECT NAME *</label>
                                    <input className="form-control"
                                        placeholder="e.g. Data Structures"
                                        value={form.subjectName}
                                        onChange={e => setForm(f => ({ ...f, subjectName: e.target.value }))} />
                                </div>
                                <div className="form-group" style={{ margin: 0 }}>
                                    <label className="form-label" style={{ fontSize: '0.75rem', fontWeight: 700 }}>SUBJECT CODE *</label>
                                    <input className="form-control"
                                        placeholder="e.g. CS301"
                                        value={form.subjectCode}
                                        onChange={e => setForm(f => ({ ...f, subjectCode: e.target.value }))} />
                                </div>
                            </div>

                            {/* Row 3: Faculty picker (cross-dept, grouped) */}
                            <div className="form-group" style={{ marginBottom: '1.25rem' }}>
                                <label className="form-label" style={{ fontSize: '0.75rem', fontWeight: 700 }}>
                                    ASSIGN FACULTY * &nbsp;
                                    <span style={{ fontWeight: 400, color: 'var(--text-secondary)' }}>(Pending approval if other dept)</span>
                                </label>
                                <select className="form-control"
                                    value={form.facultyId}
                                    onChange={e => setForm(f => ({ ...f, facultyId: e.target.value }))}
                                    required
                                    style={{ color: '#1e293b', fontWeight: 600 }}>
                                    <option value="">Select Faculty...</option>
                                    {sortedDepts.map(dept => (
                                        <optgroup key={dept} label={`──────── ${dept} Department ────────`} style={{ color: '#475569', fontWeight: 700, fontStyle: 'normal' }}>
                                            {groupedFacs[dept].sort((a, b) => a.firstName.localeCompare(b.firstName)).map(f => (
                                                <option key={f.id} value={String(f.id)} style={{ color: '#0f172a', fontWeight: 500 }}>
                                                    • {f.name || `${f.firstName} ${f.lastName}`} ({f.designation})
                                                </option>
                                            ))}
                                        </optgroup>
                                    ))}
                                </select>
                            </div>

                            <button type="submit" className="btn btn-primary" disabled={loading}
                                style={{ width: '100%', padding: '0.875rem', fontWeight: 700, fontSize: '1rem' }}>
                                {loading ? '⏳ Assigning...' : '✓ Assign Subject'}
                            </button>
                        </form>
                    </div>

                    {/* Assignments List */}
                    <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '1rem', flexWrap: 'wrap', gap: '0.75rem' }}>
                        <h3 style={{ margin: 0, fontSize: '1.1rem', fontWeight: 700 }}>
                            Current Assignments
                            <span style={{ marginLeft: '0.5rem', background: 'var(--primary,#3b82f6)', color: '#fff', borderRadius: '50px', padding: '2px 10px', fontSize: '0.78rem', fontWeight: 700 }}>
                                {filtered.length}
                            </span>
                        </h3>
                        <div style={{ display: 'flex', gap: '0.75rem', alignItems: 'center' }}>
                            <select className="form-control" style={{ width: 'auto', fontSize: '0.85rem', padding: '0.4rem 0.75rem' }}
                                value={filter.year}
                                onChange={e => setFilter(f => ({ ...f, year: e.target.value }))}>
                                <option value="">All Years</option>
                                {[1, 2, 3, 4].map(y => <option key={y} value={y}>Year {y}</option>)}
                            </select>
                            <input className="form-control" style={{ width: '200px', fontSize: '0.85rem', padding: '0.4rem 0.75rem' }}
                                placeholder="Search subject / faculty..."
                                value={filter.query}
                                onChange={e => setFilter(f => ({ ...f, query: e.target.value }))} />
                        </div>
                    </div>

                    <div className="glass-card" style={{ padding: 0, overflow: 'hidden' }}>
                        <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                            <thead>
                                <tr style={{ background: 'var(--bg-secondary,#f8fafc)' }}>
                                    <th style={{ padding: '0.875rem 1rem', textAlign: 'left', fontSize: '0.78rem', fontWeight: 700, color: 'var(--text-secondary)', textTransform: 'uppercase' }}>Subject</th>
                                    <th style={{ padding: '0.875rem 1rem', textAlign: 'left', fontSize: '0.78rem', fontWeight: 700, color: 'var(--text-secondary)', textTransform: 'uppercase' }}>Class</th>
                                    <th style={{ padding: '0.875rem 1rem', textAlign: 'left', fontSize: '0.78rem', fontWeight: 700, color: 'var(--text-secondary)', textTransform: 'uppercase' }}>Faculty</th>
                                    <th style={{ padding: '0.875rem 1rem', textAlign: 'center', fontSize: '0.78rem', fontWeight: 700, color: 'var(--text-secondary)', textTransform: 'uppercase' }}>Status</th>
                                    <th style={{ padding: '0.875rem 1rem', textAlign: 'center', fontSize: '0.78rem', fontWeight: 700, color: 'var(--text-secondary)', textTransform: 'uppercase' }}>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                {filtered.length === 0 ? (
                                    <tr><td colSpan={5} style={{ textAlign: 'center', padding: '2rem', color: 'var(--text-secondary)' }}>
                                        No assignments found
                                    </td></tr>
                                ) : filtered.map((a, i) => {
                                    const st = getStatusStyle(a.status);
                                    return (
                                        <tr key={a.id} style={{ borderTop: '1px solid var(--border,#e2e8f0)', background: i % 2 === 0 ? 'transparent' : 'var(--bg-secondary,#f9fafb)' }}>
                                            <td style={{ padding: '0.875rem 1rem' }}>
                                                <div style={{ fontWeight: 700, fontSize: '0.875rem' }}>{a.subjectName}</div>
                                                <div style={{ fontSize: '0.75rem', color: 'var(--text-secondary)' }}>{a.subjectCode}</div>
                                            </td>
                                            <td style={{ padding: '0.875rem 1rem', fontSize: '0.875rem' }}>
                                                <span style={{ background: '#eff6ff', color: '#1d4ed8', padding: '2px 8px', borderRadius: '4px', fontWeight: 600, fontSize: '0.78rem' }}>
                                                    Y{a.year} S{a.semester}
                                                </span>
                                                {a.sectionName && a.sectionName !== 'All' && (
                                                    <span style={{ marginLeft: '4px', background: '#f0fdf4', color: '#15803d', padding: '2px 8px', borderRadius: '4px', fontWeight: 600, fontSize: '0.78rem' }}>
                                                        Sec {a.sectionName}
                                                    </span>
                                                )}
                                            </td>
                                            <td style={{ padding: '0.875rem 1rem', fontSize: '0.875rem' }}>
                                                <div style={{ fontWeight: 600 }}>{a.facultyName}</div>
                                                <div style={{ fontSize: '0.75rem', color: 'var(--text-secondary)' }}>{a.facultyDept || '-'} Dept</div>
                                            </td>
                                            <td style={{ padding: '0.875rem 1rem', textAlign: 'center' }}>
                                                <span style={{ background: st.bg, color: st.color, padding: '4px 10px', borderRadius: '20px', fontWeight: 700, fontSize: '0.75rem' }}>
                                                    {a.status}
                                                </span>
                                            </td>
                                            <td style={{ padding: '0.875rem 1rem', textAlign: 'center' }}>
                                                <button onClick={() => handleDelete(a.id)}
                                                    style={{ background: 'none', border: '1px solid #fca5a5', color: '#ef4444', padding: '4px 10px', borderRadius: '6px', cursor: 'pointer', fontSize: '0.78rem', fontWeight: 600, transition: 'all 0.15s' }}
                                                    onMouseOver={e => { e.target.style.background = '#fef2f2'; }}
                                                    onMouseOut={e => { e.target.style.background = 'none'; }}>
                                                    🗑
                                                </button>
                                            </td>
                                        </tr>
                                    );
                                })}
                            </tbody>
                        </table>
                    </div>
                </>
            )}

            {activeTab === 'APPROVALS' && (
                <div className="glass-card" style={{ padding: 0, overflow: 'hidden' }}>
                    <div style={{ padding: '1.5rem', background: '#f8fafc', borderBottom: '1px solid #e2e8f0' }}>
                        <h3 style={{ margin: 0, fontSize: '1.1rem', fontWeight: 700, color: '#0f172a' }}>
                            Incoming Requests to Your Department
                        </h3>
                        <p style={{ margin: '0.25rem 0 0', fontSize: '0.85rem', color: '#64748b' }}>
                            Other departments requesting to assign subjects to your faculty members.
                        </p>
                    </div>
                    <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead>
                            <tr style={{ background: '#fff' }}>
                                <th style={{ padding: '1rem', textAlign: 'left', fontSize: '0.78rem', fontWeight: 700, color: 'var(--text-secondary)', textTransform: 'uppercase', borderBottom: '1px solid #e2e8f0' }}>Subject & Class</th>
                                <th style={{ padding: '1rem', textAlign: 'left', fontSize: '0.78rem', fontWeight: 700, color: 'var(--text-secondary)', textTransform: 'uppercase', borderBottom: '1px solid #e2e8f0' }}>Requested Faculty</th>
                                <th style={{ padding: '1rem', textAlign: 'left', fontSize: '0.78rem', fontWeight: 700, color: 'var(--text-secondary)', textTransform: 'uppercase', borderBottom: '1px solid #e2e8f0' }}>Requested By</th>
                                <th style={{ padding: '1rem', textAlign: 'center', fontSize: '0.78rem', fontWeight: 700, color: 'var(--text-secondary)', textTransform: 'uppercase', borderBottom: '1px solid #e2e8f0' }}>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            {pendingRequests.length === 0 ? (
                                <tr><td colSpan={4} style={{ textAlign: 'center', padding: '3rem', color: '#64748b' }}>
                                    <div style={{ fontSize: '2rem', marginBottom: '0.5rem' }}>✅</div>
                                    No pending cross-department requests!
                                </td></tr>
                            ) : pendingRequests.map((a, i) => (
                                <tr key={a.id} style={{ background: i % 2 === 0 ? 'transparent' : '#f8fafc' }}>
                                    <td style={{ padding: '1rem', borderBottom: '1px solid #e2e8f0' }}>
                                        <div style={{ fontWeight: 700, fontSize: '0.9rem', color: '#0f172a' }}>{a.subjectName} <span style={{ color: '#64748b', fontWeight: 500 }}>({a.subjectCode})</span></div>
                                        <div style={{ fontSize: '0.8rem', color: '#3b82f6', fontWeight: 600, marginTop: '0.25rem' }}>{a.classInfo}</div>
                                    </td>
                                    <td style={{ padding: '1rem', borderBottom: '1px solid #e2e8f0' }}>
                                        <div style={{ fontWeight: 700, color: '#0f172a', fontSize: '0.9rem' }}>{a.facultyName}</div>
                                        <div style={{ fontSize: '0.8rem', color: '#64748b', marginTop: '0.25rem' }}>Requested Hours: {a.hours} / week</div>
                                    </td>
                                    <td style={{ padding: '1rem', borderBottom: '1px solid #e2e8f0' }}>
                                        <div style={{ fontWeight: 600, color: '#0f172a', fontSize: '0.9rem' }}>{a.requestingDept} Dept</div>
                                        <div style={{ fontSize: '0.8rem', color: '#64748b', marginTop: '0.25rem' }}>By: HOD {a.assignedBy}</div>
                                    </td>
                                    <td style={{ padding: '1rem', borderBottom: '1px solid #e2e8f0', textAlign: 'center' }}>
                                        <div style={{ display: 'flex', gap: '0.5rem', justifyContent: 'center' }}>
                                            <button onClick={() => handleApproval(a.id, true)}
                                                style={{ background: '#22c55e', color: '#fff', border: 'none', padding: '0.5rem 1rem', borderRadius: '6px', fontWeight: 700, cursor: 'pointer', transition: 'opacity 0.2s', boxShadow: '0 2px 4px rgba(34,197,94,0.2)' }}
                                                onMouseOver={e => e.target.style.opacity = 0.9} onMouseOut={e => e.target.style.opacity = 1}>
                                                Approve
                                            </button>
                                            <button onClick={() => handleApproval(a.id, false)}
                                                style={{ background: '#fff', color: '#ef4444', border: '1px solid #fca5a5', padding: '0.5rem 1rem', borderRadius: '6px', fontWeight: 700, cursor: 'pointer', transition: 'background 0.2s' }}
                                                onMouseOver={e => e.target.style.background = '#fef2f2'} onMouseOut={e => e.target.style.background = '#fff'}>
                                                Reject
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            )}
        </div>
    );
};

export default SubjectManager;
