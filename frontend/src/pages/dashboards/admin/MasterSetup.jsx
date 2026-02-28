import React, { useState, useEffect } from 'react';
import axios from 'axios';

const MasterSetup = () => {
    const [departments, setDepartments] = useState([]);
    const [newDept, setNewDept] = useState({ name: '', code: '', type: 'UG' });

    useEffect(() => {
        fetchDepartments();
    }, []);

    const fetchDepartments = async () => {
        try {
            const res = await axios.get('/api/admin/departments');
            setDepartments(res.data);
        } catch (err) {
            console.error(err);
        }
    };

    const handleCreateDept = async (e) => {
        e.preventDefault();
        try {
            await axios.post('/api/admin/departments', newDept);
            setNewDept({ name: '', code: '', type: 'UG' });
            fetchDepartments();
        } catch (err) {
            alert('Failed to create department');
        }
    };

    return (
        <div className="management-view">
            <div className="grid grid-cols-2 gap-xl">
                <div className="card">
                    <h3>Create New Department</h3>
                    <form onSubmit={handleCreateDept} className="mt-md">
                        <div className="form-group">
                            <label>Name</label>
                            <input type="text" className="form-control" value={newDept.name}
                                onChange={e => setNewDept({ ...newDept, name: e.target.value })} required />
                        </div>
                        <div className="form-group">
                            <label>Code</label>
                            <input type="text" className="form-control" value={newDept.code}
                                onChange={e => setNewDept({ ...newDept, code: e.target.value })} required />
                        </div>
                        <div className="form-group">
                            <label>Program Type</label>
                            <select className="form-control" value={newDept.type}
                                onChange={e => setNewDept({ ...newDept, type: e.target.value })}>
                                <option value="UG">Undergraduate (UG)</option>
                                <option value="PG">Postgraduate (PG)</option>
                            </select>
                        </div>
                        <button type="submit" className="btn btn-primary btn-block">Add Department</button>
                    </form>
                </div>

                <div className="card">
                    <h3>Existing Departments</h3>
                    <div className="dept-list mt-md">
                        {departments.map(dept => (
                            <div key={dept.id} className="dept-item border-bottom py-sm d-flex justify-between">
                                <div>
                                    <strong>{dept.name} ({dept.code})</strong>
                                    <p className="text-secondary text-sm">{dept.type}</p>
                                </div>
                                <button className="btn btn-sm text-error">Delete</button>
                            </div>
                        ))}
                    </div>
                </div>
            </div>
        </div>
    );
};

export default MasterSetup;
