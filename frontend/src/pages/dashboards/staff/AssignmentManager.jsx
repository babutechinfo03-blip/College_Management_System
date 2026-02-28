import React, { useState } from 'react';
import axios from 'axios';

const AssignmentManager = () => {
    const [formData, setFormData] = useState({
        title: '',
        description: '',
        dueDate: '',
        sectionId: '',
        maxMarks: 100
    });
    const [loading, setLoading] = useState(false);

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        try {
            await axios.post('/api/academic/assignments', formData);
            alert('Assignment posted successfully!');
        } catch (err) {
            console.error(err);
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="glass-card animate-fade-in" style={{ padding: '2.5rem', maxWidth: '800px' }}>
            <h3 style={{ fontSize: '1.5rem', marginBottom: '2rem' }}>Create Assignment</h3>
            <form onSubmit={handleSubmit}>
                <div className="form-group" style={{ marginBottom: '1.5rem' }}>
                    <label className="form-label">Assignment Title</label>
                    <input
                        type="text"
                        className="form-control"
                        value={formData.title}
                        onChange={(e) => setFormData({ ...formData, title: e.target.value })}
                        required
                    />
                </div>
                <div className="form-group" style={{ marginBottom: '1.5rem' }}>
                    <label className="form-label">Description</label>
                    <textarea
                        className="form-control"
                        rows="4"
                        value={formData.description}
                        onChange={(e) => setFormData({ ...formData, description: e.target.value })}
                        required
                    ></textarea>
                </div>
                <div className="grid" style={{ gridTemplateColumns: '1fr 1fr', gap: '1.5rem' }}>
                    <div className="form-group">
                        <label className="form-label">Due Date</label>
                        <input
                            type="datetime-local"
                            className="form-control"
                            value={formData.dueDate}
                            onChange={(e) => setFormData({ ...formData, dueDate: e.target.value })}
                            required
                        />
                    </div>
                    <div className="form-group">
                        <label className="form-label">Max Marks</label>
                        <input
                            type="number"
                            className="form-control"
                            value={formData.maxMarks}
                            onChange={(e) => setFormData({ ...formData, maxMarks: e.target.value })}
                            required
                        />
                    </div>
                </div>
                <button type="submit" className="btn btn-primary" style={{ marginTop: '2rem' }} disabled={loading}>
                    {loading ? 'Posting...' : 'Post Assignment'}
                </button>
            </form>
        </div>
    );
};

export default AssignmentManager;
