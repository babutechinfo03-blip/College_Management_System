import React, { useState, useEffect } from 'react';
import { useParams, useSearchParams, useNavigate } from 'react-router-dom';
import api from '../../../services/api';

const DepartmentDetails = () => {
    const { departmentId } = useParams();
    const [searchParams, setSearchParams] = useSearchParams();
    const navigate = useNavigate();

    // Default to 'overview' tab if not specified
    const currentTab = searchParams.get('tab') || 'overview';

    const [department, setDepartment] = useState(null);
    const [students, setStudents] = useState([]);
    const [faculty, setFaculty] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');

    useEffect(() => {
        const fetchDepartmentData = async () => {
            try {
                setLoading(true);
                // 1. Fetch all departments and find the matching one (as there isn't a single dept endpoint explicitly detailed)
                const deptRes = await api.get('/principal/departments');
                const foundDept = deptRes.data.find(d => d.code === departmentId || d.id.toString() === departmentId);

                if (!foundDept) {
                    setError('Department not found.');
                    setLoading(false);
                    return;
                }
                setDepartment(foundDept);

                // Fetch simulated data or real data if endpoints existed
                // Note: The prompt asks to show students/faculty. We will mock the arrays for the UI demonstration 
                // based on the total counts fetched from the backend.

                const mockStudents = Array.from({ length: foundDept.totalStudents > 20 ? 20 : foundDept.totalStudents }, (_, i) => ({
                    regNo: `${foundDept.code}${2023000 + i}`,
                    name: `Student ${i + 1}`,
                    year: (i % 4) + 1,
                    section: i % 2 === 0 ? 'A' : 'B',
                    attendance: Math.floor(65 + Math.random() * 35), // 65-100%
                    internalMarks: Math.floor(50 + Math.random() * 50) // 50-100%
                }));
                setStudents(mockStudents);

                const mockFaculty = Array.from({ length: foundDept.totalFaculty > 10 ? 10 : foundDept.totalFaculty }, (_, i) => ({
                    id: `F${100 + i}`,
                    name: `Prof. Faculty ${i + 1}`,
                    designation: i === 0 ? 'HOD' : (i < 3 ? 'Associate Professor' : 'Assistant Professor'),
                    subjects: i % 2 === 0 ? 'Data Structures, Algorithms' : 'Database Systems',
                    workload: 12 + (i % 8), // 12-20 hours
                    classes: `${foundDept.code}-${(i % 4) + 1} Year`
                }));
                setFaculty(mockFaculty);

            } catch (err) {
                console.error("Failed to load department data:", err);
                setError('Failed to load department data.');
            } finally {
                setLoading(false);
            }
        };

        fetchDepartmentData();
    }, [departmentId]);

    const handleTabChange = (tab) => {
        setSearchParams({ tab });
    };

    if (loading) return <div style={{ padding: '64px', textAlign: 'center', color: '#1E3A8A', fontWeight: 'bold' }}>Loading Department Details...</div>;
    if (error) return <div style={{ padding: '64px', textAlign: 'center', color: '#DC2626', fontWeight: 'bold' }}>{error}</div>;
    if (!department) return null;

    return (
        <div className="animate-fade-in" style={{ padding: '32px 24px', minHeight: '100vh', background: '#F8FAFC' }}>

            {/* Top Navigation / Breadcrumb */}
            <div style={{ marginBottom: '24px', display: 'flex', alignItems: 'center', gap: '8px' }}>
                <button
                    onClick={() => navigate('/principal/departments')}
                    style={{ background: 'transparent', border: 'none', color: '#6B7280', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '4px', fontSize: '0.9rem', fontWeight: '600' }}
                >
                    <span style={{ fontSize: '1.2rem' }}>←</span> Back to Departments
                </button>
            </div>

            {/* Department Header Summary */}
            <div style={{ background: '#FFFFFF', padding: '32px', borderRadius: '12px', border: '1px solid #E5E7EB', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.05)', marginBottom: '32px' }}>
                <div>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '12px', marginBottom: '8px' }}>
                        <span style={{ fontSize: '2.5rem', fontWeight: '800', color: '#111827', lineHeight: '1' }}>{department.code}</span>
                        <span style={{ padding: '4px 12px', borderRadius: '6px', fontSize: '0.8rem', fontWeight: '700', background: department.type === 'UG' ? '#E0E7FF' : '#FEF3C7', color: department.type === 'UG' ? '#1E3A8A' : '#92400E' }}>
                            {department.type} Level
                        </span>
                    </div>
                    <h2 style={{ fontSize: '1.25rem', fontWeight: '600', color: '#374151', margin: '0 0 16px 0' }}>{department.name}</h2>

                    <div style={{ display: 'flex', alignItems: 'center', gap: '12px', background: '#F8FAFC', padding: '12px 16px', borderRadius: '8px', border: '1px solid #F3F4F6' }}>
                        <div style={{ width: '32px', height: '32px', borderRadius: '50%', background: department.hodName === 'Not Assigned' ? '#FCA5A5' : '#BFDBFE', color: department.hodName === 'Not Assigned' ? '#991B1B' : '#1E40AF', display: 'flex', alignItems: 'center', justifyContent: 'center', fontWeight: 'bold' }}>
                            {department.hodName === 'Not Assigned' ? '!' : department.hodName.charAt(0)}
                        </div>
                        <div>
                            <p style={{ margin: 0, fontSize: '0.9rem', fontWeight: '700', color: '#111827' }}>{department.hodName}</p>
                            <p style={{ margin: 0, fontSize: '0.75rem', color: '#6B7280' }}>Head of Department</p>
                        </div>
                    </div>
                </div>

                {/* High Level Totals */}
                <div style={{ display: 'flex', gap: '24px' }}>
                    <div style={{ textAlign: 'center', padding: '16px 24px', background: '#F8FAFC', borderRadius: '8px', border: '1px solid #E5E7EB' }}>
                        <div style={{ fontSize: '2rem', fontWeight: '800', color: '#1E3A8A', lineHeight: '1' }}>{department.totalStudents}</div>
                        <div style={{ fontSize: '0.75rem', fontWeight: '700', color: '#6B7280', textTransform: 'uppercase', marginTop: '4px' }}>Students</div>
                    </div>
                    <div style={{ textAlign: 'center', padding: '16px 24px', background: '#F8FAFC', borderRadius: '8px', border: '1px solid #E5E7EB' }}>
                        <div style={{ fontSize: '2rem', fontWeight: '800', color: '#2563EB', lineHeight: '1' }}>{department.totalFaculty}</div>
                        <div style={{ fontSize: '0.75rem', fontWeight: '700', color: '#6B7280', textTransform: 'uppercase', marginTop: '4px' }}>Faculty</div>
                    </div>
                    <div style={{ textAlign: 'center', padding: '16px 24px', background: '#F8FAFC', borderRadius: '8px', border: '1px solid #E5E7EB' }}>
                        <div style={{ fontSize: '2rem', fontWeight: '800', color: '#059669', lineHeight: '1' }}>{department.totalStaff}</div>
                        <div style={{ fontSize: '0.75rem', fontWeight: '700', color: '#6B7280', textTransform: 'uppercase', marginTop: '4px' }}>Staff</div>
                    </div>
                </div>
            </div>

            {/* Content Tabs Nav */}
            <div style={{ display: 'flex', gap: '8px', borderBottom: '2px solid #E5E7EB', marginBottom: '32px' }}>
                {['overview', 'students', 'faculty', 'academics'].map(tab => (
                    <button
                        key={tab}
                        onClick={() => handleTabChange(tab)}
                        style={{
                            padding: '12px 24px',
                            background: 'transparent',
                            border: 'none',
                            borderBottom: currentTab === tab ? '3px solid #1E3A8A' : '3px solid transparent',
                            color: currentTab === tab ? '#1E3A8A' : '#6B7280',
                            fontWeight: currentTab === tab ? '700' : '600',
                            fontSize: '0.95rem',
                            cursor: 'pointer',
                            textTransform: 'capitalize',
                            marginBottom: '-2px',
                            transition: 'all 0.2s'
                        }}
                    >
                        {tab === 'overview' ? 'Dashboard' : tab}
                    </button>
                ))}
            </div>

            {/* Tab Content Display */}
            <div style={{ background: '#FFFFFF', padding: '32px', borderRadius: '12px', border: '1px solid #E5E7EB', boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.05)' }}>

                {/* OVERVIEW TAB */}
                {currentTab === 'overview' && (
                    <div>
                        <h3 style={{ fontSize: '1.25rem', fontWeight: '700', color: '#111827', marginBottom: '24px' }}>Department Snapshot</h3>
                        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))', gap: '24px' }}>
                            <div style={{ background: '#F8FAFC', padding: '24px', borderRadius: '8px', border: '1px solid #E5E7EB' }}>
                                <p style={{ margin: '0 0 8px 0', fontSize: '0.85rem', color: '#6B7280', fontWeight: '600', textTransform: 'uppercase' }}>Avg. Attendance</p>
                                <div style={{ fontSize: '2rem', fontWeight: '800', color: '#16A34A' }}>88.4%</div>
                            </div>
                            <div style={{ background: '#F8FAFC', padding: '24px', borderRadius: '8px', border: '1px solid #E5E7EB' }}>
                                <p style={{ margin: '0 0 8px 0', fontSize: '0.85rem', color: '#6B7280', fontWeight: '600', textTransform: 'uppercase' }}>Internal Performance</p>
                                <div style={{ fontSize: '2rem', fontWeight: '800', color: '#2563EB' }}>74.2%</div>
                            </div>
                            <div style={{ background: '#F8FAFC', padding: '24px', borderRadius: '8px', border: '1px solid #E5E7EB' }}>
                                <p style={{ margin: '0 0 8px 0', fontSize: '0.85rem', color: '#6B7280', fontWeight: '600', textTransform: 'uppercase' }}>Active Semesters</p>
                                <div style={{ fontSize: '2rem', fontWeight: '800', color: '#D97706' }}>Odd (1, 3, 5, 7)</div>
                            </div>
                        </div>
                    </div>
                )}

                {/* STUDENTS TAB */}
                {currentTab === 'students' && (
                    <div>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                            <h3 style={{ fontSize: '1.25rem', fontWeight: '700', color: '#111827', margin: 0 }}>Student Roster</h3>
                            <input
                                type="text"
                                placeholder="Search by Reg No or Name..."
                                style={{ padding: '8px 16px', borderRadius: '6px', border: '1px solid #E5E7EB', width: '250px' }}
                            />
                        </div>
                        <div style={{ overflowX: 'auto' }}>
                            <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                                <thead style={{ background: '#F8FAFC', borderBottom: '2px solid #E5E7EB' }}>
                                    <tr>
                                        <th style={{ padding: '12px 16px', color: '#4B5563', fontWeight: '600', fontSize: '0.85rem' }}>Reg. Number</th>
                                        <th style={{ padding: '12px 16px', color: '#4B5563', fontWeight: '600', fontSize: '0.85rem' }}>Student Name</th>
                                        <th style={{ padding: '12px 16px', color: '#4B5563', fontWeight: '600', fontSize: '0.85rem' }}>Year & Sec</th>
                                        <th style={{ padding: '12px 16px', color: '#4B5563', fontWeight: '600', fontSize: '0.85rem' }}>Attendance</th>
                                        <th style={{ padding: '12px 16px', color: '#4B5563', fontWeight: '600', fontSize: '0.85rem' }}>Internal %</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {students.map((student, idx) => (
                                        <tr key={idx} style={{ borderBottom: '1px solid #E5E7EB', transition: 'background 0.2s' }} onMouseEnter={(e) => e.currentTarget.style.background = '#F8FAFC'} onMouseLeave={(e) => e.currentTarget.style.background = 'transparent'}>
                                            <td style={{ padding: '12px 16px', fontWeight: '600', color: '#1E3A8A' }}>{student.regNo}</td>
                                            <td style={{ padding: '12px 16px', color: '#111827', fontWeight: '500' }}>{student.name}</td>
                                            <td style={{ padding: '12px 16px', color: '#4B5563' }}>Yr {student.year} - Sec {student.section}</td>
                                            <td style={{ padding: '12px 16px' }}>
                                                <span style={{ color: student.attendance >= 85 ? '#16A34A' : student.attendance >= 75 ? '#D97706' : '#DC2626', fontWeight: '700' }}>
                                                    {student.attendance}%
                                                </span>
                                            </td>
                                            <td style={{ padding: '12px 16px', color: '#4B5563', fontWeight: '500' }}>{student.internalMarks}%</td>
                                        </tr>
                                    ))}
                                    {students.length === 0 && (
                                        <tr>
                                            <td colSpan="5" style={{ padding: '24px', textAlign: 'center', color: '#6B7280' }}>No student records found.</td>
                                        </tr>
                                    )}
                                </tbody>
                            </table>
                            {students.length > 0 && <p style={{ textAlign: 'center', fontSize: '0.8rem', color: '#9CA3AF', marginTop: '16px' }}>Showing sample of {students.length} simulated records.</p>}
                        </div>
                    </div>
                )}

                {/* FACULTY TAB */}
                {currentTab === 'faculty' && (
                    <div>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                            <h3 style={{ fontSize: '1.25rem', fontWeight: '700', color: '#111827', margin: 0 }}>Faculty Directory</h3>
                        </div>
                        <div style={{ overflowX: 'auto' }}>
                            <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                                <thead style={{ background: '#F8FAFC', borderBottom: '2px solid #E5E7EB' }}>
                                    <tr>
                                        <th style={{ padding: '12px 16px', color: '#4B5563', fontWeight: '600', fontSize: '0.85rem' }}>Name</th>
                                        <th style={{ padding: '12px 16px', color: '#4B5563', fontWeight: '600', fontSize: '0.85rem' }}>Designation</th>
                                        <th style={{ padding: '12px 16px', color: '#4B5563', fontWeight: '600', fontSize: '0.85rem' }}>Subjects Handled</th>
                                        <th style={{ padding: '12px 16px', color: '#4B5563', fontWeight: '600', fontSize: '0.85rem' }}>Workload</th>
                                        <th style={{ padding: '12px 16px', color: '#4B5563', fontWeight: '600', fontSize: '0.85rem' }}>Classes</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {faculty.map((member, idx) => (
                                        <tr key={idx} style={{ borderBottom: '1px solid #E5E7EB', transition: 'background 0.2s' }} onMouseEnter={(e) => e.currentTarget.style.background = '#F8FAFC'} onMouseLeave={(e) => e.currentTarget.style.background = 'transparent'}>
                                            <td style={{ padding: '12px 16px', fontWeight: '600', color: '#111827' }}>{member.name}</td>
                                            <td style={{ padding: '12px 16px' }}>
                                                <span style={{ background: member.designation === 'HOD' ? '#FEF3C7' : '#F3F4F6', color: member.designation === 'HOD' ? '#92400E' : '#4B5563', padding: '4px 8px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: '600' }}>
                                                    {member.designation}
                                                </span>
                                            </td>
                                            <td style={{ padding: '12px 16px', color: '#4B5563', fontSize: '0.9rem' }}>{member.subjects}</td>
                                            <td style={{ padding: '12px 16px', fontWeight: '600', color: member.workload >= 18 ? '#DC2626' : '#059669' }}>{member.workload} Hrs/Wk</td>
                                            <td style={{ padding: '12px 16px', color: '#4B5563', fontSize: '0.9rem' }}>{member.classes}</td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    </div>
                )}

                {/* ACADEMICS TAB */}
                {currentTab === 'academics' && (
                    <div>
                        <h3 style={{ fontSize: '1.25rem', fontWeight: '700', color: '#111827', marginBottom: '24px' }}>Academic Activity</h3>
                        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(2, 1fr)', gap: '24px' }}>
                            <div style={{ padding: '24px', background: '#F8FAFC', borderRadius: '8px', border: '1px solid #E5E7EB' }}>
                                <h4 style={{ fontSize: '1rem', fontWeight: '700', color: '#111827', margin: '0 0 16px 0' }}>Timetable Status</h4>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                                    <div style={{ width: '12px', height: '12px', borderRadius: '50%', background: '#10B981' }}></div>
                                    <span style={{ fontWeight: '500', color: '#374151' }}>Fully Allocated (100%)</span>
                                </div>
                                <p style={{ fontSize: '0.85rem', color: '#6B7280', margin: '8px 0 0 24px' }}>All sections have verified timetables.</p>
                            </div>
                            <div style={{ padding: '24px', background: '#F8FAFC', borderRadius: '8px', border: '1px solid #E5E7EB' }}>
                                <h4 style={{ fontSize: '1rem', fontWeight: '700', color: '#111827', margin: '0 0 16px 0' }}>Internal Marks Upload</h4>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                                    <div style={{ width: '12px', height: '12px', borderRadius: '50%', background: '#F59E0B' }}></div>
                                    <span style={{ fontWeight: '500', color: '#374151' }}>InProgress (CA 1)</span>
                                </div>
                                <p style={{ fontSize: '0.85rem', color: '#6B7280', margin: '8px 0 0 24px' }}>Pending submissions from 4 faculty members.</p>
                            </div>
                        </div>
                    </div>
                )}
            </div>
        </div>
    );
};

export default DepartmentDetails;
