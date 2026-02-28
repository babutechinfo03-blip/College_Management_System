import React, { useState, useEffect } from 'react';
import axios from 'axios';

const StudentManagement = () => {
    const [students, setStudents] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchStudents = async () => {
            try {
                const res = await axios.get('/api/admin/students');
                setStudents(res.data);
            } catch (err) {
                console.error('Failed to fetch students', err);
            } finally {
                setLoading(false);
            }
        };
        fetchStudents();
    }, []);

    if (loading) return <div>Loading Student Registry...</div>;

    return (
        <div className="management-view">
            <div className="view-header">
                <h3>Student Registry</h3>
                <div className="view-actions">
                    <button className="btn btn-outline">Export PDF</button>
                    <button className="btn btn-primary">Enroll New Student</button>
                </div>
            </div>

            <table className="admin-table">
                <thead>
                    <tr>
                        <th>Enrollment ID</th>
                        <th>Name</th>
                        <th>Department</th>
                        <th>Current Sem</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    {students.map(student => (
                        <tr key={student.id}>
                            <td>{student.studentId}</td>
                            <td>{`${student.firstName} ${student.lastName || ''}`}</td>
                            <td>{student.department?.name}</td>
                            <td>Sem {student.currentSemester}</td>
                            <td>
                                <button className="btn btn-sm">Performance</button>
                                <button className="btn btn-sm btn-outline">Attendance</button>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default StudentManagement;
