import React, { useState, useEffect } from 'react';
import api from '../../../../services/api';

/* ─── InfoRow ─────────────────────────────────────────────── */
const InfoRow = ({ label, value }) => (
    <div style={{ marginBottom: 16 }}>
        <p style={{
            fontSize: '0.7rem', fontWeight: 700,
            textTransform: 'uppercase', letterSpacing: '0.08em',
            color: '#6B7280', marginBottom: 4,
        }}>
            {label}
        </p>
        <p style={{
            fontSize: '0.92rem', fontWeight: 600,
            color: '#111827', lineHeight: 1.4,
            wordBreak: 'break-word',
        }}>
            {value || <span style={{ color: '#9CA3AF', fontStyle: 'italic' }}>N/A</span>}
        </p>
    </div>
);

/* ─── Two-column grid of info rows ───────────────────────── */
const InfoGrid = ({ children }) => (
    <div style={{
        display: 'grid',
        gridTemplateColumns: '1fr 1fr',
        gap: '0 24px',
    }}>
        {children}
    </div>
);

/* ─── Section block ──────────────────────────────────────── */
const Section = ({ title, icon, accent = '#6366f1', children }) => (
    <div style={{ marginBottom: 20 }}>
        {/* Section header */}
        <div style={{
            display: 'flex', alignItems: 'center', gap: 8,
            marginBottom: 12, paddingBottom: 8,
            borderBottom: '1.5px solid #F3F4F6',
        }}>
            <div style={{
                width: 28, height: 28, borderRadius: 8,
                background: accent + '15',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                flexShrink: 0,
            }}>
                <svg width="14" height="14" fill="none" stroke={accent} viewBox="0 0 24 24" strokeWidth="2.2">
                    <path strokeLinecap="round" strokeLinejoin="round" d={icon} />
                </svg>
            </div>
            <span style={{
                fontSize: '0.72rem', fontWeight: 800,
                textTransform: 'uppercase', letterSpacing: '0.1em',
                color: '#1F2937',
            }}>
                {title}
            </span>
        </div>
        {children}
    </div>
);

/* ─── Performance config ─────────────────────────────────── */
const perfConfig = {
    HIGH: { bg: '#DCFCE7', color: '#166534', dot: '#16a34a', label: 'High Performer' },
    AVERAGE: { bg: '#FEF3C7', color: '#92400E', dot: '#D97706', label: 'Average' },
    AT_RISK: { bg: '#FEE2E2', color: '#991B1B', dot: '#DC2626', label: 'At Risk' },
    'N/A': { bg: '#F1F5F9', color: '#475569', dot: '#94A3B8', label: 'No Data' },
};

