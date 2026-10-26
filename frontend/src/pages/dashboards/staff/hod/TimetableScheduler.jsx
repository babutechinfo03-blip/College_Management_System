import React, { useState, useEffect, useCallback } from 'react';
import api from '../../../../services/api';

const DAYS = ['MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY'];
const HOURS = [1, 2, 3, 4, 5, 6, 7, 8];
const SEM_MAP = { 1: [1, 2], 2: [3, 4], 3: [5, 6], 4: [7, 8] };

const DAY_SHORT = { MONDAY: 'Mon', TUESDAY: 'Tue', WEDNESDAY: 'Wed', THURSDAY: 'Thu', FRIDAY: 'Fri', SATURDAY: 'Sat' };

const COLORS = [
    '#dbeafe', '#dcfce7', '#fef3c7', '#fce7f3', '#ede9fe', '#ffedd5', '#e0f2fe', '#f0fdf4',
];

const TimetableScheduler = () => {
    const [profile, setProfile] = useState(null);
    const [allFaculty, setAllFaculty] = useState([]);
    const [sections, setSections] = useState([]);
    const [timetable, setTimetable] = useState([]);
    const [assignments, setAssignments] = useState([]);
    const [loading, setLoading] = useState(false);
    const [toast, setToast] = useState(null);

    // Filter selectors
    const [selectedYear, setSelectedYear] = useState(1);
    const [selectedSemester, setSelectedSemester] = useState(1);
    const [selectedSection, setSelectedSection] = useState('');

    // Modal
    const [modal, setModal] = useState(null); // {day, hour, existing}
    const [form, setForm] = useState({ subjectName: '', subjectCode: '', facultyId: '', type: 'LECTURE' });
    const [saving, setSaving] = useState(false);
    const [clashInfo, setClashInfo] = useState(null);

    const showToast = (msg, ok = true) => {
        setToast({ msg, ok });
        setTimeout(() => setToast(null), 3000);
    };

    // Load meta on mount
    useEffect(() => {
        const init = async () => {
            try {
                const [profRes, facRes] = await Promise.all([
                    api.get('/staff/dashboard?activeRole=HOD'),
                    api.get('/hod/faculty/all'),
                ]);
                setProfile(profRes.data.profile);
                setAllFaculty(facRes.data);
            } catch (err) {
                console.error('Init failed', err);
            }
        };
        init();
    }, []);

    // Load sections when year changes
    useEffect(() => {
        const fetchSections = async () => {
            try {
                const res = await api.get(`/hod/sections?year=${selectedYear}`);
                setSections(res.data);
                if (res.data.length > 0) setSelectedSection(String(res.data[0].id));
                else setSelectedSection('');
            } catch (e) { console.error(e); }
        };
        fetchSections();
        // Auto-compute semester from year (odd/even default)
        setSelectedSemester(selectedYear * 2 - 1);
    }, [selectedYear]);

    // Load timetable when section changes
    const fetchTimetable = useCallback(async () => {
        if (!profile?.departmentId || !selectedSection) return;
        setLoading(true);
        try {
            const res = await api.get(
                `/hod/timetable?departmentId=${profile.departmentId}&year=${selectedYear}&sectionId=${selectedSection}`
            );
            setTimetable(res.data);
        } catch (e) { console.error(e); }
        finally { setLoading(false); }
    }, [profile, selectedYear, selectedSection]);

    // Also load assignments for subject dropdown in modal
    const fetchAssignments = useCallback(async () => {
        try {
            const res = await api.get('/hod/assignments');
            setAssignments(res.data);
        } catch (e) { console.error(e); }
    }, []);

    useEffect(() => {
        fetchTimetable();
        fetchAssignments();
    }, [fetchTimetable, fetchAssignments]);

    const getCell = (day, hour) => timetable.find(t => t.dayOfWeek === day && t.hour === hour);

    const handleCellClick = (day, hour) => {
        const existing = getCell(day, hour);
        setModal({ day, hour, existing });
        if (existing) {
            setForm({
                subjectName: existing.subjectName,
                subjectCode: existing.subjectCode,
                facultyId: String(existing.facultyId || ''),
                type: existing.type || 'LECTURE',
            });
        } else {
            setForm({ subjectName: '', subjectCode: '', facultyId: '', type: 'LECTURE' });
        }
        setClashInfo(null);
    };

    const handleSave = async () => {
        if (!form.subjectName.trim() || !form.subjectCode.trim() || !form.facultyId) {
            showToast('Fill all fields', false);
            return;
        }
        setSaving(true);
        setClashInfo(null);
        try {
            await api.post('/hod/timetable/entry', {
                departmentId: Number(profile.departmentId),
                year: Number(selectedYear),
                semester: Number(selectedSemester),
                sectionId: Number(selectedSection),
                dayOfWeek: modal.day,
                hour: Number(modal.hour),
                subjectName: form.subjectName.trim(),
                subjectCode: form.subjectCode.trim().toUpperCase(),
                facultyId: Number(form.facultyId),
                type: form.type,
            });
            setModal(null);
            await fetchTimetable();
            showToast('Period assigned ✓');
        } catch (err) {
            const errMsg = err.response?.data?.error || err.message;
            if (err.response?.status === 409) setClashInfo(errMsg);
            else showToast('Error: ' + errMsg, false);
        } finally { setSaving(false); }
    };

    const handleDelete = async (entryId) => {
        if (!window.confirm('Remove this period?')) return;
        try {
            await api.delete(`/hod/timetable/entry/${entryId}`);
            setModal(null);
            await fetchTimetable();
            showToast('Period removed');
        } catch (err) { showToast('Delete failed', false); }
    };

    // Get assignments for current year/semester filter to populate subject dropdown (ONLY APPROVED ONES)
    const relevantAssignments = assignments.filter(a =>
        Number(a.year) === Number(selectedYear) &&
        Number(a.semester) === Number(selectedSemester) &&
        (!a.status || a.status === 'APPROVED')
    );

    const applyAssignmentToForm = (a) => {
        setForm(f => ({ ...f, subjectName: a.subjectName, subjectCode: a.subjectCode }));
    };

    // Group dept-wise for faculty dropdown
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

    // Workload color per faculty across this timetable
    const subjectColors = {};
    timetable.forEach((e, i) => {
        if (!subjectColors[e.subjectCode]) subjectColors[e.subjectCode] = COLORS[Object.keys(subjectColors).length % COLORS.length];
    });

    return (
        <div className="animate-fade-in" style={{ padding: '0.5rem' }}>

            {/* Toast */}
            {toast && (
                <div style={{
                    position: 'fixed', top: '1.5rem', right: '1.5rem', zIndex: 9999,
                    background: toast.ok ? '#22c55e' : '#ef4444',
                    color: '#fff', padding: '0.75rem 1.5rem', borderRadius: '8px',
                    fontWeight: 600, boxShadow: '0 4px 20px rgba(0,0,0,0.2)',
                    animation: 'fadeIn 0.2s'
                }}>{toast.msg}</div>
            )}

            {/* Header */}
            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '1.5rem' }}>
                <div>
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 800, color: 'var(--text-main)', margin: 0 }}>
                        📅 Timetable Scheduler
                    </h2>
                    <p style={{ color: 'var(--text-secondary)', margin: '0.25rem 0 0', fontSize: '0.875rem' }}>
                        {profile?.department} — Click any cell to assign a period
                    </p>
                </div>
                <button className="btn btn-outline" onClick={fetchTimetable} style={{ fontSize: '0.85rem' }}>
                    ↻ Refresh
                </button>
            </div>

            {/* Selectors */}
            <div className="glass-card" style={{ padding: '1.25rem', marginBottom: '1.5rem', display: 'flex', gap: '1rem', flexWrap: 'wrap', alignItems: 'flex-end' }}>
                <div className="form-group" style={{ margin: 0, minWidth: '120px' }}>
                    <label className="form-label" style={{ fontSize: '0.75rem', fontWeight: 700 }}>YEAR</label>
                    <select className="form-control" value={selectedYear} onChange={e => setSelectedYear(Number(e.target.value))}>
                        {[1, 2, 3, 4].map(y => <option key={y} value={y}>Year {y}</option>)}
                    </select>
                </div>
                <div className="form-group" style={{ margin: 0, minWidth: '140px' }}>
                    <label className="form-label" style={{ fontSize: '0.75rem', fontWeight: 700 }}>SEMESTER</label>
                    <select className="form-control" value={selectedSemester} onChange={e => setSelectedSemester(Number(e.target.value))}>
                        {(SEM_MAP[selectedYear] || []).map(s => <option key={s} value={s}>Semester {s}</option>)}
                    </select>
                </div>
                <div className="form-group" style={{ margin: 0, minWidth: '140px' }}>
                    <label className="form-label" style={{ fontSize: '0.75rem', fontWeight: 700 }}>SECTION</label>
                    <select className="form-control" value={selectedSection} onChange={e => setSelectedSection(e.target.value)}>
                        <option value="">Select</option>
                        {sections.map(s => <option key={s.id} value={String(s.id)}>Section {s.name}</option>)}
                    </select>
                </div>
                <div style={{ marginLeft: 'auto', fontSize: '0.8rem', color: 'var(--text-secondary)', alignSelf: 'center' }}>
                    {loading ? '⏳ Loading...' : `${timetable.length} periods assigned`}
                </div>
            </div>

            {/* Timetable Grid */}
            <div className="glass-card" style={{ padding: '1rem', overflowX: 'auto', marginBottom: '2rem' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', minWidth: '700px' }}>
                    <thead>
                        <tr>
                            <th style={{ padding: '0.75rem 1rem', background: 'var(--bg-secondary,#f1f5f9)', textAlign: 'left', borderRadius: '6px 0 0 0', fontSize: '0.8rem', fontWeight: 700, color: 'var(--text-secondary)' }}>
                                DAY / PERIOD
                            </th>
                            {HOURS.map(h => (
                                <th key={h} style={{ padding: '0.75rem', background: 'var(--bg-secondary,#f1f5f9)', textAlign: 'center', fontSize: '0.8rem', fontWeight: 700, color: 'var(--text-secondary)', minWidth: '90px' }}>
                                    {h <= 4 ? `P${h}` : h === 5 ? '🍽 Break' : `P${h - 1}`}
                                </th>
                            ))}
                        </tr>
                    </thead>
                    <tbody>
                        {DAYS.map((day, di) => (
                            <tr key={day} style={{ borderBottom: '1px solid var(--border,#e2e8f0)' }}>
                                <td style={{ padding: '0.75rem 1rem', fontWeight: 700, fontSize: '0.85rem', color: 'var(--text-main)', background: di % 2 === 0 ? 'transparent' : 'var(--bg-secondary,#f8fafc)' }}>
                                    {DAY_SHORT[day]}
                                </td>
                                {HOURS.map(h => {
                                    const entry = getCell(day, h);
                                    const isBreak = h === 5;
                                    return (
                                        <td key={h}
                                            onClick={() => !isBreak && handleCellClick(day, h)}
                                            style={{
                                                padding: '0.4rem',
                                                borderLeft: '1px solid var(--border,#e2e8f0)',
                                                cursor: isBreak ? 'default' : 'pointer',
                                                background: isBreak
                                                    ? '#f1f5f9'
                                                    : entry
                                                        ? (subjectColors[entry.subjectCode] || '#dbeafe')
                                                        : 'transparent',
                                                textAlign: 'center',
                                                fontSize: '0.78rem',
                                                transition: 'background 0.15s',
                                                verticalAlign: 'middle',
                                            }}
                                        >
                                            {isBreak ? (
                                                <span style={{ color: '#94a3b8', fontSize: '0.72rem' }}>Lunch</span>
                                            ) : entry ? (
                                                <div>
                                                    <div style={{ fontWeight: 800, color: '#1e40af', fontSize: '0.78rem', lineHeight: 1.2 }}>{entry.subjectCode}</div>
                                                    <div style={{ fontSize: '0.68rem', color: '#334155', marginTop: '2px', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', maxWidth: '88px' }}>
                                                        {entry.facultyName?.split(' ')[0]}
                                                    </div>
                                                </div>
                                            ) : (
                                                <span style={{ color: '#cbd5e1', fontSize: '1.1rem', lineHeight: 1 }}>+</span>
                                            )}
                                        </td>
                                    );
                                })}
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>

            {/* Legend */}
            {Object.keys(subjectColors).length > 0 && (
                <div style={{ display: 'flex', gap: '0.75rem', flexWrap: 'wrap', marginBottom: '1rem' }}>
                    {Object.entries(subjectColors).map(([code, color]) => {
                        const entry = timetable.find(t => t.subjectCode === code);
                        return (
                            <div key={code} style={{ display: 'flex', alignItems: 'center', gap: '0.4rem', fontSize: '0.78rem', fontWeight: 600 }}>
                                <div style={{ width: '14px', height: '14px', background: color, borderRadius: '3px', border: '1px solid rgba(0,0,0,0.1)' }} />
                                <span>{code}</span>
                                <span style={{ color: 'var(--text-secondary)', fontWeight: 400 }}>— {entry?.subjectName}</span>
                            </div>
                        );
                    })}
                </div>
            )}

            {/* Modal */}
            {modal && (
                <div style={{ position: 'fixed', inset: 0, background: 'rgba(0,0,0,0.45)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000, padding: '1rem' }}
                    onClick={e => e.target === e.currentTarget && setModal(null)}>
                    <div className="glass-card" style={{ width: '100%', maxWidth: '480px', background: 'var(--card-bg,#fff)', borderRadius: '16px', padding: '2rem', boxShadow: '0 20px 60px rgba(0,0,0,0.2)' }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
                            <div>
                                <h3 style={{ margin: 0, fontSize: '1.1rem', fontWeight: 800 }}>
                                    {DAY_SHORT[modal.day]} — Period {modal.hour}
                                </h3>
                                <p style={{ margin: '0.2rem 0 0', fontSize: '0.8rem', color: 'var(--text-secondary)' }}>
                                    Year {selectedYear} · Sem {selectedSemester} · {sections.find(s => String(s.id) === selectedSection)?.name || ''}
                                </p>
                            </div>
                            <button onClick={() => setModal(null)} style={{ background: 'none', border: 'none', fontSize: '1.5rem', cursor: 'pointer', color: 'var(--text-secondary)' }}>✕</button>
                        </div>

                        {/* Clash warning */}
                        {clashInfo && (
                            <div style={{ background: '#fef2f2', border: '1px solid #fca5a5', borderRadius: '8px', padding: '0.75rem', marginBottom: '1rem', color: '#b91c1c', fontSize: '0.85rem', fontWeight: 600 }}>
                                ⚠️ {clashInfo}
                            </div>
                        )}

                        {/* Quick fill from assignments */}
                        {relevantAssignments.length > 0 && (
                            <div style={{ marginBottom: '1rem' }}>
                                <label className="form-label" style={{ fontSize: '0.72rem' }}>QUICK FILL FROM ASSIGNMENTS</label>
                                <div style={{ display: 'flex', gap: '0.5rem', flexWrap: 'wrap' }}>
                                    {relevantAssignments.map(a => (
                                        <button key={a.id}
                                            onClick={() => applyAssignmentToForm(a)}
                                            style={{
                                                padding: '0.3rem 0.65rem', fontSize: '0.75rem',
                                                background: '#eff6ff', border: '1px solid #bfdbfe',
                                                borderRadius: '6px', cursor: 'pointer', color: '#1d4ed8', fontWeight: 600
                                            }}>
                                            {a.subjectCode}
                                        </button>
                                    ))}
                                </div>
                            </div>
                        )}

                        <div className="form-group">
                            <label className="form-label" style={{ fontSize: '0.75rem' }}>SUBJECT NAME *</label>
                            <input className="form-control" placeholder="e.g. Data Structures"
                                value={form.subjectName}
                                onChange={e => setForm(f => ({ ...f, subjectName: e.target.value }))} />
                        </div>
                        <div className="form-group">
                            <label className="form-label" style={{ fontSize: '0.75rem' }}>SUBJECT CODE *</label>
                            <input className="form-control" placeholder="e.g. CS301"
                                value={form.subjectCode}
                                onChange={e => setForm(f => ({ ...f, subjectCode: e.target.value }))} />
                        </div>
                        <div className="form-group">
                            <label className="form-label" style={{ fontSize: '0.75rem', fontWeight: 700 }}>FACULTY (ANY DEPT) *</label>
                            <select className="form-control" value={form.facultyId} onChange={e => setForm(f => ({ ...f, facultyId: e.target.value }))} style={{ color: '#1e293b', fontWeight: 600 }}>
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
                        <div className="form-group">
                            <label className="form-label" style={{ fontSize: '0.75rem' }}>TYPE</label>
                            <select className="form-control" value={form.type} onChange={e => setForm(f => ({ ...f, type: e.target.value }))}>
                                <option value="LECTURE">Lecture</option>
                                <option value="LAB">Lab</option>
                                <option value="TUTORIAL">Tutorial</option>
                            </select>
                        </div>

                        <div style={{ display: 'flex', gap: '0.75rem', marginTop: '1.5rem' }}>
                            <button className="btn btn-primary" onClick={handleSave} disabled={saving} style={{ flex: 1, fontWeight: 700 }}>
                                {saving ? '⏳ Saving...' : '✓ Assign Period'}
                            </button>
                            {modal.existing && (
                                <button className="btn btn-outline" onClick={() => handleDelete(modal.existing.id)}
                                    style={{ color: '#ef4444', borderColor: '#ef4444', padding: '0 1rem' }}>
                                    🗑
                                </button>
                            )}
                            <button className="btn btn-secondary" onClick={() => setModal(null)}>Cancel</button>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
};

export default TimetableScheduler;
