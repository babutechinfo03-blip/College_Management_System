import React, { useState, useEffect } from 'react';
import api from '../../../../services/api';

const DAYS = ['MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY'];
const HOURS = [1, 2, 3, 4, 5, 6, 7, 8];

const TimetableScheduler = () => {
    // Selection State
    const [departments, setDepartments] = useState([]);
    const [sections, setSections] = useState([]);
    const [selectedDepth, setSelectedDept] = useState('');
    const [selectedYear, setSelectedYear] = useState(1);
    const [selectedSection, setSelectedSection] = useState('');

    // Timetable Data
    const [timetable, setTimetable] = useState([]);
    const [loading, setLoading] = useState(false);

    // Assignment Modal State
    const [showModal, setShowModal] = useState(false);
    const [modalData, setModalData] = useState({ day: '', hour: 1 });
    const [facultyList, setFacultyList] = useState([]);
    const [assignForm, setAssignForm] = useState({ subjectName: '', subjectCode: '', facultyId: '' });

    // 1. Fetch Metadata
    useEffect(() => {
        const fetchMeta = async () => {
            try {
                // Fetch Scoped Faculty
                const fRes = await api.get('/hod/faculty');
                setFacultyList(fRes.data);

                // Fetch Scoped Sections
                const sRes = await api.get('/hod/sections');
                setSections(sRes.data);

                // Get My Dept info from dashboard profile to auto-set context
                const profileRes = await api.get('/staff/dashboard?activeRole=HOD');
                if (profileRes.data.profile.departmentId) {
                    setDepartments([{ id: profileRes.data.profile.departmentId, name: profileRes.data.profile.department }]);
                    setSelectedDept(profileRes.data.profile.departmentId);
                }
            } catch (err) {
                console.error("Failed to load metadata", err);
            }
        };
        fetchMeta();
    }, []);

    // 2. Fetch Timetable when Context Changes
    useEffect(() => {
        if (selectedDepth && selectedYear && selectedSection) {
            fetchTimetable();
        }
    }, [selectedDepth, selectedYear, selectedSection]);

    const fetchTimetable = async () => {
        setLoading(true);
        try {
            const res = await api.get(`/hod/timetable?departmentId=${selectedDepth}&year=${selectedYear}&sectionId=${selectedSection}`);
            setTimetable(res.data);
        } catch (err) {
            console.error(err);
        } finally {
            setLoading(false);
        }
    };

    // 3. Helper to get cell content
    const getCell = (day, hour) => {
        return timetable.find(t => t.dayOfWeek === day && t.hour === hour);
    };

    // 4. Handle Assignment
    const handleCellClick = (day, hour) => {
        setModalData({ day, hour });
        setShowModal(true);
    };

    const handleAssign = async () => {
        try {
            await api.post('/hod/timetable/entry', {
                departmentId: selectedDepth,
                year: selectedYear,
                sectionId: selectedSection,
                semester: 1, // Mock
                dayOfWeek: modalData.day,
                hour: modalData.hour,
                ...assignForm
            });
            setShowModal(false);
            fetchTimetable();
            alert('Assigned!');
        } catch (err) {
            alert('Failed: ' + (err.response?.data?.error || err.message));
        }
    };

    return (
        <div className="animate-fade-in">
            <h2 style={{ fontSize: '1.5rem', marginBottom: '2rem' }}>Weekly Timetable Scheduler</h2>

            {/* Context Selector */}
            <div className="glass-card grid" style={{ gridTemplateColumns: 'repeat(4, 1fr)', gap: '1rem', marginBottom: '2rem' }}>
                <select className="form-control" onChange={e => setSelectedDept(e.target.value)}>
                    <option value="">Select Dept</option>
                    {departments.map(d => <option key={d.id} value={d.id}>{d.name}</option>)}
                </select>
                <select className="form-control" onChange={e => setSelectedYear(e.target.value)}>
                    <option value="1">Year 1</option>
                    <option value="2">Year 2</option>
                    <option value="3">Year 3</option>
                    <option value="4">Year 4</option>
                </select>
                <select className="form-control" onChange={e => setSelectedSection(e.target.value)}>
                    <option value="">Select Section</option>
                    {sections.map(s => <option key={s.id} value={s.id}>{s.name}</option>)}
                </select>
                <button className="btn btn-outline" onClick={fetchTimetable}>Refresh Grid</button>
            </div>

            {/* Main Grid */}
            <div className="glass-card" style={{ padding: '1rem', overflowX: 'auto' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', minWidth: '800px' }}>
                    <thead>
                        <tr>
                            <th style={{ padding: '1rem', background: '#f1f5f9' }}>Day / Period</th>
                            {HOURS.map(h => <th key={h} style={{ padding: '1rem', background: '#f1f5f9' }}>{h}</th>)}
                        </tr>
                    </thead>
                    <tbody>
                        {DAYS.map(day => (
                            <tr key={day} style={{ borderBottom: '1px solid #e2e8f0' }}>
                                <td style={{ padding: '1rem', fontWeight: 'bold' }}>{day}</td>
                                {HOURS.map(h => {
                                    const entry = getCell(day, h);
                                    return (
                                        <td key={h}
                                            onClick={() => handleCellClick(day, h)}
                                            style={{
                                                padding: '0.5rem',
                                                borderLeft: '1px solid #e2e8f0',
                                                cursor: 'pointer',
                                                background: entry ? '#dbeafe' : 'transparent',
                                                textAlign: 'center',
                                                fontSize: '0.85rem'
                                            }}
                                            className="hover-bg-slate-50"
                                        >
                                            {entry ? (
                                                <div>
                                                    <div style={{ fontWeight: '700' }}>{entry.subjectCode}</div>
                                                    <div style={{ fontSize: '0.75rem', color: '#1e40af' }}>{entry.type}</div>
                                                </div>
                                            ) : (
                                                <span style={{ color: '#cbd5e1' }}>+</span>
                                            )}
                                        </td>
                                    );
                                })}
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>

            {/* Simple Modal Shim */}
            {showModal && (
                <div style={{ position: 'fixed', top: 0, left: 0, right: 0, bottom: 0, background: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000 }}>
                    <div className="glass-card" style={{ width: '400px', padding: '2rem', background: 'white' }}>
                        <h3>Assign Period: {modalData.day} - Hour {modalData.hour}</h3>
                        <div className="space-y-4" style={{ marginTop: '1.5rem' }}>
                            <input className="form-control" placeholder="Subject Name" onChange={e => setAssignForm({ ...assignForm, subjectName: e.target.value })} />
                            <input className="form-control" placeholder="Subject Code" onChange={e => setAssignForm({ ...assignForm, subjectCode: e.target.value })} />
                            <select className="form-control" onChange={e => setAssignForm({ ...assignForm, facultyId: e.target.value })}>
                                <option value="">Select Faculty</option>
                                {facultyList.map(f => <option key={f.id} value={f.id}>{f.firstName} {f.lastName}</option>)}
                            </select>
                            <div style={{ display: 'flex', gap: '1rem', marginTop: '1rem' }}>
                                <button className="btn btn-primary" onClick={handleAssign}>Save</button>
                                <button className="btn btn-secondary" onClick={() => setShowModal(false)}>Cancel</button>
                            </div>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
};

export default TimetableScheduler;
