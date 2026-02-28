import React, { useState, useEffect } from 'react';
import axios from 'axios';

const DepartmentView = () => {
    const [departments, setDepartments] = useState([]);
    const [filteredDepartments, setFilteredDepartments] = useState([]);
    const [loading, setLoading] = useState(true);
    const [filterType, setFilterType] = useState('ALL'); // ALL, UG, PG
    const [searchQuery, setSearchQuery] = useState('');

    useEffect(() => {
        fetchDepartments();
    }, []);

    useEffect(() => {
        let result = departments;

        // Filter by Program Type
        if (filterType !== 'ALL') {
            result = result.filter(dept => dept.type === filterType);
        }

        // Filter by Search Query
        if (searchQuery) {
            const query = searchQuery.toLowerCase();
            result = result.filter(dept =>
                dept.name.toLowerCase().includes(query) ||
                dept.code.toLowerCase().includes(query)
            );
        }

        setFilteredDepartments(result);
    }, [departments, filterType, searchQuery]);

    const fetchDepartments = async () => {
        try {
            const response = await axios.get('/api/principal/departments');
            setDepartments(response.data);
            setFilteredDepartments(response.data);
            setLoading(false);
        } catch (err) {
            console.error('Error fetching departments:', err);
            setLoading(false);
        }
    };

    const getProgramColor = (type) => {
        return type === 'UG' ? 'var(--info)' : 'var(--warning)';
    };

    return (
        <div className="animate-fade-in p-6">
            <div className="flex justify-between items-center mb-6">
                <div>
                    <h2 className="text-2xl font-bold" style={{ color: 'var(--text-main)' }}>Department Overview</h2>
                    <p style={{ color: 'var(--text-secondary)' }}>Manage academic departments and leadership</p>
                </div>

                <div className="flex gap-4">
                    <select
                        className="p-2 rounded border"
                        style={{ background: 'var(--bg-card)', color: 'var(--text-main)', borderColor: 'var(--border)' }}
                        value={filterType}
                        onChange={(e) => setFilterType(e.target.value)}
                    >
                        <option value="ALL">All Programs</option>
                        <option value="UG">UG (Undergraduate)</option>
                        <option value="PG">PG (Postgraduate)</option>
                    </select>

                    <input
                        type="text"
                        placeholder="Search departments..."
                        className="p-2 rounded border"
                        style={{ background: 'var(--bg-card)', color: 'var(--text-main)', borderColor: 'var(--border)' }}
                        value={searchQuery}
                        onChange={(e) => setSearchQuery(e.target.value)}
                    />
                </div>
            </div>

            {loading ? (
                <div style={{ color: 'var(--text-secondary)' }}>Loading department data...</div>
            ) : (
                <div className="grid gap-6" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(350px, 1fr))', gap: '1.5rem' }}>
                    {filteredDepartments.map(dept => (
                        <div key={dept.id} className="card p-6" style={{ background: 'var(--bg-card)', border: '1px solid var(--border)', borderRadius: 'var(--radius)', position: 'relative', overflow: 'hidden', padding: '1.5rem', boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)' }}>
                            <div style={{ position: 'absolute', top: 0, left: 0, width: '4px', height: '100%', background: getProgramColor(dept.type) }}></div>

                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'start', marginBottom: '1.5rem' }}>
                                <div>
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', marginBottom: '0.25rem' }}>
                                        <h3 className="text-xl font-bold" style={{ color: 'var(--text-main)', margin: 0 }}>{dept.code}</h3>
                                        <span style={{
                                            fontSize: '0.7rem',
                                            padding: '2px 6px',
                                            borderRadius: '4px',
                                            background: getProgramColor(dept.type),
                                            color: 'white',
                                            fontWeight: 'bold'
                                        }}>
                                            {dept.type}
                                        </span>
                                    </div>
                                    <p style={{ color: 'var(--text-secondary)', fontSize: '0.9rem', lineHeight: '1.2' }}>{dept.name}</p>
                                </div>
                                <div style={{ background: 'var(--bg-main)', padding: '0.5rem', borderRadius: '8px' }}>
                                    <span style={{ fontSize: '1.5rem' }}>🏛️</span>
                                </div>
                            </div>

                            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: '1rem', marginBottom: '1.5rem' }}>
                                <div style={{ textAlign: 'center', padding: '0.5rem', background: 'var(--bg-main)', borderRadius: '8px' }}>
                                    <div style={{ fontSize: '1.25rem', fontWeight: 'bold', color: 'var(--primary)' }}>{dept.totalStudents}</div>
                                    <div style={{ fontSize: '0.7rem', color: 'var(--text-muted)' }}>STUDENTS</div>
                                </div>
                                <div style={{ textAlign: 'center', padding: '0.5rem', background: 'var(--bg-main)', borderRadius: '8px' }}>
                                    <div style={{ fontSize: '1.25rem', fontWeight: 'bold', color: 'var(--success)' }}>{dept.totalFaculty}</div>
                                    <div style={{ fontSize: '0.7rem', color: 'var(--text-muted)' }}>FACULTY</div>
                                </div>
                                <div style={{ textAlign: 'center', padding: '0.5rem', background: 'var(--bg-main)', borderRadius: '8px' }}>
                                    <div style={{ fontSize: '1.25rem', fontWeight: 'bold', color: 'var(--info)' }}>{dept.totalStaff}</div>
                                    <div style={{ fontSize: '0.7rem', color: 'var(--text-muted)' }}>STAFF</div>
                                </div>
                            </div>

                            <div style={{ padding: '1rem', background: 'var(--bg-main)', borderRadius: '8px', border: '1px solid var(--border)' }}>
                                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '0.5rem' }}>
                                    <span style={{ fontSize: '0.75rem', color: 'var(--text-muted)', fontWeight: 'bold', textTransform: 'uppercase' }}>Head of Department</span>
                                    {dept.hodId && <span style={{ fontSize: '0.75rem', color: 'var(--success)' }}>● Active</span>}
                                </div>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
                                    <div style={{
                                        width: '36px',
                                        height: '36px',
                                        borderRadius: '50%',
                                        background: dept.hodName === 'Not Assigned' ? 'var(--text-muted)' : 'var(--primary)',
                                        display: 'flex',
                                        alignItems: 'center',
                                        justifyContent: 'center',
                                        color: 'white',
                                        fontWeight: 'bold',
                                        fontSize: '0.9rem'
                                    }}>
                                        {dept.hodName === 'Not Assigned' ? '?' : dept.hodName.charAt(0)}
                                    </div>
                                    <div>
                                        <p style={{ color: 'var(--text-main)', fontWeight: '600', fontSize: '0.9rem', margin: 0 }}>
                                            {dept.hodName}
                                        </p>
                                        <p style={{ color: 'var(--text-secondary)', fontSize: '0.75rem', margin: 0 }}>
                                            {dept.hodName === 'Not Assigned' ? 'Action Required' : ' Department Lead'}
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
};

export default DepartmentView;
