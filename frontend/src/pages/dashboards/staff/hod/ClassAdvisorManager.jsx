import React, { useState, useEffect } from 'react';
import api from '../../../../services/api';

const ClassAdvisorManager = () => {
    const [sections, setSections] = useState([]);
    const [facultyList, setFacultyList] = useState([]);
    const [loading, setLoading] = useState(false);

    // Assignment State
    const [selectedSection, setSelectedSection] = useState(null);
    const [selectedFaculty, setSelectedFaculty] = useState('');

    useEffect(() => {
        fetchData();
    }, []);

    const fetchData = async () => {
        try {
            const [sRes, fRes] = await Promise.all([
                api.get('/hod/sections'),
                api.get('/hod/faculty')
            ]);
            setSections(sRes.data);
            setFacultyList(fRes.data);
        } catch (err) {
            console.error("Failed to load data", err);
        }
    };

    const handleAssign = async (sectionId) => {
        if (!selectedFaculty) {
            alert("Please select a faculty member first");
            return;
        }

        setLoading(true);
        try {
            await api.post('/hod/assign-advisor', {
                sectionId: sectionId,
                facultyId: selectedFaculty
            });
            alert("Class Advisor Assigned Successfully");
            fetchData();
            setSelectedSection(null);
            setSelectedFaculty('');
        } catch (err) {
            alert("Failed: " + (err.response?.data?.error || err.message));
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="animate-fade-in">
            <h2 style={{ fontSize: '1.5rem', marginBottom: '2rem' }}>Class Advisor Management</h2>

            <div className="glass-card" style={{ padding: 0 }}>
                <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                    <thead style={{ background: '#f8fafc' }}>
                        <tr>
                            <th style={{ padding: '1rem', textAlign: 'left' }}>Class / Section</th>
                            <th style={{ padding: '1rem', textAlign: 'left' }}>Current Advisor</th>
                            <th style={{ padding: '1rem', textAlign: 'left' }}>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        {sections.map(section => (
                            <tr key={section.id} style={{ borderBottom: '1px solid var(--border)' }}>
                                <td style={{ padding: '1rem' }}>
                                    <span style={{ fontWeight: '600' }}>{section.name}</span>
                                    <div style={{ fontSize: '0.85rem', color: '#64748b' }}>
                                        Year {section.year} - Sem {section.semester}
                                    </div>
                                </td>
                                <td style={{ padding: '1rem' }}>
                                    {section.classAdvisor !== "Not Assigned" ? (
                                        <span className="badge badge-success">{section.classAdvisor}</span>
                                    ) : (
                                        <span className="badge badge-warning">Unassigned</span>
                                    )}
                                </td>
                                <td style={{ padding: '1rem' }}>
                                    <div style={{ display: 'flex', gap: '0.5rem' }}>
                                        <select
                                            className="form-control"
                                            style={{ padding: '0.25rem', fontSize: '0.9rem', width: '200px' }}
                                            value={selectedSection === section.id ? selectedFaculty : ''}
                                            onChange={(e) => {
                                                setSelectedSection(section.id);
                                                setSelectedFaculty(e.target.value);
                                            }}
                                        >
                                            <option value="">Select Faculty...</option>
                                            {facultyList.map(f => (
                                                <option key={f.id} value={f.id}>
                                                    {f.firstName} {f.lastName}
                                                </option>
                                            ))}
                                        </select>
                                        <button
                                            className="btn btn-primary"
                                            style={{ padding: '0.25rem 0.75rem', fontSize: '0.9rem' }}
                                            disabled={loading || selectedSection !== section.id || !selectedFaculty}
                                            onClick={() => handleAssign(section.id)}
                                        >
                                            Assign
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
                {sections.length === 0 && (
                    <div style={{ padding: '2rem', textAlign: 'center', color: '#64748b' }}>
                        No sections found for your department.
                    </div>
                )}
            </div>
        </div>
    );
};

export default ClassAdvisorManager;
