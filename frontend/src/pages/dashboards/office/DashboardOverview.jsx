import React from 'react';
import { useNavigate } from 'react-router-dom';
import { useOffice } from '../../../context/OfficeContext';

const DashboardOverview = () => {
    const navigate = useNavigate();
    const { stats, activities, loading } = useOffice();

    const statCards = [
        {
            title: 'Total Students',
            value: stats.totalStudents,
            icon: '👨‍🎓',
            color: '#3b82f6',
            bgColor: 'rgba(59, 130, 246, 0.1)'
        },
        {
            title: 'Total Faculty',
            value: stats.totalFaculty,
            icon: '👨‍🏫',
            color: '#10b981',
            bgColor: 'rgba(16, 185, 129, 0.1)'
        },
        {
            title: 'Assistant Staff',
            value: stats.totalAssistants,
            icon: '👥',
            color: '#f59e0b',
            bgColor: 'rgba(245, 158, 11, 0.1)'
        }
    ];

    const quickActions = [
        {
            title: 'Add Student',
            description: 'Register new student with academic details',
            icon: '➕',
            color: '#3b82f6',
            path: '/office/add-student'
        },
        {
            title: 'Add Faculty',
            description: 'Create faculty account with role assignment',
            icon: '➕',
            color: '#10b981',
            path: '/office/add-staff'
        },
        {
            title: 'Add Assistant Staff',
            description: 'Register lab/office assistants',
            icon: '👥',
            color: '#f59e0b',
            path: '/office/add-assistant-staff'
        },
        {
            title: 'Manage Records',
            description: 'View and edit student/faculty/staff',
            icon: '📋',
            color: '#8b5cf6',
            path: '/office/manage-records'
        }
    ];

    return (
        <div style={{ paddingBottom: '2rem' }}>
            {/* Stats Cards */}
            <div style={{
                display: 'grid',
                gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))',
                gap: '1.5rem',
                marginBottom: '2rem'
            }}>
                {statCards.map((stat, index) => (
                    <div
                        key={index}
                        className="card animate-fade-in"
                        style={{
                            animationDelay: `${index * 0.1}s`,
                            background: 'white',
                            borderLeft: `4px solid ${stat.color}`,
                            transition: 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)'
                        }}
                        onMouseEnter={(e) => {
                            e.currentTarget.style.transform = 'translateY(-4px)';
                            e.currentTarget.style.boxShadow = '0 12px 24px rgba(0,0,0,0.1)';
                        }}
                        onMouseLeave={(e) => {
                            e.currentTarget.style.transform = 'translateY(0)';
                            e.currentTarget.style.boxShadow = '0 2px 8px rgba(0,0,0,0.05)';
                        }}
                    >
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                            <div>
                                <p style={{
                                    fontSize: '0.875rem',
                                    color: 'var(--text-secondary)',
                                    marginBottom: '0.5rem',
                                    fontWeight: '600'
                                }}>
                                    {stat.title}
                                </p>
                                <p style={{
                                    fontSize: '2rem',
                                    fontWeight: '700',
                                    color: stat.color,
                                    margin: 0
                                }}>
                                    {loading ? '...' : stat.value}
                                </p>
                            </div>
                            <div style={{
                                fontSize: '3rem',
                                background: stat.bgColor,
                                width: '80px',
                                height: '80px',
                                display: 'flex',
                                alignItems: 'center',
                                justifyContent: 'center',
                                borderRadius: '12px'
                            }}>
                                {stat.icon}
                            </div>
                        </div>
                    </div>
                ))}
            </div>

            {/* Quick Actions */}
            <div style={{ marginBottom: '2rem' }}>
                <h3 style={{
                    fontSize: '1.25rem',
                    fontWeight: '700',
                    color: 'var(--slate-900)',
                    marginBottom: '1rem'
                }}>
                    Quick Actions
                </h3>
                <div style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))',
                    gap: '1.5rem'
                }}>
                    {quickActions.map((action, index) => (
                        <div
                            key={index}
                            className="card animate-fade-in"
                            style={{
                                animationDelay: `${(index + 3) * 0.1}s`,
                                cursor: 'pointer',
                                transition: 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
                                borderTop: `3px solid ${action.color}`
                            }}
                            onClick={() => navigate(action.path)}
                            onMouseEnter={(e) => {
                                e.currentTarget.style.transform = 'translateY(-4px)';
                                e.currentTarget.style.boxShadow = '0 12px 24px rgba(0,0,0,0.1)';
                            }}
                            onMouseLeave={(e) => {
                                e.currentTarget.style.transform = 'translateY(0)';
                                e.currentTarget.style.boxShadow = '0 2px 8px rgba(0,0,0,0.05)';
                            }}
                        >
                            <div style={{ display: 'flex', alignItems: 'flex-start', gap: '1rem' }}>
                                <div style={{
                                    fontSize: '2rem',
                                    background: `${action.color}15`,
                                    width: '60px',
                                    height: '60px',
                                    display: 'flex',
                                    alignItems: 'center',
                                    justifyContent: 'center',
                                    borderRadius: '12px',
                                    flexShrink: 0
                                }}>
                                    {action.icon}
                                </div>
                                <div>
                                    <h4 style={{
                                        fontSize: '1.125rem',
                                        fontWeight: '700',
                                        color: 'var(--slate-900)',
                                        marginBottom: '0.25rem'
                                    }}>
                                        {action.title}
                                    </h4>
                                    <p style={{
                                        fontSize: '0.875rem',
                                        color: 'var(--text-secondary)',
                                        margin: 0
                                    }}>
                                        {action.description}
                                    </p>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>
            </div>

            {/* Recent Activity */}
            <div className="card animate-fade-in" style={{ animationDelay: '0.6s' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
                    <h3 style={{
                        fontSize: '1.25rem',
                        fontWeight: '700',
                        color: 'var(--slate-900)',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '0.5rem',
                        margin: 0
                    }}>
                        <span style={{ fontSize: '1.5rem' }}>⚡</span>
                        Recent Activity
                    </h3>
                    <span style={{ fontSize: '0.75rem', color: 'var(--text-muted)', fontWeight: '600', textTransform: 'uppercase' }}>
                        Live Updates
                    </span>
                </div>

                <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
                    {loading ? (
                        <div style={{ textAlign: 'center', padding: '2rem', color: 'var(--text-secondary)' }}>Loading activity...</div>
                    ) : activities.length === 0 ? (
                        <div style={{ textAlign: 'center', padding: '2rem', color: 'var(--text-secondary)', background: 'var(--slate-50)', borderRadius: '8px' }}>
                            No recent activity recorded.
                        </div>
                    ) : (
                        activities.slice(0, 10).map((activity, idx) => (
                            <div key={activity.id} style={{
                                display: 'flex',
                                alignItems: 'center',
                                gap: '1rem',
                                padding: '1rem',
                                background: idx % 2 === 0 ? 'var(--slate-50)' : 'transparent',
                                borderRadius: '8px',
                                transition: 'all 0.2s ease',
                                borderLeft: `3px solid ${activity.action.includes('CREATE') ? '#10b981' : '#3b82f6'}`
                            }}>
                                <div style={{
                                    width: '40px',
                                    height: '40px',
                                    borderRadius: '50%',
                                    background: activity.action.includes('CREATE') ? '#d1fae5' : '#dbeafe',
                                    display: 'flex',
                                    alignItems: 'center',
                                    justifyContent: 'center',
                                    fontSize: '1.25rem',
                                    flexShrink: 0
                                }}>
                                    {activity.action.includes('STUDENT') ? '👨‍🎓' : '👨‍🏫'}
                                </div>
                                <div style={{ flex: 1 }}>
                                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                                        <p style={{ margin: 0, fontWeight: '700', color: 'var(--slate-900)', fontSize: '0.95rem' }}>
                                            {activity.details}
                                        </p>
                                        <span style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                                            {new Date(activity.timestamp).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                                        </span>
                                    </div>
                                    <p style={{ margin: 0, fontSize: '0.8rem', color: 'var(--text-secondary)' }}>
                                        Action: <span style={{ fontWeight: '600' }}>{activity.action.replace(/_/g, ' ')}</span> • by {activity.username}
                                    </p>
                                </div>
                            </div>
                        ))
                    )}
                </div>
            </div>
        </div>
    );
};

export default DashboardOverview;
