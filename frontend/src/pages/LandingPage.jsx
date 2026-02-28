import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import ThemeToggle from '../components/ThemeToggle';

const LandingPage = () => {
  const navigate = useNavigate();
  const [scrolled, setScrolled] = useState(false);

  useEffect(() => {
    const handleScroll = () => setScrolled(window.scrollY > 20);
    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  return (
    <div className="landing-wrapper" style={{ minHeight: '100vh', background: 'var(--slate-50)' }}>
      <header
        className="navbar container"
        style={{
          background: scrolled ? 'rgba(255, 255, 255, 0.95)' : 'transparent',
          borderBottomColor: scrolled ? 'var(--border)' : 'transparent',
          padding: '0 4rem'
        }}
      >
        <div className="logo" style={{ fontSize: '1.75rem', fontWeight: '900', color: 'var(--slate-900)' }}>
          Elite<span style={{ color: 'var(--primary)' }}>Uni</span>
        </div>
        <div style={{ marginLeft: 'auto', display: 'flex', gap: '1.5rem', alignItems: 'center' }}>
          <ThemeToggle />
          <button className="btn btn-primary" onClick={() => navigate('/institution')} style={{ padding: '0.7rem 1.75rem' }}>Login to System</button>
        </div>
      </header>

      <main className="container" style={{ paddingTop: '180px', paddingBottom: '100px' }}>
        <div className="animate-fade-in" style={{ textAlign: 'center', marginBottom: '6rem' }}>
          <h1 style={{
            fontSize: '4.5rem',
            fontWeight: '800',
            color: 'var(--text-main)',
            marginBottom: '1.5rem',
            letterSpacing: '-0.02em',
            lineHeight: '1.2'
          }}>
            Digital College <br />
            <span style={{ color: 'var(--primary)' }}>Management System</span>
          </h1>
          <span style={{
            background: 'var(--primary-light)',
            color: 'var(--primary)',
            padding: '0.5rem 1rem',
            borderRadius: '100px',
            fontSize: '0.875rem',
            fontWeight: '700',
            textTransform: 'uppercase',
            letterSpacing: '1px',
            marginBottom: '2rem',
            display: 'inline-block'
          }}>
            Institutional Intelligence Platform
          </span>
          <div style={{ display: 'none' }}>
          </div>
          <div style={{ display: 'none' }}>
          </div>
        </div>

        <div className="grid grid-cols-2 gap-lg" style={{ marginTop: '4rem' }}>
          <div className="card animate-fade-in" style={{ padding: '3rem', display: 'flex', flexDirection: 'column', height: '100%' }}>
            <div style={{ background: 'var(--primary-light)', width: '64px', height: '64px', borderRadius: '16px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', marginBottom: '2rem' }}>🏛️</div>
            <h3 style={{ fontSize: '2rem', marginBottom: '1rem' }}>Office & Administration</h3>
            <p style={{ color: 'var(--text-secondary)', fontSize: '1.1rem', marginBottom: '2.5rem', flex: 1 }}>
              Manage students, faculty, records, and daily operations with precision and ease. A centralized hub for all administrative tasks.
            </p>
            <button className="btn btn-primary" onClick={() => navigate('/institution')}>Enter Office Panel</button>
          </div>

          <div className="card animate-fade-in" style={{ padding: '3rem', borderLeft: '4px solid var(--primary)', display: 'flex', flexDirection: 'column', height: '100%' }}>
            <div style={{ background: 'var(--primary-light)', width: '64px', height: '64px', borderRadius: '16px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', marginBottom: '2rem' }}>🎓</div>
            <h3 style={{ fontSize: '2rem', marginBottom: '1rem' }}>Student Dashboard</h3>
            <p style={{ color: 'var(--text-secondary)', fontSize: '1.1rem', marginBottom: '2.5rem', flex: 1 }}>
              View attendance, assignments, results, and academic details in real-time. Your personal workspace for academic growth.
            </p>
            <button className="btn btn-secondary" style={{ borderColor: 'var(--primary)', color: 'var(--primary)' }} onClick={() => navigate('/portal')}>Open Student Dashboard</button>
          </div>
        </div>
      </main>

      <footer style={{ background: 'var(--white)', padding: '6rem 0 3rem', borderTop: '1px solid var(--border)' }}>
        <div className="container">
          <div className="grid grid-cols-2" style={{ marginBottom: '4rem' }}>
            <div>
              <div className="logo" style={{ fontSize: '1.5rem', marginBottom: '1.5rem' }}>EliteUni</div>
              <p style={{ color: 'var(--text-muted)', maxWidth: '300px' }}>Empowering the next generation of academic leadership.</p>
            </div>
            <div style={{ textAlign: 'right', display: 'flex', gap: '3rem', justifyContent: 'flex-end' }}>
              <div>
                <h4 style={{ marginBottom: '1rem', fontSize: '0.875rem', textTransform: 'uppercase', letterSpacing: '1px' }}>Product</h4>
                <p style={{ color: 'var(--text-muted)' }}>Features</p>
                <p style={{ color: 'var(--text-muted)' }}>Security</p>
              </div>
              <div>
                <h4 style={{ marginBottom: '1rem', fontSize: '0.875rem', textTransform: 'uppercase', letterSpacing: '1px' }}>Legal</h4>
                <p style={{ color: 'var(--text-muted)' }}>Privacy</p>
                <p style={{ color: 'var(--text-muted)' }}>Terms</p>
              </div>
            </div>
          </div>
          <div style={{ borderTop: '1px solid var(--border)', paddingTop: '2rem', textAlign: 'center', color: 'var(--text-muted)', fontSize: '0.875rem' }}>
            © 2026 Elite University Management System. Crafted for excellence.
          </div>
        </div>
      </footer>
    </div>
  );
};

export default LandingPage;
