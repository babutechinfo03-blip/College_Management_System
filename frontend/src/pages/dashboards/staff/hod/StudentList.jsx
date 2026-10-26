import React, { useState, useEffect, useRef, useCallback, useMemo } from 'react';
import api from '../../../../services/api';
import StudentDetailPanel from './StudentDetailPanel';

const ROWS_PER_PAGE = 15;

const semsByYear = {
    '1': ['1', '2'],
    '2': ['3', '4'],
    '3': ['5', '6'],
    '4': ['7', '8'],
};

const PerfBadge = ({ tag }) => {
    const cfg = {
        HIGH: { cls: 'perf-badge perf-high', dot: '#16a34a', label: 'High' },
        AVERAGE: { cls: 'perf-badge perf-average', dot: '#d97706', label: 'Avg' },
        AT_RISK: { cls: 'perf-badge perf-risk', dot: '#dc2626', label: 'At Risk' },
        'N/A': { cls: 'perf-badge perf-na', dot: '#94a3b8', label: 'N/A' },
    };
    const c = cfg[tag] || cfg['N/A'];
    return (
        <span className={c.cls}>
            <span style={{ width: 6, height: 6, borderRadius: '50%', background: c.dot, display: 'inline-block' }} />
            {c.label}
        </span>
    );
};

const KpiCard = ({ icon, label, value, color }) => (
    <div className="kpi-card">
        <div className="kpi-icon" style={{ background: color + '18' }}>
            <svg className="icon-md" fill="none" stroke={color} viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d={icon} />
            </svg>
        </div>
        <div>
            <div className="kpi-label" style={{ color: '#4B5563' }}>{label}</div>
            <div className="kpi-value" style={{ color }}>{value ?? '—'}</div>
        </div>
    </div>
);

