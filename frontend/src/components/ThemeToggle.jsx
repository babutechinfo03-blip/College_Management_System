import React from 'react';
import { useTheme } from '../context/ThemeContext';

const ThemeToggle = () => {
    const { theme, toggleTheme } = useTheme();

    return (
        <button
            onClick={toggleTheme}
            className="theme-icon-toggle"
            aria-label={`Switch to ${theme === 'light' ? 'dark' : 'light'} mode`}
            title={`Switch to ${theme === 'light' ? 'dark' : 'light'} mode`}
        >
            <span className="theme-icon">{theme === 'light' ? '🌙' : '☀️'}</span>

            <style>{`
                .theme-icon-toggle {
                    background: var(--card-bg);
                    border: 1px solid var(--border);
                    cursor: pointer;
                    width: 40px;
                    height: 40px;
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    transition: var(--transition);
                    font-size: 1.25rem;
                    box-shadow: var(--shadow-sm);
                    color: var(--text-main);
                }

                .theme-icon-toggle:hover {
                    border-color: var(--primary);
                    transform: scale(1.1);
                    box-shadow: var(--shadow-md);
                }

                .theme-icon {
                    line-height: 1;
                    user-select: none;
                }
            `}</style>
        </button>
    );
};

export default ThemeToggle;
