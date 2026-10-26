import React, { useState, useEffect } from 'react';
import api from '../../../services/api';
import { useAuth } from '../../../context/AuthContext';
import './CircularManager.css';

const CircularManager = () => {
    const { user } = useAuth();
    const [circulars, setCirculars] = useState([]);
    const [loading, setLoading] = useState(true);
    const [formData, setFormData] = useState({
        title: '',
        content: '',
        type: 'GENERAL',
        priority: 'NORMAL',
        requiresAcknowledgement: false,
        targets: [{ targetRole: 'ALL', departmentId: '', year: '', semester: '', sectionId: '' }]
    });

    const [departments, setDepartments] = useState([]);
    const [sections, setSections] = useState([]);
    const [submitting, setSubmitting] = useState(false);
    const [message, setMessage] = useState({ text: '', type: '' });

    useEffect(() => {
        fetchInitialData();
    }, []);

    const fetchInitialData = async () => {
        setLoading(true);
        try {
            const [feedRes, deptsRes, sectionsRes] = await Promise.all([
                api.get('/circulars/feed'),
                api.get('/office/departments?type=UG'), // Simplification for now
                api.get('/hod/sections') // Will get sections if HOD
            ]);
            setCirculars(feedRes.data || []);
            setDepartments(deptsRes.data || []);
            // Sections response might fail if not HOD, gracefully ignore
            setSections(sectionsRes?.data || []);
        } catch (error) {
            console.error("Error fetching dependencies", error);
        } finally {
            setLoading(false);
        }
    };

    const handleFormChange = (e) => {
        const { name, value, type, checked } = e.target;
        setFormData(prev => ({
            ...prev,
            [name]: type === 'checkbox' ? checked : value
        }));
    };

    const handleTargetChange = (index, field, value) => {
        const newTargets = [...formData.targets];
        newTargets[index] = { ...newTargets[index], [field]: value };
        setFormData(prev => ({ ...prev, targets: newTargets }));
    };

    const addTarget = () => {
        setFormData(prev => ({
            ...prev,
            targets: [...prev.targets, { targetRole: 'ALL', departmentId: '', year: '', semester: '', sectionId: '' }]
        }));
    };

    const removeTarget = (index) => {
        setFormData(prev => ({
            ...prev,
            targets: prev.targets.filter((_, i) => i !== index)
        }));
    };

    const submitCircular = async (e) => {
        e.preventDefault();
        setSubmitting(true);
        setMessage({ text: '', type: '' });
        try {
            // Clean up empty targets
            const cleanedTargets = formData.targets.map(t => ({
                targetRole: t.targetRole,
                departmentId: t.departmentId ? parseInt(t.departmentId) : null,
                year: t.year ? parseInt(t.year) : null,
                semester: t.semester ? parseInt(t.semester) : null,
                sectionId: t.sectionId ? parseInt(t.sectionId) : null
            }));

            const payload = {
                circular: {
                    title: formData.title,
                    content: formData.content,
                    type: formData.type,
                    priority: formData.priority,
                    requiresAcknowledgement: formData.requiresAcknowledgement,
                    createdRole: user.role === 'ROLE_STAFF' && user.staffRoles.includes('HOD') ? 'HOD' :
                        user.role === 'ROLE_STAFF' && user.staffRoles.includes('OFFICE') ? 'OFFICE' :
                            user.role === 'ROLE_STAFF' ? 'FACULTY' : 'PRINCIPAL'
                },
                targets: cleanedTargets
            };

            const jsonStr = JSON.stringify(payload);
            const dataForm = new FormData();

            dataForm.append('data', new Blob([jsonStr], { type: 'application/json' }));

            // Note: In a real app we'd append the file: 
            // if (file) dataForm.append('file', file);

            const response = await api.post('/circulars', dataForm, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            });

            setMessage({ text: `Circular published successfully! Status: ${response.data.status}`, type: 'success' });
            setFormData({
                title: '', content: '', type: 'GENERAL', priority: 'NORMAL', requiresAcknowledgement: false,
                targets: [{ targetRole: 'ALL', departmentId: '', year: '', semester: '', sectionId: '' }]
            });
            fetchInitialData();

        } catch (error) {
            console.error(error);
            setMessage({ text: 'Failed to publish circular. ' + (error.response?.data?.message || ''), type: 'error' });
        } finally {
            setSubmitting(false);
        }
    };

    const getStatusBadge = (status) => {
        const map = {
            'APPROVED': 'badge-success',
            'PENDING_APPROVAL': 'badge-warning',
            'DRAFT': 'badge-secondary',
            'REJECTED': 'badge-danger'
        };
        return `badge ${map[status] || 'badge-primary'}`;
    };

    const getPriorityBadge = (prio) => {
        if (prio === 'HIGH' || prio === 'URGENT') return 'badge badge-danger';
        return 'badge badge-secondary';
    };

    if (loading) return <div>Loading Circular system...</div>;

    return (
        <div className="circular-manager animate-fade-in">
            <header style={{ marginBottom: '2rem' }}>
                <h1 style={{ fontSize: '2rem', color: 'var(--slate-900)' }}>Institutional Circulars</h1>
                <p style={{ color: 'var(--text-secondary)' }}>Publish announcements or manage incoming circulars.</p>
            </header>

            <div className="grid" style={{ gridTemplateColumns: '1fr 1.5fr', gap: '2rem' }}>

                {/* Creation Form */}
                <div className="glass-card" style={{ padding: '2rem' }}>
                    <h3 style={{ marginBottom: '1.5rem', fontSize: '1.25rem' }}>Draft New Circular</h3>

                    {message.text && (
                        <div className={`alert alert-${message.type}`} style={{ padding: '1rem', borderRadius: '0.5rem', marginBottom: '1rem', background: message.type === 'success' ? '#dcfce7' : '#fee2e2', color: message.type === 'success' ? '#166534' : '#991b1b' }}>
                            {message.text}
                        </div>
                    )}

                    <form onSubmit={submitCircular} className="space-y-4">
                        <div className="form-group">
                            <label>Title</label>
                            <input type="text" className="input" name="title" value={formData.title} onChange={handleFormChange} required placeholder="E.g. Internal Exam Timetable" />
                        </div>

                        <div className="grid grid-cols-2 gap-4">
                            <div className="form-group">
                                <label>Circular Type</label>
                                <select className="input" name="type" value={formData.type} onChange={handleFormChange}>
                                    <option value="GENERAL">General Announcement</option>
                                    <option value="TIMETABLE">Timetable Update</option>
                                    <option value="EXAM">Exam Notification</option>
                                    <option value="HOLIDAY">Holiday</option>
                                    <option value="FEE">Fee Due Notice</option>
                                    <option value="ALERT">Urgent Alert</option>
                                </select>
                            </div>
                            <div className="form-group">
                                <label>Priority</label>
                                <select className="input" name="priority" value={formData.priority} onChange={handleFormChange}>
                                    <option value="LOW">Low</option>
                                    <option value="NORMAL">Normal</option>
                                    <option value="HIGH">High</option>
                                    <option value="URGENT">Urgent</option>
                                </select>
                            </div>
                        </div>

                        <div className="form-group">
                            <label>Content</label>
                            <textarea className="input" name="content" value={formData.content} onChange={handleFormChange} rows={5} required placeholder="Detailed message..."></textarea>
                        </div>

                        <div className="form-group" style={{ background: '#f8fafc', padding: '1rem', borderRadius: '0.5rem', border: '1px solid #e2e8f0' }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1rem' }}>
                                <label style={{ margin: 0, fontWeight: '700' }}>Target Audience</label>
                                <button type="button" onClick={addTarget} className="btn btn-secondary btn-xs">+ Add Target</button>
                            </div>

                            {formData.targets.map((target, idx) => (
                                <div key={idx} style={{ display: 'flex', gap: '0.5rem', marginBottom: '0.5rem', alignItems: 'center' }}>
                                    <select className="input" value={target.targetRole} onChange={(e) => handleTargetChange(idx, 'targetRole', e.target.value)}>
                                        <option value="ALL">All Roles</option>
                                        <option value="STUDENT">Students</option>
                                        <option value="FACULTY">Faculty</option>
                                        <option value="HOD">HODs</option>
                                    </select>
                                    <select className="input" value={target.departmentId} onChange={(e) => handleTargetChange(idx, 'departmentId', e.target.value)}>
                                        <option value="">All Departments</option>
                                        {departments.map(d => <option key={d.id} value={d.id}>{d.name}</option>)}
                                    </select>
                                    <select className="input" value={target.year} onChange={(e) => handleTargetChange(idx, 'year', e.target.value)}>
                                        <option value="">All Years</option>
                                        <option value="1">Year 1</option>
                                        <option value="2">Year 2</option>
                                        <option value="3">Year 3</option>
                                        <option value="4">Year 4</option>
                                    </select>
                                    {formData.targets.length > 1 && (
                                        <button type="button" onClick={() => removeTarget(idx)} style={{ color: '#ef4444', background: 'none', border: 'none', cursor: 'pointer', fontSize: '1.25rem' }}>×</button>
                                    )}
                                </div>
                            ))}
                        </div>

                        <div className="form-group" style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                            <input type="checkbox" id="ack" name="requiresAcknowledgement" checked={formData.requiresAcknowledgement} onChange={handleFormChange} style={{ width: 'auto', transform: 'scale(1.2)' }} />
                            <label htmlFor="ack" style={{ margin: 0 }}>Require read acknowledgement</label>
                        </div>

                        <button type="submit" className="btn btn-primary" style={{ width: '100%' }} disabled={submitting}>
                            {submitting ? 'Publishing...' : 'Publish Circular'}
                        </button>
                    </form>
                </div>

                {/* Feed View */}
                <div className="glass-card" style={{ padding: '2rem' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
                        <h3 style={{ fontSize: '1.25rem' }}>Your Active Circulars</h3>
                        <span className="badge badge-primary">{circulars.length} Active</span>
                    </div>

                    <div className="space-y-4">
                        {circulars.length === 0 ? (
                            <div style={{ textAlign: 'center', padding: '3rem', color: 'var(--text-muted)' }}>
                                <span style={{ fontSize: '2rem', display: 'block', marginBottom: '1rem' }}>📭</span>
                                <p>No active circulars found for your role.</p>
                            </div>
                        ) : (
                            circulars.map(circular => (
                                <div key={circular.id} style={{
                                    padding: '1.5rem',
                                    background: '#f8fafc',
                                    borderRadius: '0.75rem',
                                    borderLeft: `4px solid ${circular.priority === 'HIGH' || circular.priority === 'URGENT' ? '#ef4444' : 'var(--primary)'}`
                                }}>
                                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '0.75rem' }}>
                                        <div>
                                            <h4 style={{ fontSize: '1.1rem', fontWeight: '700', color: 'var(--slate-900)' }}>{circular.title}</h4>
                                            <div style={{ display: 'flex', gap: '0.5rem', marginTop: '0.25rem' }}>
                                                <span className={getStatusBadge(circular.status)} style={{ fontSize: '0.7rem' }}>{circular.status}</span>
                                                <span className={getPriorityBadge(circular.priority)} style={{ fontSize: '0.7rem' }}>{circular.priority}</span>
                                                <span className="badge badge-secondary" style={{ fontSize: '0.7rem' }}>{circular.type}</span>
                                            </div>
                                        </div>
                                        <p style={{ fontSize: '0.8rem', color: 'var(--text-muted)' }}>
                                            {new Date(circular.createdAt).toLocaleDateString()}
                                        </p>
                                    </div>
                                    <p style={{ color: 'var(--slate-700)', fontSize: '0.95rem', lineHeight: '1.5', whiteSpace: 'pre-wrap' }}>
                                        {circular.content}
                                    </p>
                                    <div style={{ marginTop: '1rem', paddingTop: '1rem', borderTop: '1px solid #e2e8f0', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                                        <p style={{ fontSize: '0.85rem', color: 'var(--text-secondary)' }}>
                                            From: <span style={{ fontWeight: '600' }}>{circular.createdBy?.username} ({circular.createdRole})</span>
                                        </p>
                                        {circular.requiresAcknowledgement && (
                                            <button className="btn btn-secondary btn-xs" onClick={() => api.post(`/circulars/${circular.id}/acknowledge`).then(fetchInitialData)}>Acknowledge</button>
                                        )}
                                    </div>
                                </div>
                            ))
                        )}
                    </div>
                </div>

            </div>
        </div>
    );
};

export default CircularManager;