/* ─── Main Panel ─────────────────────────────────────────── */
const StudentDetailPanel = ({ studentId, onClose, onStatusToggled }) => {
    const [student, setStudent] = useState(null);
    const [loading, setLoading] = useState(true);
    const [toggling, setToggling] = useState(false);
    const [error, setError] = useState(null);
    const [toastMsg, setToastMsg] = useState(null);
    const [activeTab, setActiveTab] = useState('profile');

    useEffect(() => {
        const fetchDetail = async () => {
            setLoading(true); setError(null); setActiveTab('profile');
            try {
                const res = await api.get(`/hod/students/${studentId}`);
                setStudent(res.data);
            } catch {
                setError('Failed to load student details.');
            } finally {
                setLoading(false);
            }
        };
        if (studentId) fetchDetail();
    }, [studentId]);

    const handleToggle = async () => {
        setToggling(true);
        try {
            const res = await api.patch(`/hod/students/${studentId}/toggle-status`);
            setStudent(prev => ({ ...prev, active: res.data.active }));
            showToast(res.data.message);
            if (onStatusToggled) onStatusToggled(studentId, res.data.active);
        } catch { showToast('Action failed.'); }
        finally { setToggling(false); }
    };

    const showToast = (msg) => { setToastMsg(msg); setTimeout(() => setToastMsg(null), 3000); };

    const initials = student?.name
        ? student.name.split(' ').map(n => n[0]).join('').toUpperCase().slice(0, 2)
        : '??';

    const perf = perfConfig[student?.performanceTag] || perfConfig['N/A'];

    return (
        <>
            {/* Backdrop */}
            <div
                onClick={onClose}
                style={{
                    position: 'fixed', inset: 0, zIndex: 40,
                    background: 'rgba(15,23,42,0.5)',
                    backdropFilter: 'blur(4px)',
                }}
            />

            {/* Panel */}
            <div style={{
                position: 'fixed', top: 0, right: 0, height: '100%',
                width: '100%', maxWidth: 500, zIndex: 50,
                display: 'flex', flexDirection: 'column',
                background: '#FFFFFF',
                boxShadow: '-12px 0 48px rgba(15,23,42,0.18)',
                animation: 'slideInRight 0.3s cubic-bezier(0.4,0,0.2,1) forwards',
            }}>

                {/* ── Gradient Header ─────────────────────────────── */}
                <div style={{
                    background: student?.active !== false
                        ? 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)'
                        : 'linear-gradient(135deg, #374151 0%, #1F2937 100%)',
                    padding: '24px 24px 20px',
                    flexShrink: 0,
                    position: 'relative',
                    overflow: 'hidden',
                }}>
                    {/* Decorative circles */}
                    <div style={{ position: 'absolute', top: -30, right: -30, width: 120, height: 120, borderRadius: '50%', background: 'rgba(255,255,255,0.05)' }} />
                    <div style={{ position: 'absolute', bottom: -20, left: -20, width: 80, height: 80, borderRadius: '50%', background: 'rgba(255,255,255,0.05)' }} />

                    {/* Close button */}
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 18, position: 'relative' }}>
                        <span style={{ fontSize: '0.65rem', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.12em', color: 'rgba(255,255,255,0.6)' }}>
                            Student Profile
                        </span>
                        <button onClick={onClose} style={{
                            width: 30, height: 30, borderRadius: 8, border: 'none',
                            background: 'rgba(255,255,255,0.15)', cursor: 'pointer',
                            display: 'flex', alignItems: 'center', justifyContent: 'center', color: 'white',
                        }}>
                            <svg width="14" height="14" fill="none" stroke="currentColor" viewBox="0 0 24 24" strokeWidth="2.5">
                                <path strokeLinecap="round" strokeLinejoin="round" d="M6 18L18 6M6 6l12 12" />
                            </svg>
                        </button>
                    </div>

                    {loading ? (
                        <div style={{ display: 'flex', gap: 16, alignItems: 'center' }}>
                            <div style={{ width: 56, height: 56, borderRadius: 14, background: 'rgba(255,255,255,0.15)' }} className="animate-pulse" />
                            <div>
                                <div style={{ height: 18, width: 140, background: 'rgba(255,255,255,0.15)', borderRadius: 6, marginBottom: 8 }} className="animate-pulse" />
                                <div style={{ height: 11, width: 90, background: 'rgba(255,255,255,0.15)', borderRadius: 6 }} className="animate-pulse" />
                            </div>
                        </div>
                    ) : student ? (
                        <div style={{ position: 'relative' }}>
                            {/* Avatar + name row */}
                            <div style={{ display: 'flex', alignItems: 'flex-start', gap: 16, marginBottom: 14 }}>
                                <div style={{
                                    width: 56, height: 56, borderRadius: 14, flexShrink: 0,
                                    background: 'rgba(255,255,255,0.2)',
                                    border: '2px solid rgba(255,255,255,0.35)',
                                    display: 'flex', alignItems: 'center', justifyContent: 'center',
                                    fontSize: '1.3rem', fontWeight: 800, color: 'white',
                                    letterSpacing: '-0.02em',
                                }}>
                                    {initials}
                                </div>
                                <div style={{ flex: 1, minWidth: 0 }}>
                                    <h2 style={{ fontSize: '1.25rem', fontWeight: 800, color: 'white', margin: '0 0 3px', lineHeight: 1.2 }}>
                                        {student.name}
                                    </h2>
                                    <p style={{ fontSize: '0.78rem', color: 'rgba(255,255,255,0.65)', fontFamily: 'monospace', margin: '0 0 10px' }}>
                                        {student.studentId}
                                    </p>
                                    {/* Status + perf badges */}
                                    <div style={{ display: 'flex', flexWrap: 'wrap', gap: 6 }}>
                                        <span style={{
                                            display: 'inline-flex', alignItems: 'center', gap: 5,
                                            padding: '3px 10px', borderRadius: 999, fontSize: '0.7rem', fontWeight: 700,
                                            background: student.active ? 'rgba(52,211,153,0.2)' : 'rgba(239,68,68,0.2)',
                                            border: `1px solid ${student.active ? 'rgba(52,211,153,0.4)' : 'rgba(239,68,68,0.4)'}`,
                                            color: 'white',
                                        }}>
                                            <span style={{ width: 6, height: 6, borderRadius: '50%', background: student.active ? '#34D399' : '#EF4444' }} />
                                            {student.active ? 'Active' : 'Inactive'}
                                        </span>
                                        <span style={{
                                            display: 'inline-flex', alignItems: 'center', gap: 5,
                                            padding: '3px 10px', borderRadius: 999, fontSize: '0.7rem', fontWeight: 700,
                                            background: 'rgba(255,255,255,0.15)', border: '1px solid rgba(255,255,255,0.25)',
                                            color: 'white',
                                        }}>
                                            <span style={{ width: 6, height: 6, borderRadius: '50%', background: perf.dot }} />
                                            {perf.label}
                                        </span>
                                    </div>
                                </div>
                            </div>

                            {/* Tab switcher */}
                            <div style={{ display: 'flex', gap: 4, background: 'rgba(0,0,0,0.15)', borderRadius: 10, padding: 4 }}>
                                {[['profile', 'Profile'], ['performance', 'Performance']].map(([key, label]) => (
                                    <button key={key} onClick={() => setActiveTab(key)} style={{
                                        flex: 1, padding: '7px 0', borderRadius: 7, border: 'none',
                                        fontSize: '0.8rem', fontWeight: 700, cursor: 'pointer',
                                        background: activeTab === key ? 'rgba(255,255,255,0.22)' : 'transparent',
                                        color: activeTab === key ? 'white' : 'rgba(255,255,255,0.55)',
                                        transition: 'all 0.18s',
                                    }}>
                                        {label}
                                    </button>
                                ))}
                            </div>
                        </div>
                    ) : null}
                </div>

                {/* ── Scrollable Body ──────────────────────────────── */}
                <div style={{ flex: 1, overflowY: 'auto', padding: '20px 24px', background: '#F9FAFB' }}>
                    {error ? (
                        <div style={{ textAlign: 'center', paddingTop: '4rem' }}>
                            <div style={{ fontSize: '2.5rem', marginBottom: 12 }}>😕</div>
                            <p style={{ color: '#374151', fontWeight: 600 }}>{error}</p>
                        </div>
                    ) : loading ? (
                        <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
                            {[...Array(4)].map((_, i) => (
                                <div key={i} className="animate-pulse" style={{ background: 'white', borderRadius: 12, padding: 16 }}>
                                    <div style={{ height: 9, width: 70, background: '#E5E7EB', borderRadius: 5, marginBottom: 10 }} />
                                    <div style={{ height: 13, background: '#E5E7EB', borderRadius: 5, marginBottom: 6 }} />
                                    <div style={{ height: 13, width: '65%', background: '#E5E7EB', borderRadius: 5 }} />
                                </div>
                            ))}
                        </div>
                    ) : student ? (

                        activeTab === 'profile' ? (
                            <>
                                {/* ── Admission Details ── */}
                                <div style={{ background: 'white', borderRadius: 14, padding: '16px 18px', marginBottom: 12, border: '1px solid #E5E7EB', boxShadow: '0 1px 4px rgba(0,0,0,0.04)' }}>
                                    <Section title="Admission Details" icon="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" accent="#6366F1">
                                        <InfoGrid>
                                            <InfoRow label="Registration ID" value={student.studentId} />
                                            <InfoRow label="Batch Year" value={student.batch} />
                                            <InfoRow label="Programme" value={student.degreeName} />
                                            <InfoRow label="Degree" value={student.degree} />
                                            <InfoRow label="Specialization" value={student.specialization} />
                                            <InfoRow label="Year / Semester" value={`Year ${student.currentYear} — Sem ${student.currentSemester}`} />
                                        </InfoGrid>
                                    </Section>
                                </div>

                                {/* ── Personal Information ── */}
                                <div style={{ background: 'white', borderRadius: 14, padding: '16px 18px', marginBottom: 12, border: '1px solid #E5E7EB', boxShadow: '0 1px 4px rgba(0,0,0,0.04)' }}>
                                    <Section title="Personal Information" icon="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" accent="#7C3AED">
                                        <InfoGrid>
                                            <InfoRow label="Date of Birth" value={student.dob} />
                                            <InfoRow label="Blood Group" value={student.bloodGroup} />
                                            <InfoRow label="Religion" value={student.religion} />
                                            <InfoRow label="Caste" value={student.caste} />
                                        </InfoGrid>
                                        <InfoRow label="Address" value={student.address} />
                                    </Section>
                                </div>

                                {/* ── Contact ── */}
                                <div style={{ background: 'white', borderRadius: 14, padding: '16px 18px', marginBottom: 12, border: '1px solid #E5E7EB', boxShadow: '0 1px 4px rgba(0,0,0,0.04)' }}>
                                    <Section title="Contact Information" icon="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" accent="#2563EB">
                                        <InfoGrid>
                                            <InfoRow label="Email" value={student.email} />
                                            <InfoRow label="Phone" value={student.phone} />
                                            <InfoRow label="WhatsApp" value={student.whatsappNumber} />
                                        </InfoGrid>
                                    </Section>
                                </div>

                                {/* ── Parent / Guardian ── */}
                                <div style={{ background: 'white', borderRadius: 14, padding: '16px 18px', marginBottom: 12, border: '1px solid #E5E7EB', boxShadow: '0 1px 4px rgba(0,0,0,0.04)' }}>
                                    <Section title="Parent / Guardian" icon="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0z" accent="#059669">
                                        <InfoGrid>
                                            <InfoRow label="Parent Name" value={student.parentName} />
                                            <InfoRow label="Parent Mobile" value={student.parentMobile} />
                                        </InfoGrid>
                                    </Section>
                                </div>
                            </>
                        ) : (
                            <>
                                {/* ── Performance Overview ── */}
                                <div style={{ background: 'white', borderRadius: 14, padding: '16px 18px', marginBottom: 12, border: '1px solid #E5E7EB', boxShadow: '0 1px 4px rgba(0,0,0,0.04)' }}>
                                    <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 14 }}>
                                        <div>
                                            <p style={{ fontSize: '0.7rem', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.08em', color: '#6B7280', marginBottom: 4 }}>Overall Score</p>
                                            <p style={{ fontSize: '2rem', fontWeight: 900, color: perf.dot, lineHeight: 1 }}>
                                                {student.avgMarkPct != null ? `${student.avgMarkPct}%` : '—'}
                                            </p>
                                        </div>
                                        <span style={{
                                            padding: '6px 14px', borderRadius: 999, fontWeight: 700, fontSize: '0.8rem',
                                            background: perf.bg, color: perf.color,
                                            display: 'inline-flex', alignItems: 'center', gap: 6,
                                        }}>
                                            <span style={{ width: 7, height: 7, borderRadius: '50%', background: perf.dot }} />
                                            {perf.label}
                                        </span>
                                    </div>

                                    {student.avgMarkPct != null && (
                                        <>
                                            <div style={{ height: 8, background: '#F1F5F9', borderRadius: 999, overflow: 'hidden', marginBottom: 8 }}>
                                                <div style={{
                                                    height: '100%', borderRadius: 999,
                                                    width: `${student.avgMarkPct}%`,
                                                    background: student.avgMarkPct >= 75
                                                        ? 'linear-gradient(90deg, #34D399, #10B981)'
                                                        : student.avgMarkPct >= 50
                                                            ? 'linear-gradient(90deg, #FCD34D, #F59E0B)'
                                                            : 'linear-gradient(90deg, #FCA5A5, #EF4444)',
                                                    transition: 'width 0.8s cubic-bezier(0.4,0,0.2,1)',
                                                }} />
                                            </div>
                                            <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.7rem', color: '#9CA3AF', fontWeight: 600 }}>
                                                <span>0%</span><span>50%</span><span>100%</span>
                                            </div>
                                        </>
                                    )}

                                    {student.avgMarkPct != null && student.avgMarkPct < 50 && (
                                        <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginTop: 12, padding: '8px 12px', borderRadius: 10, background: '#FEF2F2', border: '1px solid #FECACA' }}>
                                            <svg width="15" height="15" fill="none" stroke="#EF4444" viewBox="0 0 24 24" strokeWidth="2">
                                                <path strokeLinecap="round" strokeLinejoin="round" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                                            </svg>
                                            <span style={{ color: '#991B1B', fontSize: '0.78rem', fontWeight: 700 }}>
                                                Academic risk — marks below passing threshold
                                            </span>
                                        </div>
                                    )}
                                </div>

                                {/* ── Internal Marks Table ── */}
                                <div style={{ background: 'white', borderRadius: 14, border: '1px solid #E5E7EB', overflow: 'hidden', boxShadow: '0 1px 4px rgba(0,0,0,0.04)' }}>
                                    <div style={{ padding: '14px 18px 10px', borderBottom: '1.5px solid #F3F4F6' }}>
                                        <span style={{ fontSize: '0.72rem', fontWeight: 800, textTransform: 'uppercase', letterSpacing: '0.08em', color: '#1F2937' }}>
                                            Internal Marks
                                        </span>
                                    </div>

                                    {student.internalMarks && student.internalMarks.length > 0 ? (
                                        <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.82rem' }}>
                                            <thead>
                                                <tr style={{ background: '#F8FAFC' }}>
                                                    {['Subject', 'Exam', 'Sem', 'Score'].map(h => (
                                                        <th key={h} style={{ padding: '8px 14px', textAlign: 'left', fontSize: '0.68rem', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.07em', color: '#374151', borderBottom: '1px solid #E5E7EB' }}>
                                                            {h}
                                                        </th>
                                                    ))}
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {student.internalMarks.map((m, i) => {
                                                    const pct = m.pct || 0;
                                                    const sc = pct >= 75 ? '#16A34A' : pct >= 50 ? '#D97706' : '#DC2626';
                                                    return (
                                                        <tr key={i} style={{ borderBottom: i < student.internalMarks.length - 1 ? '1px solid #F9FAFB' : 'none' }}>
                                                            <td style={{ padding: '9px 14px', fontWeight: 700, color: '#111827', fontFamily: 'monospace', fontSize: '0.78rem' }}>{m.subject}</td>
                                                            <td style={{ padding: '9px 14px', color: '#4B5563', fontSize: '0.78rem' }}>{m.examType}</td>
                                                            <td style={{ padding: '9px 14px', color: '#6B7280', fontWeight: 600 }}>{m.semesterNo != null ? `S${m.semesterNo}` : '—'}</td>
                                                            <td style={{ padding: '9px 14px' }}>
                                                                <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
                                                                    <span style={{ fontWeight: 800, color: sc, fontSize: '0.85rem' }}>{m.marks}/{m.maxMarks}</span>
                                                                    {m.pct != null && (
                                                                        <span style={{ fontSize: '0.65rem', fontWeight: 700, padding: '1px 6px', borderRadius: 99, background: sc + '15', color: sc }}>{m.pct}%</span>
                                                                    )}
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    );
                                                })}
                                            </tbody>
                                        </table>
                                    ) : (
                                        <div style={{ textAlign: 'center', padding: '2.5rem 1rem' }}>
                                            <div style={{ fontSize: '2rem', marginBottom: 8 }}>📊</div>
                                            <p style={{ color: '#6B7280', fontSize: '0.85rem', fontWeight: 600 }}>No internal marks recorded yet</p>
                                        </div>
                                    )}
                                </div>
                            </>
                        )

                    ) : null}
                </div>

                {/* ── Footer ───────────────────────────────────────── */}
                {student && !loading && (
                    <div style={{
                        flexShrink: 0, padding: '12px 20px',
                        background: 'white', borderTop: '1px solid #F3F4F6',
                        display: 'flex', gap: 10,
                    }}>
                        <button
                            onClick={handleToggle}
                            disabled={toggling}
                            style={{
                                flex: 1, height: 42,
                                display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 8,
                                borderRadius: 10, fontSize: '0.85rem', fontWeight: 700, cursor: toggling ? 'not-allowed' : 'pointer',
                                opacity: toggling ? 0.65 : 1,
                                border: student.active ? '1.5px solid #FECACA' : '1.5px solid #BBF7D0',
                                background: student.active ? '#FFF1F1' : '#F0FDF4',
                                color: student.active ? '#DC2626' : '#16A34A',
                                transition: 'all 0.18s',
                            }}
                        >
                            {toggling
                                ? <svg className="animate-spin" width="15" height="15" fill="none" viewBox="0 0 24 24"><circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" /><path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z" /></svg>
                                : <svg width="15" height="15" fill="none" stroke="currentColor" viewBox="0 0 24 24" strokeWidth="2"><path strokeLinecap="round" strokeLinejoin="round" d={student.active ? "M18.364 18.364A9 9 0 005.636 5.636m12.728 12.728A9 9 0 015.636 5.636" : "M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"} /></svg>
                            }
                            {toggling ? 'Processing…' : student.active ? 'Deactivate Student' : 'Activate Student'}
                        </button>
                        <button onClick={onClose} style={{
                            padding: '0 18px', height: 42, borderRadius: 10,
                            border: '1.5px solid #E5E7EB', background: 'white',
                            fontSize: '0.85rem', fontWeight: 700, color: '#374151', cursor: 'pointer',
                        }}>
                            Close
                        </button>
                    </div>
                )}

                {/* Toast */}
                {toastMsg && (
                    <div style={{
                        position: 'fixed', bottom: 28, left: '50%', transform: 'translateX(-50%)',
                        background: '#0F172A', color: 'white', padding: '10px 20px',
                        borderRadius: 12, fontSize: '0.84rem', fontWeight: 600,
                        boxShadow: '0 8px 32px rgba(15,23,42,0.3)', zIndex: 9999,
                    }}>
                        {toastMsg}
                    </div>
                )}
            </div>
        </>
    );
};

export default StudentDetailPanel;
