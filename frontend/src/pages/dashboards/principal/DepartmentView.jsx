import React, { useState, useEffect } from 'react';
import api from '../../../services/api';
import { useNavigate } from 'react-router-dom';

const DepartmentView = () => {
    const [departments, setDepartments] = useState([]);
    const [filteredDepartments, setFilteredDepartments] = useState([]);
    const [loading, setLoading] = useState(true);

    // Filters and Sorting
    const [filterProgram, setFilterProgram] = useState('ALL'); // ALL, UG, PG
    const [filterCategory, setFilterCategory] = useState('ALL'); // ALL, BE, BTech, ME, MTech, MBA, MCA
    const [searchQuery, setSearchQuery] = useState('');
    const [sortBy, setSortBy] = useState('NAME_ASC'); // NAME_ASC, STUDENTS_DESC, FACULTY_DESC

    const navigate = useNavigate();

    useEffect(() => {
        fetchDepartments();
    }, []);

    useEffect(() => {
        let result = departments;

        // 1. Program Type Filter
        if (filterProgram !== 'ALL') {
            result = result.filter(dept => dept.type === filterProgram);
        }

        // 2. Department Category Filter (Inferred from name or code)
        if (filterCategory !== 'ALL') {
            result = result.filter(dept => {
                const name = dept.name.toUpperCase();
                const code = dept.code.toUpperCase();
                if (filterCategory === 'BE/BTech') return name.includes('B.E') || name.includes('B.TECH') || dept.type === 'UG';
                if (filterCategory === 'ME/MTech') return name.includes('M.E') || name.includes('M.TECH') || dept.type === 'PG';
                if (filterCategory === 'MBA') return name.includes('MBA') || code.includes('MBA');
                if (filterCategory === 'MCA') return name.includes('MCA') || code.includes('MCA');
                return true;
            });
        }

        // 3. Search Filter
        if (searchQuery) {
            const query = searchQuery.toLowerCase();
            result = result.filter(dept =>
                dept.name.toLowerCase().includes(query) ||
                dept.code.toLowerCase().includes(query) ||
                (dept.hodName && dept.hodName.toLowerCase().includes(query))
            );
        }

        // 4. Sorting
        result.sort((a, b) => {
            if (sortBy === 'NAME_ASC') return a.name.localeCompare(b.name);
            if (sortBy === 'STUDENTS_DESC') return (b.totalStudents || 0) - (a.totalStudents || 0);
            if (sortBy === 'FACULTY_DESC') return (b.totalFaculty || 0) - (a.totalFaculty || 0);
            return 0;
        });

        setFilteredDepartments(result);
    }, [departments, filterProgram, filterCategory, searchQuery, sortBy]);

    const fetchDepartments = async () => {
        try {
            const response = await api.get('/principal/departments');
            setDepartments(response.data);
            setFilteredDepartments(response.data);
            setLoading(false);
        } catch (err) {
            console.error('Error fetching departments:', err);
            setLoading(false);
        }
    };

    const handleAction = (tab, deptCode) => {
        navigate(`/principal/departments/${deptCode}?tab=${tab}`);
    };

    return (
        <div className="animate-fade-in" style={{ padding: '32px 24px', minHeight: '100vh', background: '#F8FAFC' }}>

            {/* Header */}
            <div style={{ marginBottom: '32px' }}>
                <h2 style={{ fontSize: '2rem', fontWeight: '800', color: '#1E3A8A', margin: 0 }}>Institution Departments</h2>
                <p style={{ color: '#4B5563', fontSize: '1rem', marginTop: '8px' }}>Manage academic configurations and overview institutional divisions.</p>
            </div>

            {/* Advanced Filters Panel */}
            <div style={{ background: '#FFFFFF', padding: '24px', borderRadius: '12px', border: '1px solid #E5E7EB', marginBottom: '32px', display: 'flex', flexDirection: 'column', gap: '24px', boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.05)' }}>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '24px' }}>

                    {/* Search */}
                    <div>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: '600', color: '#374151', marginBottom: '8px', textTransform: 'uppercase' }}>Search</label>
                        <input
                            type="text"
                            placeholder="Dept Name, Code, HOD..."
                            value={searchQuery}
                            onChange={(e) => setSearchQuery(e.target.value)}
                            style={{ width: '100%', padding: '10px 16px', borderRadius: '8px', border: '1px solid #E5E7EB', outline: 'none', transition: 'border 0.2s', fontSize: '0.95rem' }}
                            onFocus={(e) => e.target.style.borderColor = '#2563EB'}
                            onBlur={(e) => e.target.style.borderColor = '#E5E7EB'}
                        />
                    </div>

                    {/* Program Type */}
                    <div>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: '600', color: '#374151', marginBottom: '8px', textTransform: 'uppercase' }}>Program Level</label>
                        <select
                            value={filterProgram}
                            onChange={(e) => setFilterProgram(e.target.value)}
                            style={{ width: '100%', padding: '10px 16px', borderRadius: '8px', border: '1px solid #E5E7EB', outline: 'none', background: '#FFFFFF', cursor: 'pointer', fontSize: '0.95rem' }}
                        >
                            <option value="ALL">All Levels</option>
                            <option value="UG">Undergraduate (UG)</option>
                            <option value="PG">Postgraduate (PG)</option>
                        </select>
                    </div>

                    {/* Category Type */}
                    <div>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: '600', color: '#374151', marginBottom: '8px', textTransform: 'uppercase' }}>Discipline</label>
                        <select
                            value={filterCategory}
                            onChange={(e) => setFilterCategory(e.target.value)}
                            style={{ width: '100%', padding: '10px 16px', borderRadius: '8px', border: '1px solid #E5E7EB', outline: 'none', background: '#FFFFFF', cursor: 'pointer', fontSize: '0.95rem' }}
                        >
                            <option value="ALL">All Disciplines</option>
                            <option value="BE/BTech">Engineering (B.E/B.Tech)</option>
                            <option value="ME/MTech">Engineering (M.E/M.Tech)</option>
                            <option value="MBA">Management (MBA)</option>
                            <option value="MCA">Computer Apps (MCA)</option>
                        </select>
                    </div>

                    {/* Sort */}
                    <div>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: '600', color: '#374151', marginBottom: '8px', textTransform: 'uppercase' }}>Sort By</label>
                        <select
                            value={sortBy}
                            onChange={(e) => setSortBy(e.target.value)}
                            style={{ width: '100%', padding: '10px 16px', borderRadius: '8px', border: '1px solid #E5E7EB', outline: 'none', background: '#FFFFFF', cursor: 'pointer', fontSize: '0.95rem' }}
                        >
                            <option value="NAME_ASC">Alphabetical (A-Z)</option>
                            <option value="STUDENTS_DESC">Student Count (High-Low)</option>
                            <option value="FACULTY_DESC">Faculty Count (High-Low)</option>
                        </select>
                    </div>

                </div>

                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderTop: '1px solid #E5E7EB', paddingTop: '16px' }}>
                    <span style={{ fontSize: '0.9rem', color: '#6B7280', fontWeight: '500' }}>Showing {filteredDepartments.length} Departments</span>
                    <button
                        onClick={() => { setSearchQuery(''); setFilterProgram('ALL'); setFilterCategory('ALL'); setSortBy('NAME_ASC'); }}
                        style={{ background: 'transparent', border: 'none', color: '#2563EB', fontWeight: '600', cursor: 'pointer', fontSize: '0.9rem' }}
                    >
                        Reset Filters
                    </button>
                </div>
            </div>

            {/* Content Display */}
            {loading ? (
                <div style={{ display: 'flex', justifyContent: 'center', padding: '64px', color: '#1E3A8A' }}>
                    <p style={{ fontWeight: '600' }}>Loading Departments...</p>
                </div>
            ) : filteredDepartments.length === 0 ? (
                <div style={{ textAlign: 'center', padding: '64px', background: '#FFFFFF', borderRadius: '12px', border: '1px dashed #E5E7EB' }}>
                    <p style={{ fontSize: '1.1rem', color: '#6B7280' }}>No departments found matching your criteria.</p>
                </div>
            ) : (
                <div style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(auto-fit, minmax(320px, 1fr))',
                    gap: '24px'
                }}>
                    {filteredDepartments.map((dept) => (
                        <div
                            key={dept.id}
                            style={{
                                background: '#FFFFFF',
                                border: '1px solid #E5E7EB',
                                borderRadius: '12px',
                                overflow: 'hidden',
                                transition: 'transform 0.2s, box-shadow 0.2s',
                                display: 'flex',
                                flexDirection: 'column'
                            }}
                            onMouseEnter={(e) => {
                                e.currentTarget.style.transform = 'translateY(-4px)';
                                e.currentTarget.style.boxShadow = '0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1)';
                            }}
                            onMouseLeave={(e) => {
                                e.currentTarget.style.transform = 'translateY(0)';
                                e.currentTarget.style.boxShadow = 'none';
                            }}
                        >
                            {/* Card Header */}
                            <div style={{ padding: '24px', borderBottom: '1px solid #F3F4F6', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                                <div>
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '8px' }}>
                                        <span style={{ fontSize: '1.25rem', fontWeight: '800', color: '#111827' }}>{dept.code}</span>
                                        <span style={{
                                            padding: '2px 8px',
                                            borderRadius: '4px',
                                            fontSize: '0.7rem',
                                            fontWeight: '700',
                                            background: dept.type === 'UG' ? '#E0E7FF' : '#FEF3C7',
                                            color: dept.type === 'UG' ? '#1E3A8A' : '#92400E'
                                        }}>
                                            {dept.type}
                                        </span>
                                    </div>
                                    <h3 style={{ fontSize: '1rem', fontWeight: '600', color: '#374151', margin: 0, lineHeight: '1.4' }}>{dept.name}</h3>
                                </div>
                                <div style={{ width: '48px', height: '48px', background: '#F8FAFC', borderRadius: '8px', display: 'flex', alignItems: 'center', justifyContent: 'center', border: '1px solid #E5E7EB' }}>
                                    <span style={{ fontSize: '1.5rem' }}>🏛️</span>
                                </div>
                            </div>

                            {/* Card Body (Stats) */}
                            <div style={{ padding: '24px', display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '16px' }}>
                                <div style={{ textAlign: 'center' }}>
                                    <div style={{ fontSize: '1.5rem', marginBottom: '4px' }}>🎓</div>
                                    <div style={{ fontSize: '1.25rem', fontWeight: '800', color: '#1E3A8A' }}>{dept.totalStudents || 0}</div>
                                    <div style={{ fontSize: '0.65rem', fontWeight: '700', color: '#6B7280', textTransform: 'uppercase' }}>Students</div>
                                </div>
                                <div style={{ textAlign: 'center' }}>
                                    <div style={{ fontSize: '1.5rem', marginBottom: '4px' }}>👨‍🏫</div>
                                    <div style={{ fontSize: '1.25rem', fontWeight: '800', color: '#2563EB' }}>{dept.totalFaculty || 0}</div>
                                    <div style={{ fontSize: '0.65rem', fontWeight: '700', color: '#6B7280', textTransform: 'uppercase' }}>Faculty</div>
                                </div>
                                <div style={{ textAlign: 'center' }}>
                                    <div style={{ fontSize: '1.5rem', marginBottom: '4px' }}>🧑‍💼</div>
                                    <div style={{ fontSize: '1.25rem', fontWeight: '800', color: '#059669' }}>{dept.totalStaff || 0}</div>
                                    <div style={{ fontSize: '0.65rem', fontWeight: '700', color: '#6B7280', textTransform: 'uppercase' }}>Staff</div>
                                </div>
                            </div>

                            {/* Card HOD info */}
                            <div style={{ padding: '16px 24px', background: '#F8FAFC', borderTop: '1px solid #F3F4F6', display: 'flex', alignItems: 'center', gap: '12px' }}>
                                <div style={{ width: '36px', height: '36px', borderRadius: '50%', background: dept.hodName === 'Not Assigned' ? '#FCA5A5' : '#BFDBFE', color: dept.hodName === 'Not Assigned' ? '#991B1B' : '#1E40AF', display: 'flex', alignItems: 'center', justifyContent: 'center', fontWeight: 'bold' }}>
                                    {dept.hodName === 'Not Assigned' ? '!' : dept.hodName.charAt(0)}
                                </div>
                                <div>
                                    <p style={{ margin: 0, fontSize: '0.9rem', fontWeight: '700', color: '#111827' }}>{dept.hodName}</p>
                                    <p style={{ margin: 0, fontSize: '0.75rem', color: '#6B7280' }}>Head of Department</p>
                                </div>
                            </div>

                            {/* Actions Footer */}
                            <div style={{ marginTop: 'auto', padding: '16px', borderTop: '1px solid #E5E7EB', display: 'flex', flexWrap: 'wrap', gap: '8px', background: '#FFFFFF' }}>
                                <button onClick={() => handleAction('students', dept.code)} style={{ flex: 1, padding: '8px', background: '#EFF6FF', color: '#2563EB', border: '1px solid #BFDBFE', borderRadius: '6px', fontSize: '0.8rem', fontWeight: '600', cursor: 'pointer', transition: 'all 0.2s' }} onMouseEnter={(e) => e.target.style.background = '#DBEAFE'} onMouseLeave={(e) => e.target.style.background = '#EFF6FF'}>
                                    👥 People
                                </button>
                                <button onClick={() => handleAction('academics', dept.code)} style={{ flex: 1, padding: '8px', background: '#F0FDF4', color: '#16A34A', border: '1px solid #BBF7D0', borderRadius: '6px', fontSize: '0.8rem', fontWeight: '600', cursor: 'pointer', transition: 'all 0.2s' }} onMouseEnter={(e) => e.target.style.background = '#DCFCE7'} onMouseLeave={(e) => e.target.style.background = '#F0FDF4'}>
                                    📊 Academics
                                </button>
                                <button onClick={() => handleAction('overview', dept.code)} style={{ flex: '1 1 100%', padding: '8px', background: '#1E3A8A', color: '#FFFFFF', border: 'none', borderRadius: '6px', fontSize: '0.8rem', fontWeight: '600', cursor: 'pointer', transition: 'all 0.2s' }} onMouseEnter={(e) => e.target.style.background = '#1E40AF'} onMouseLeave={(e) => e.target.style.background = '#1E3A8A'}>
                                    View Full Details →
                                </button>
                            </div>
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
};

export default DepartmentView;