const StudentList = () => {
    const [students, setStudents] = useState([]);
    const [stats, setStats] = useState({ total: 0, active: 0, inactive: 0, defaulters: 0 });
    const [loading, setLoading] = useState(true);
    const [statsLoading, setStatsLoading] = useState(true);

    // Filters
    const [searchTerm, setSearchTerm] = useState('');
    const [debouncedSearch, setDebouncedSearch] = useState('');
    const [filterYear, setFilterYear] = useState('All');
    const [filterSemester, setFilterSemester] = useState('All');
    const [filterSection, setFilterSection] = useState('All');
    const [filterStatus, setFilterStatus] = useState('All');

    // Pagination
    const [page, setPage] = useState(1);

    // Panel
    const [selectedStudentId, setSelectedStudentId] = useState(null);

    // Debounce search
    const debounceTimer = useRef(null);
    const handleSearchChange = useCallback((val) => {
        setSearchTerm(val);
        clearTimeout(debounceTimer.current);
        debounceTimer.current = setTimeout(() => {
            setDebouncedSearch(val);
            setPage(1);
        }, 300);
    }, []);

    // Reset semester when year changes
    const handleYearChange = (y) => {
        setFilterYear(y);
        setFilterSemester('All');
        setPage(1);
    };

    const availableSems = filterYear !== 'All' ? semsByYear[filterYear] || [] : [];

    // Fetch data
    useEffect(() => {
        const fetchAll = async () => {
            try {
                const [studRes, statsRes] = await Promise.all([
                    api.get('/hod/students'),
                    api.get('/hod/students/stats'),
                ]);
                setStudents(studRes.data);
                setStats(statsRes.data);
            } catch (e) {
                console.error('Failed to load data', e);
            } finally {
                setLoading(false);
                setStatsLoading(false);
            }
        };
        fetchAll();
    }, []);

    // Filtered students
    const filteredStudents = useMemo(() => {
        const q = debouncedSearch.toLowerCase();
        return students.filter(s => {
            if (q && !s.name.toLowerCase().includes(q) && !s.studentId.toLowerCase().includes(q)) return false;
            if (filterYear !== 'All' && String(s.year) !== filterYear) return false;
            if (filterSemester !== 'All' && String(s.semester) !== filterSemester) return false;
            if (filterSection !== 'All') {
                const sec = s.section || 'A';
                if (sec !== filterSection) return false;
            }
            if (filterStatus === 'Active' && !s.active) return false;
            if (filterStatus === 'Inactive' && s.active) return false;
            return true;
        });
    }, [students, debouncedSearch, filterYear, filterSemester, filterSection, filterStatus]);

    // Pagination
    const totalPages = Math.max(1, Math.ceil(filteredStudents.length / ROWS_PER_PAGE));
    const pageStudents = useMemo(() => {
        const start = (page - 1) * ROWS_PER_PAGE;
        return filteredStudents.slice(start, start + ROWS_PER_PAGE);
    }, [filteredStudents, page]);

    // Reset page on filter change
    useEffect(() => { setPage(1); }, [filterYear, filterSemester, filterSection, filterStatus]);

    // Status toggled callback
    const handleStatusToggled = (id, newActive) => {
        setStudents(prev => prev.map(s => s.id === id ? { ...s, active: newActive } : s));
        setStats(prev => ({
            ...prev,
            active: newActive ? prev.active + 1 : prev.active - 1,
            inactive: newActive ? prev.inactive - 1 : prev.inactive + 1,
        }));
    };

    // CSV Export
    const handleExport = () => {
        const headers = ['ID', 'Name', 'Year', 'Semester', 'Degree', 'Status', 'Performance'];
        const rows = filteredStudents.map(s => [
            s.studentId,
            `"${s.name}"`,
            s.year,
            s.semester,
            s.degree,
            s.active ? 'Active' : 'Inactive',
            s.performanceTag,
        ]);
        const csv = [headers, ...rows].map(r => r.join(',')).join('\n');
        const blob = new Blob([csv], { type: 'text/csv' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = `students_${new Date().toISOString().slice(0, 10)}.csv`;
        a.click();
        URL.revokeObjectURL(url);
    };

    // PDF Export via styled print window
    const handleExportPDF = () => {
        const dateStr = new Date().toLocaleDateString('en-IN', { day: '2-digit', month: 'long', year: 'numeric' });
        const rows = filteredStudents.map(s => `
            <tr>
                <td>${s.studentId}</td>
                <td>${s.name}</td>
                <td>Year ${s.year} / Sem ${s.semester}</td>
                <td>${s.degree}</td>
                <td><span class="badge ${s.active ? 'active' : 'inactive'}">${s.active ? 'Active' : 'Inactive'}</span></td>
                <td><span class="perf perf-${(s.performanceTag || 'N/A').toLowerCase().replace('_', '-')}">${s.performanceTag || 'N/A'}</span></td>
            </tr>`).join('');

        const html = `<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Database Report</title>
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body { font-family: 'Segoe UI', Arial, sans-serif; color: #111827; background: white; padding: 40px; }
  .header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 32px; border-bottom: 2px solid #6366F1; padding-bottom: 20px; }
  .header .title { font-size: 22px; font-weight: 800; color: #1F2937; }
  .header .subtitle { font-size: 13px; color: #6B7280; margin-top: 4px; }
  .header .meta { text-align: right; font-size: 12px; color: #6B7280; line-height: 1.8; }
  .summary { display: grid; grid-template-columns: repeat(4,1fr); gap: 12px; margin-bottom: 28px; }
  .sum-card { background: #F8FAFC; border: 1px solid #E5E7EB; border-radius: 8px; padding: 12px 16px; }
  .sum-card .label { font-size: 10px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.06em; color: #6B7280; }
  .sum-card .value { font-size: 22px; font-weight: 900; color: #1F2937; }
  table { width: 100%; border-collapse: collapse; font-size: 12px; }
  thead tr { background: #4F46E5; color: white; }
  thead th { padding: 10px 14px; text-align: left; font-weight: 700; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em; }
  tbody tr { border-bottom: 1px solid #F3F4F6; }
  tbody tr:nth-child(even) { background: #F9FAFB; }
  tbody td { padding: 9px 14px; color: #374151; }
  .badge { display: inline-block; padding: 2px 9px; border-radius: 999px; font-size: 10px; font-weight: 700; }
  .active { background: #DCFCE7; color: #166534; }
  .inactive { background: #FEE2E2; color: #991B1B; }
  .perf { display: inline-block; padding: 2px 9px; border-radius: 999px; font-size: 10px; font-weight: 700; }
  .perf-high { background: #DCFCE7; color: #166534; }
  .perf-average { background: #FEF3C7; color: #92400E; }
  .perf-at-risk { background: #FEE2E2; color: #991B1B; }
  .perf-n-a { background: #F1F5F9; color: #475569; }
  .footer { margin-top: 24px; font-size: 10px; color: #9CA3AF; text-align: center; }
  @media print { body { padding: 20px; } }
</style>
</head>
<body>
  <div class="header">
    <div>
      <div class="title">Student Database Report</div>
      <div class="subtitle">Department of Computer Science &amp; Engineering</div>
    </div>
    <div class="meta">
      <div><strong>Generated:</strong> ${dateStr}</div>
      <div><strong>Total Records:</strong> ${filteredStudents.length}</div>
    </div>
  </div>
  <div class="summary">
    <div class="sum-card"><div class="label">Total</div><div class="value">${stats.total}</div></div>
    <div class="sum-card"><div class="label">Active</div><div class="value" style="color:#16A34A">${stats.active}</div></div>
    <div class="sum-card"><div class="label">Inactive</div><div class="value" style="color:#DC2626">${stats.inactive}</div></div>
    <div class="sum-card"><div class="label">Defaulters</div><div class="value" style="color:#D97706">${stats.defaulters}</div></div>
  </div>
  <table>
    <thead><tr><th>#</th><th>Reg ID</th><th>Student Name</th><th>Academic Info</th><th>Degree</th><th>Status</th><th>Performance</th></tr></thead>
    <tbody>${filteredStudents.map((s, i) => `
      <tr>
        <td style="color:#6B7280;font-weight:600">${i + 1}</td>
        <td style="font-family:monospace;font-weight:700;color:#4F46E5">${s.studentId}</td>
        <td style="font-weight:600">${s.name}</td>
        <td>Year ${s.year} / Sem ${s.semester}</td>
        <td>${s.degree}</td>
        <td><span class="badge ${s.active ? 'active' : 'inactive'}">${s.active ? 'Active' : 'Inactive'}</span></td>
        <td><span class="perf perf-${(s.performanceTag || 'N/A').toLowerCase().replace('_', '-').replace('/', '-')}">${s.performanceTag || 'N/A'}</span></td>
      </tr>`).join('')}
    </tbody>
  </table>
  <div class="footer">StaffHub ERP &mdash; Computer Science &amp; Engineering &mdash; Confidential</div>
</body>
</html>`;

        const win = window.open('', '_blank', 'width=900,height=700');
        win.document.write(html);
        win.document.close();
        win.focus();
        setTimeout(() => win.print(), 600);
    };

    const clearFilters = () => {
        setSearchTerm('');
        setDebouncedSearch('');
        setFilterYear('All');
        setFilterSemester('All');
        setFilterSection('All');
        setFilterStatus('All');
        setPage(1);
    };

    const hasActiveFilters = debouncedSearch || filterYear !== 'All' || filterSemester !== 'All'
        || filterSection !== 'All' || filterStatus !== 'All';

    if (loading) return (
        <div className="flex-center h-64">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2" style={{ borderColor: 'var(--primary)' }}></div>
        </div>
    );

    return (
        <>
            <div className="animate-fade-in p-8 max-w-7xl mx-auto">

                {/* ── PAGE HEADER ─────────────────────────────────── */}
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', gap: 16, marginBottom: 32, flexWrap: 'nowrap' }}>
                    <div>
                        <p className="text-xs font-bold uppercase tracking-widest mb-1" style={{ color: 'var(--primary)' }}>
                            Department Console
                        </p>
                        <h2 className="text-4xl font-extrabold leading-tight" style={{ color: 'var(--text-main)' }}>
                            Student{' '}
                            <span className="text-transparent bg-clip-text bg-gradient-to-r from-indigo-600 to-violet-600">
                                Database
                            </span>
                        </h2>
                        <p className="text-sm mt-1 font-medium italic" style={{ color: 'var(--text-muted)' }}>
                            Computer Science &amp; Engineering
                        </p>
                    </div>

                    {/* Export Button Group */}
                    <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
                        {/* Export CSV */}
                        <button
                            onClick={handleExport}
                            style={{
                                display: 'inline-flex', alignItems: 'center', gap: 8,
                                padding: '10px 20px', borderRadius: 12,
                                border: '1.5px solid #6366F1',
                                background: 'white', color: '#4F46E5',
                                fontSize: '0.875rem', fontWeight: 700, cursor: 'pointer',
                                transition: 'all 0.18s',
                                boxShadow: '0 1px 4px rgba(99,102,241,0.15)',
                            }}
                            onMouseEnter={e => {
                                e.currentTarget.style.background = '#EEF2FF';
                                e.currentTarget.style.boxShadow = '0 4px 16px rgba(99,102,241,0.25)';
                                e.currentTarget.style.transform = 'translateY(-1px)';
                            }}
                            onMouseLeave={e => {
                                e.currentTarget.style.background = 'white';
                                e.currentTarget.style.boxShadow = '0 1px 4px rgba(99,102,241,0.15)';
                                e.currentTarget.style.transform = 'translateY(0)';
                            }}
                        >
                            <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24" strokeWidth="2.2">
                                <path strokeLinecap="round" strokeLinejoin="round" d="M12 10v6m0 0l-3-3m3 3l3-3M3 17V7a2 2 0 012-2h6l2 2h6a2 2 0 012 2v8a2 2 0 01-2 2H5a2 2 0 01-2-2z" />
                            </svg>
                            Export CSV
                        </button>

                        {/* Download PDF */}
                        <button
                            onClick={handleExportPDF}
                            style={{
                                display: 'inline-flex', alignItems: 'center', gap: 8,
                                padding: '10px 20px', borderRadius: 12,
                                border: 'none',
                                background: 'linear-gradient(135deg, #4F46E5, #7C3AED)',
                                color: 'white',
                                fontSize: '0.875rem', fontWeight: 700, cursor: 'pointer',
                                transition: 'all 0.18s',
                                boxShadow: '0 4px 14px rgba(99,102,241,0.35)',
                            }}
                            onMouseEnter={e => {
                                e.currentTarget.style.boxShadow = '0 6px 20px rgba(99,102,241,0.5)';
                                e.currentTarget.style.transform = 'translateY(-2px)';
                            }}
                            onMouseLeave={e => {
                                e.currentTarget.style.boxShadow = '0 4px 14px rgba(99,102,241,0.35)';
                                e.currentTarget.style.transform = 'translateY(0)';
                            }}
                        >
                            <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24" strokeWidth="2.2">
                                <path strokeLinecap="round" strokeLinejoin="round" d="M7 21h10a2 2 0 002-2V9.414a1 1 0 00-.293-.707l-5.414-5.414A1 1 0 0012.586 3H7a2 2 0 00-2 2v14a2 2 0 002 2z" />
                                <path strokeLinecap="round" strokeLinejoin="round" d="M9 13h6M9 17h4" />
                            </svg>
                            Download PDF
                        </button>
                    </div>
                </div>

                {/* ── KPI STATS BAR ────────────────────────────────── */}
                <div className="kpi-bar">
                    <KpiCard
                        icon="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0z"
                        label="Total Students"
                        value={statsLoading ? '...' : stats.total}
                        color="#6366f1"
                    />
                    <KpiCard
                        icon="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
                        label="Active"
                        value={statsLoading ? '...' : stats.active}
                        color="#10b981"
                    />
                    <KpiCard
                        icon="M18.364 18.364A9 9 0 005.636 5.636m12.728 12.728A9 9 0 015.636 5.636m12.728 12.728L5.636 5.636"
                        label="Inactive"
                        value={statsLoading ? '...' : stats.inactive}
                        color="#ef4444"
                    />
                    <KpiCard
                        icon="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"
                        label="Defaulters"
                        value={statsLoading ? '...' : stats.defaulters}
                        color="#f59e0b"
                    />
                </div>

                {/* ── FILTER CARD ──────────────────────────────────── */}
                <div style={{
                    background: 'var(--card-bg)',
                    border: '1px solid #E5E7EB',
                    borderRadius: 12,
                    padding: '20px 24px 16px',
                    marginBottom: 24,
                    boxShadow: '0 1px 4px rgba(0,0,0,0.06)',
                }}>
                    {/* Filter row — single aligned row */}
                    <div style={{
                        display: 'flex',
                        alignItems: 'flex-end',
                        gap: 16,
                        flexWrap: 'wrap',
                    }}>
                        {/* Search — 40% width */}
                        <div style={{ flex: '2 1 220px', minWidth: 180 }}>
                            <label style={{ display: 'block', fontSize: '0.72rem', fontWeight: 600, color: '#1F2937', textTransform: 'uppercase', letterSpacing: '0.07em', marginBottom: 6 }}>
                                Search Student
                            </label>
                            <div style={{ position: 'relative' }}>
                                <div style={{
                                    position: 'absolute', top: '50%', left: 12,
                                    transform: 'translateY(-50%)', pointerEvents: 'none', color: '#9CA3AF',
                                    display: 'flex', alignItems: 'center',
                                }}>
                                    <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                                    </svg>
                                </div>
                                <input
                                    type="text"
                                    placeholder="Search by Name or Registration ID..."
                                    value={searchTerm}
                                    onChange={e => handleSearchChange(e.target.value)}
                                    onFocus={e => { e.target.style.borderColor = '#6366F1'; e.target.style.boxShadow = '0 0 0 3px rgba(99,102,241,0.1)'; }}
                                    onBlur={e => { e.target.style.borderColor = '#D1D5DB'; e.target.style.boxShadow = 'none'; }}
                                    style={{
                                        width: '100%', height: 40,
                                        paddingLeft: 36, paddingRight: searchTerm ? 36 : 12,
                                        border: '1.5px solid #D1D5DB', borderRadius: 8,
                                        fontSize: '0.875rem', color: '#111827',
                                        background: '#F9FAFB', outline: 'none',
                                        fontWeight: 500, transition: 'all 0.18s',
                                        boxSizing: 'border-box',
                                    }}
                                />
                                {searchTerm && (
                                    <button
                                        onClick={() => handleSearchChange('')}
                                        style={{
                                            position: 'absolute', top: '50%', right: 10,
                                            transform: 'translateY(-50%)', background: 'none',
                                            border: 'none', cursor: 'pointer', color: '#9CA3AF',
                                            display: 'flex', alignItems: 'center', padding: 0,
                                        }}
                                    >
                                        <svg width="14" height="14" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M6 18L18 6M6 6l12 12" />
                                        </svg>
                                    </button>
                                )}
                            </div>
                        </div>

                        {/* Academic Year */}
                        <div style={{ flex: '1 1 120px', minWidth: 110 }}>
                            <label style={{ display: 'block', fontSize: '0.72rem', fontWeight: 600, color: '#1F2937', textTransform: 'uppercase', letterSpacing: '0.07em', marginBottom: 6 }}>
                                Year
                            </label>
                            <select
                                className="select-premium"
                                value={filterYear}
                                onChange={e => handleYearChange(e.target.value)}
                                style={{ width: '100%', height: 40, fontSize: '0.875rem', color: '#111827' }}
                            >
                                <option value="All">All Years</option>
                                {['1', '2', '3', '4'].map(y => <option key={y} value={y}>Year {y}</option>)}
                            </select>
                        </div>

                        {/* Semester */}
                        <div style={{ flex: '1 1 120px', minWidth: 110 }}>
                            <label style={{ display: 'block', fontSize: '0.72rem', fontWeight: 600, color: '#1F2937', textTransform: 'uppercase', letterSpacing: '0.07em', marginBottom: 6 }}>
                                Semester
                            </label>
                            <select
                                className="select-premium"
                                value={filterSemester}
                                onChange={e => { setFilterSemester(e.target.value); setPage(1); }}
                                disabled={filterYear === 'All'}
                                style={{ width: '100%', height: 40, fontSize: '0.875rem', color: '#111827', opacity: filterYear === 'All' ? 0.5 : 1 }}
                            >
                                <option value="All">All Sems</option>
                                {(filterYear === 'All' ? ['1', '2', '3', '4', '5', '6', '7', '8'] : availableSems)
                                    .map(s => <option key={s} value={s}>Sem {s}</option>)}
                            </select>
                        </div>

                        {/* Section */}
                        <div style={{ flex: '1 1 120px', minWidth: 110 }}>
                            <label style={{ display: 'block', fontSize: '0.72rem', fontWeight: 600, color: '#1F2937', textTransform: 'uppercase', letterSpacing: '0.07em', marginBottom: 6 }}>
                                Section
                            </label>
                            <select
                                className="select-premium"
                                value={filterSection}
                                onChange={e => { setFilterSection(e.target.value); setPage(1); }}
                                style={{ width: '100%', height: 40, fontSize: '0.875rem', color: '#111827' }}
                            >
                                <option value="All">All Sections</option>
                                {['A', 'B', 'C'].map(s => <option key={s} value={s}>Section {s}</option>)}
                            </select>
                        </div>

                        {/* Status */}
                        <div style={{ flex: '1 1 120px', minWidth: 110 }}>
                            <label style={{ display: 'block', fontSize: '0.72rem', fontWeight: 600, color: '#1F2937', textTransform: 'uppercase', letterSpacing: '0.07em', marginBottom: 6 }}>
                                Status
                            </label>
                            <select
                                className="select-premium"
                                value={filterStatus}
                                onChange={e => { setFilterStatus(e.target.value); setPage(1); }}
                                style={{ width: '100%', height: 40, fontSize: '0.875rem', color: '#111827' }}
                            >
                                <option value="All">All Status</option>
                                <option value="Active">Active</option>
                                <option value="Inactive">Inactive</option>
                            </select>
                        </div>

                        {/* Clear button */}
                        {hasActiveFilters && (
                            <div style={{ flex: '0 0 auto', paddingBottom: 0 }}>
                                <div style={{ marginBottom: 6, fontSize: '0.72rem', color: 'transparent', userSelect: 'none' }}>.</div>
                                <button
                                    onClick={clearFilters}
                                    style={{
                                        height: 40, padding: '0 16px', borderRadius: 8,
                                        border: '1.5px solid #E5E7EB', background: 'white',
                                        fontSize: '0.8rem', fontWeight: 700, color: '#4B5563',
                                        cursor: 'pointer', whiteSpace: 'nowrap',
                                        transition: 'all 0.15s',
                                    }}
                                    onMouseEnter={e => { e.currentTarget.style.borderColor = '#6366F1'; e.currentTarget.style.color = '#6366F1'; }}
                                    onMouseLeave={e => { e.currentTarget.style.borderColor = '#E5E7EB'; e.currentTarget.style.color = '#4B5563'; }}
                                >
                                    × Clear
                                </button>
                            </div>
                        )}
                    </div>

                    {/* Result count row */}
                    <div style={{ display: 'flex', justifyContent: 'flex-end', alignItems: 'center', gap: 8, marginTop: 14, paddingTop: 12, borderTop: '1px solid #F3F4F6' }}>
                        {hasActiveFilters && (
                            <span style={{ fontSize: '0.78rem', color: '#6B7280', fontWeight: 500 }}>
                                filtered from {students.length} total
                            </span>
                        )}
                        <span style={{
                            fontSize: '0.82rem', fontWeight: 700, color: '#111827',
                            background: '#EFF6FF', border: '1px solid #BFDBFE',
                            borderRadius: 99, padding: '3px 12px', letterSpacing: '-0.01em',
                        }}>
                            {filteredStudents.length} Results
                        </span>
                    </div>
                </div>

                {/* ── TABLE ───────────────────────────────────────── */}
                <div className="glass-card overflow-hidden shadow-premium" style={{ padding: 0, border: '1px solid rgba(99,102,241,0.1)' }}>
                    <div className="overflow-x-auto">
                        <table className="premium-table">
                            <thead>
                                <tr style={{ background: '#F8FAFC' }}>
                                    {['Student Identity', 'Registration ID', 'Academic Info', 'Performance', 'Status'].map(h => (
                                        <th key={h} style={{ color: '#1F2937', fontWeight: 700, fontSize: '0.72rem', letterSpacing: '0.07em', padding: '14px 16px', textTransform: 'uppercase', borderBottom: '2px solid #E5E7EB', background: '#F8FAFC' }}>
                                            {h}
                                        </th>
                                    ))}
                                    <th style={{ color: '#1F2937', fontWeight: 700, fontSize: '0.72rem', letterSpacing: '0.07em', padding: '14px 16px', textTransform: 'uppercase', borderBottom: '2px solid #E5E7EB', background: '#F8FAFC', textAlign: 'right' }}>
                                        View
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                {pageStudents.map(student => (
                                    <tr
                                        key={student.id}
                                        className="group cursor-pointer"
                                        onClick={() => setSelectedStudentId(student.id)}
                                        style={{ borderBottom: '1px solid #F3F4F6', transition: 'background 0.15s' }}
                                        onMouseEnter={e => { e.currentTarget.style.background = '#F9FAFB'; }}
                                        onMouseLeave={e => { e.currentTarget.style.background = ''; }}
                                        title={`View ${student.name}'s profile`}
                                    >
                                        <td>
                                            <div className="flex items-center gap-3">
                                                <div className="avatar flex-shrink-0">
                                                    {student.name.split(' ').map(n => n[0]).join('').toUpperCase().slice(0, 2)}
                                                </div>
                                                <div>
                                                    <div className="font-bold text-sm" style={{ color: '#111827' }}>
                                                        {student.name}
                                                    </div>
                                                    <div className="text-xs font-semibold mt-0.5" style={{ color: '#4B5563' }}>
                                                        Sec {student.section || 'A'} · Batch {student.batch || '—'}
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <span className="font-mono text-xs font-bold px-2.5 py-1 rounded-md"
                                                style={{ color: 'var(--primary)', background: 'rgba(99,102,241,0.08)', border: '1px solid rgba(99,102,241,0.15)' }}>
                                                {student.studentId}
                                            </span>
                                        </td>
                                        <td>
                                            <div className="font-bold text-sm" style={{ color: '#1F2937' }}>
                                                {student.degree}
                                            </div>
                                            <div className="flex items-center gap-1.5 mt-0.5">
                                                <span className="text-xs font-semibold" style={{ color: '#4B5563' }}>
                                                    Year {student.year}
                                                </span>
                                                <span style={{ color: '#9CA3AF' }}>·</span>
                                                <span className="text-xs font-semibold" style={{ color: '#4B5563' }}>
                                                    Sem {student.semester}
                                                </span>
                                            </div>
                                        </td>
                                        <td>
                                            <PerfBadge tag={student.performanceTag || 'N/A'} />
                                        </td>
                                        <td>
                                            <span className={`badge ${student.active ? 'badge-success' : 'badge-error'}`}>
                                                {student.active ? 'Active' : 'Inactive'}
                                            </span>
                                        </td>
                                        <td className="text-right" style={{ padding: '12px 16px' }}>
                                            <button
                                                onClick={e => { e.stopPropagation(); setSelectedStudentId(student.id); }}
                                                title="View Details"
                                                style={{
                                                    display: 'inline-flex', alignItems: 'center', justifyContent: 'center',
                                                    width: 36, height: 36, borderRadius: 10,
                                                    border: '1.5px solid #E5E7EB',
                                                    background: 'white', cursor: 'pointer',
                                                    color: '#6366F1', transition: 'all 0.18s',
                                                    boxShadow: '0 1px 3px rgba(0,0,0,0.06)',
                                                }}
                                                onMouseEnter={e => {
                                                    e.currentTarget.style.background = '#EEF2FF';
                                                    e.currentTarget.style.borderColor = '#6366F1';
                                                    e.currentTarget.style.transform = 'scale(1.1)';
                                                    e.currentTarget.style.boxShadow = '0 4px 12px rgba(99,102,241,0.2)';
                                                }}
                                                onMouseLeave={e => {
                                                    e.currentTarget.style.background = 'white';
                                                    e.currentTarget.style.borderColor = '#E5E7EB';
                                                    e.currentTarget.style.transform = 'scale(1)';
                                                    e.currentTarget.style.boxShadow = '0 1px 3px rgba(0,0,0,0.06)';
                                                }}
                                            >
                                                <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                                </svg>
                                            </button>
                                        </td>
                                    </tr>
                                ))}

                                {filteredStudents.length === 0 && (
                                    <tr>
                                        <td colSpan="6" style={{ padding: '4rem', textAlign: 'center' }}>
                                            <div style={{ maxWidth: 320, margin: '0 auto' }}>
                                                <div style={{ fontSize: '3rem', marginBottom: '0.75rem' }}>🔍</div>
                                                <h3 className="text-lg font-bold mb-2" style={{ color: 'var(--text-main)' }}>
                                                    No Students Found
                                                </h3>
                                                <p className="text-sm mb-6" style={{ color: 'var(--text-muted)' }}>
                                                    Try adjusting your filters or search query.
                                                </p>
                                                <button onClick={clearFilters} className="btn btn-secondary">
                                                    Clear All Filters
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                )}
                            </tbody>
                        </table>
                    </div>

                    {/* ── PAGINATION ────────────────────────────────── */}
                    {filteredStudents.length > ROWS_PER_PAGE && (
                        <div className="flex items-center justify-between px-6 py-4"
                            style={{ borderTop: '1px solid var(--border)' }}>
                            <p className="text-xs font-semibold" style={{ color: 'var(--text-muted)' }}>
                                Showing {(page - 1) * ROWS_PER_PAGE + 1}–{Math.min(page * ROWS_PER_PAGE, filteredStudents.length)} of {filteredStudents.length}
                            </p>
                            <div className="flex items-center gap-1.5">
                                <button
                                    className="page-btn"
                                    disabled={page === 1}
                                    onClick={() => setPage(p => p - 1)}
                                >
                                    <svg className="icon-sm" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M15 19l-7-7 7-7" />
                                    </svg>
                                </button>

                                {Array.from({ length: totalPages }, (_, i) => i + 1)
                                    .filter(p => p === 1 || p === totalPages || Math.abs(p - page) <= 1)
                                    .reduce((acc, p, i, arr) => {
                                        if (i > 0 && p - arr[i - 1] > 1) acc.push('...');
                                        acc.push(p);
                                        return acc;
                                    }, [])
                                    .map((p, i) =>
                                        p === '...'
                                            ? <span key={`e${i}`} className="px-1 text-sm" style={{ color: 'var(--text-muted)' }}>…</span>
                                            : <button key={p} className={`page-btn ${page === p ? 'active' : ''}`}
                                                onClick={() => setPage(p)}>{p}</button>
                                    )
                                }

                                <button
                                    className="page-btn"
                                    disabled={page === totalPages}
                                    onClick={() => setPage(p => p + 1)}
                                >
                                    <svg className="icon-sm" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 5l7 7-7 7" />
                                    </svg>
                                </button>
                            </div>
                        </div>
                    )}
                </div>
            </div>

            {selectedStudentId && (
                <StudentDetailPanel
                    studentId={selectedStudentId}
                    onClose={() => setSelectedStudentId(null)}
                    onStatusToggled={handleStatusToggled}
                />
            )}
        </>
    );
};

export default StudentList;
