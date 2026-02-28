import React, { useState, useEffect } from 'react';
import api from '../../../../services/api';

const StudentList = () => {
    const [students, setStudents] = useState([]);
    const [loading, setLoading] = useState(true);
    const [searchTerm, setSearchTerm] = useState('');

    useEffect(() => {
        const fetchStudents = async () => {
            try {
                const response = await api.get('/hod/students');
                setStudents(response.data);
            } catch (err) {
                console.error("Failed to fetch students", err);
            } finally {
                setLoading(false);
            }
        };
        fetchStudents();
    }, []);

    const filteredStudents = students.filter(s =>
        s.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
        s.studentId.toLowerCase().includes(searchTerm.toLowerCase())
    );

    if (loading) return <div>Loading students...</div>;

    return (
        <div className="animate-fade-in p-6">
            <div className="flex justify-between items-center mb-6">
                <div>
                    <h2 className="text-2xl font-bold">Student Management</h2>
                    <p className="text-gray-500">Total Students: {students.length}</p>
                </div>
                <div className="flex gap-4">
                    <input
                        type="text"
                        placeholder="Search by Name or ID..."
                        className="input input-bordered"
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                    />
                </div>
            </div>

            <div className="glass-card overflow-hidden">
                <table className="w-full">
                    <thead className="bg-gray-50 border-b border-gray-100">
                        <tr>
                            <th className="p-4 text-left text-sm font-semibold text-gray-600">ID</th>
                            <th className="p-4 text-left text-sm font-semibold text-gray-600">Name</th>
                            <th className="p-4 text-left text-sm font-semibold text-gray-600">Degree</th>
                            <th className="p-4 text-left text-sm font-semibold text-gray-600">Year</th>
                            <th className="p-4 text-left text-sm font-semibold text-gray-600">Semester</th>
                            <th className="p-4 text-left text-sm font-semibold text-gray-600">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        {filteredStudents.map((student) => (
                            <tr key={student.id} className="border-b border-gray-50 hover:bg-gray-50">
                                <td className="p-4 font-medium text-gray-900">{student.studentId}</td>
                                <td className="p-4 text-gray-700">{student.name}</td>
                                <td className="p-4 text-gray-600">{student.degree}</td>
                                <td className="p-4 text-gray-600">{student.year}</td>
                                <td className="p-4 text-gray-600">{student.semester}</td>
                                <td className="p-4">
                                    <span className={`px-2 py-1 rounded-full text-xs font-semibold ${student.active ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}`}>
                                        {student.active ? 'Active' : 'Inactive'}
                                    </span>
                                </td>
                            </tr>
                        ))}
                        {filteredStudents.length === 0 && (
                            <tr>
                                <td colSpan="6" className="p-8 text-center text-gray-500">No students found.</td>
                            </tr>
                        )}
                    </tbody>
                </table>
            </div>
        </div>
    );
};

export default StudentList;
