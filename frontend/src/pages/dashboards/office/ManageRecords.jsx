import React, { useState } from 'react';
import StudentManagement from './StudentManagement.jsx';
import FacultyManagement from './FacultyManagement.jsx';
import AssistantStaffManagement from './AssistantStaffManagement.jsx';

const ManageRecords = () => {
    const [activeTab, setActiveTab] = useState('students');

    return (
        <div>
            {/* Tab Navigation */}
            <div style={{
                display: 'flex',
                gap: '1rem',
                marginBottom: '2rem',
                borderBottom: '2px solid var(--slate-200)'
            }}>
                <button
                    onClick={() => setActiveTab('students')}
                    style={{
                        padding: '1rem 2rem',
                        background: 'none',
                        border: 'none',
                        borderBottom: activeTab === 'students' ? '3px solid var(--primary)' : '3px solid transparent',
                        color: activeTab === 'students' ? 'var(--primary)' : 'var(--text-secondary)',
                        fontWeight: '700',
                        fontSize: '1rem',
                        cursor: 'pointer',
                        transition: 'all 0.3s ease',
                        marginBottom: '-2px'
                    }}
                >
                    👨‍🎓 Students
                </button>
                <button
                    onClick={() => setActiveTab('faculty')}
                    style={{
                        padding: '1rem 2rem',
                        background: 'none',
                        border: 'none',
                        borderBottom: activeTab === 'faculty' ? '3px solid var(--primary)' : '3px solid transparent',
                        color: activeTab === 'faculty' ? 'var(--primary)' : 'var(--text-secondary)',
                        fontWeight: '700',
                        fontSize: '1rem',
                        cursor: 'pointer',
                        transition: 'all 0.3s ease',
                        marginBottom: '-2px'
                    }}
                >
                    👨‍🏫 Faculty
                </button>
                <button
                    onClick={() => setActiveTab('assistant')}
                    style={{
                        padding: '1rem 2rem',
                        background: 'none',
                        border: 'none',
                        borderBottom: activeTab === 'assistant' ? '3px solid var(--primary)' : '3px solid transparent',
                        color: activeTab === 'assistant' ? 'var(--primary)' : 'var(--text-secondary)',
                        fontWeight: '700',
                        fontSize: '1rem',
                        cursor: 'pointer',
                        transition: 'all 0.3s ease',
                        marginBottom: '-2px'
                    }}
                >
                    👥 Assistant Staff
                </button>
            </div>

            {/* Tab Content */}
            <div className="animate-fade-in">
                {activeTab === 'students' ? <StudentManagement /> :
                    activeTab === 'faculty' ? <FacultyManagement /> :
                        <AssistantStaffManagement />}
            </div>
        </div>
    );
};

export default ManageRecords;
