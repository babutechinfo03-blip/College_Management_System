import React, { useState } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

const roleConfig = {
  'principal-login': {
    title: 'Executive Admin',
    subtitle: 'Principal and Leadership Portal',
    hint: 'Executive ID',
    back: '/institution',
    endpoint: '/auth/principal/login',
    color: 'var(--primary)'
  },
  'office-login': {
    title: 'Office Operations',
    subtitle: 'Data & Record Management',
    hint: 'Office ID',
    back: '/institution',
    endpoint: '/auth/office/login',
    color: 'var(--primary-dark)'
  },
  'staff-login': {
    title: 'Faculty Access',
    subtitle: 'Academic Management System',
    hint: 'Faculty ID',
    back: '/institution',
    endpoint: '/auth/staff/login',
    color: 'var(--primary-dark)'
  },
  'assistant-login': {
    title: 'Operations Staff',
    subtitle: 'Support & Service Portal',
    hint: 'Staff ID',
    back: '/institution',
    endpoint: '/auth/assistant/login',
    color: 'var(--text-secondary)'
  },
  'student-login': {
    title: 'Student Hub',
    subtitle: 'Personal Academic Workspace',
    hint: 'Roll Number',
    back: '/portal',
    endpoint: '/auth/student/login',
    color: 'var(--primary)'
  },
  'parent-login': {
    title: 'Parent Gateway',
    subtitle: 'Academic Insights & Growth',
    hint: 'Guardian ID',
    back: '/portal',
    endpoint: '/auth/parent/login',
    color: '#be185d'
  }
};

const LoginPage = () => {
  const { role } = useParams();
  const navigate = useNavigate();
  const { login } = useAuth();
  const [formData, setFormData] = useState({ id: '', password: '' });
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const config = roleConfig[role] || { title: 'Secure Login', subtitle: 'Access your portal', hint: 'User ID', back: '/', endpoint: '/auth/login', color: 'var(--primary)' };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setLoading(true);
    try {
      const user = await login(formData.id, formData.password, config.endpoint);
      const rolePathMap = {
        'PRINCIPAL': '/principal',
        'OFFICE': '/office',
        'HOD': '/staff',
        'FACULTY': '/staff',
        'STUDENT': '/student',
        'PARENT': '/parent',
        'ASSISTANT_STAFF': '/assistant'
      };
      window.location.href = rolePathMap[user.role] || '/';
    } catch (err) {
      setError(err.response?.data?.message || 'The credentials you entered are incorrect. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="flex-center" style={{ minHeight: '100vh', background: 'var(--bg-main)', padding: '2rem' }}>
      <div className="card animate-fade-in" style={{ width: '100%', maxWidth: '480px', padding: '3.5rem', boxShadow: 'var(--shadow-premium)', background: 'var(--card-bg)' }}>
        <Link to={config.back} style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', color: 'var(--text-main)', textDecoration: 'none', fontSize: '0.875rem', marginBottom: '2.5rem', fontWeight: '700' }}>
          <span style={{ fontSize: '1.2rem' }}>←</span> Back to selection
        </Link>

        <div style={{ marginBottom: '2.5rem' }}>
          <h2 style={{ fontSize: '2.25rem', marginBottom: '0.5rem', color: 'var(--text-main)' }}>{config.title}</h2>
          <p style={{ color: 'var(--text-secondary)', fontWeight: '500' }}>{config.subtitle}</p>
        </div>

        {error && (
          <div className="animate-fade-in" style={{ padding: '1rem', background: '#fff1f2', borderLeft: '4px solid var(--error)', color: '#991b1b', borderRadius: '4px', marginBottom: '2rem', fontSize: '0.9rem', fontWeight: '500' }}>
            {error}
          </div>
        )}

        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label style={{ color: 'var(--text-main)', textTransform: 'uppercase', letterSpacing: '0.5px', fontSize: '0.75rem' }}>{config.hint}</label>
            <input
              type="text"
              className="form-control"
              placeholder={`e.g. ${role === 'student-login' ? '23BCS101' : 'USR_42'}`}
              value={formData.id}
              onChange={(e) => setFormData({ ...formData, id: e.target.value })}
              required
              style={{ padding: '1rem' }}
            />
          </div>
          <div className="form-group" style={{ marginBottom: '2rem' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '0.5rem' }}>
              <label style={{ color: 'var(--text-main)', textTransform: 'uppercase', letterSpacing: '0.5px', fontSize: '0.75rem', marginBottom: '0' }}>Security Password</label>
              <a href="#" style={{ fontSize: '0.75rem', color: 'var(--primary)', textDecoration: 'none', fontWeight: '600' }}>Forgot?</a>
            </div>
            <input
              type="password"
              className="form-control"
              placeholder="••••••••••••"
              value={formData.password}
              onChange={(e) => setFormData({ ...formData, password: e.target.value })}
              required
              style={{ padding: '1rem' }}
            />
          </div>
          <button
            type="submit"
            className="btn btn-primary btn-block login-submit-btn"
            style={{
              padding: '1.2rem',
              background: config.color,
              fontSize: '1.1rem',
              border: 'none',
              borderRadius: 'var(--radius)',
              color: 'white',
              fontWeight: '700',
              boxShadow: `0 8px 20px -6px ${config.color === 'var(--primary)' ? 'rgba(59, 130, 246, 0.5)' : 'rgba(0,0,0,0.3)'}`,
              transition: 'var(--transition)'
            }}
            disabled={loading}
          >
            {loading ? (
              <span style={{ display: 'flex', gap: '0.5rem', alignItems: 'center', justifyContent: 'center' }}>
                <span className="spinner" style={{ width: '18px', height: '18px', border: '2px solid rgba(255,255,255,0.3)', borderTopColor: 'white', borderRadius: '50%', animation: 'spin 0.8s linear infinite' }}></span>
                Authenticating...
              </span>
            ) : (
              <span>Sign into {config.title.split(' ')[0]} <span style={{ marginLeft: '0.5rem' }}>→</span></span>
            )}
          </button>

          <p style={{ textAlign: 'center', marginTop: '2.5rem', color: 'var(--text-muted)', fontSize: '0.875rem' }}>
            Protected by EliteUni Secure Gateway. <br />
            <Link to="/" style={{ color: 'var(--primary)', fontWeight: '600', textDecoration: 'none' }}>System Status</Link>
          </p>
        </form>
      </div>
      <style>{`
                @keyframes spin { to { transform: rotate(360deg); } }
            `}</style>
    </div>
  );
};

export default LoginPage;
