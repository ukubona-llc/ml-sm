/**
 * shared.js - The Unified Ecosystem Script
 * Handles: Grid Menu, Theme Toggle, Scroll Progress, Footer Injection
 */

document.addEventListener('DOMContentLoaded', () => {
    'use strict';

    // --- 1. THE GRID MENU (The "Fucking Broken" Part) ---
    const menuBtn = document.getElementById('menuIcon');
    const menuGrid = document.getElementById('gridMenu');

    if (menuBtn && menuGrid) {
        menuBtn.addEventListener('click', (e) => {
            e.preventDefault();
            e.stopPropagation();
            
            const isActive = menuGrid.classList.toggle('active');
            
            // Manual override to bypass any CSS bracket/specificity issues
            if (isActive) {
                menuGrid.style.display = 'grid';
                menuGrid.style.opacity = '1';
                menuGrid.style.visibility = 'visible';
                menuGrid.style.pointerEvents = 'auto';
                menuGrid.style.transform = 'translateY(0)';
                menuBtn.setAttribute('aria-expanded', 'true');
            } else {
                menuGrid.style.opacity = '0';
                menuGrid.style.visibility = 'hidden';
                menuGrid.style.pointerEvents = 'none';
                menuGrid.style.transform = 'translateY(-10px)';
                menuBtn.setAttribute('aria-expanded', 'false');
            }
        });

        // Close menu when clicking outside
        document.addEventListener('click', (e) => {
            if (!menuGrid.contains(e.target) && !menuBtn.contains(e.target)) {
                menuGrid.classList.remove('active');
                menuGrid.style.opacity = '0';
                menuGrid.style.visibility = 'hidden';
            }
        });
    }

    // --- 2. THEME TOGGLE ---
    const themeBtn = document.getElementById('toggle-theme');
    const savedTheme = localStorage.getItem('theme') || 'dark';
    document.documentElement.setAttribute('data-theme', savedTheme);

    if (themeBtn) {
        themeBtn.addEventListener('click', () => {
            const currentTheme = document.documentElement.getAttribute('data-theme');
            const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
            
            document.documentElement.setAttribute('data-theme', newTheme);
            localStorage.setItem('theme', newTheme);
            themeBtn.textContent = newTheme === 'dark' ? '🌙' : '☀️';
        });
    }

    // --- 3. SCROLL PROGRESS ---
    const progress = document.querySelector('.scroll-progress');
    if (progress) {
        window.addEventListener('scroll', () => {
            const winScroll = document.body.scrollTop || document.documentElement.scrollTop;
            const height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
            const scrolled = (winScroll / height) * 100;
            progress.style.width = scrolled + "%";
        });
    }

    // --- 4. FOOTER INJECTION & CHORUS ROTATION ---
    const footerPlaceholder = document.getElementById('footer-placeholder');
    if (footerPlaceholder) {
        // Determine path base (GitHub Pages vs Local)
        const isSubDir = window.location.pathname.includes('/sessions/html/');
        const footerPath = isSubDir ? '../html/footer.html' : 'sessions/html/footer.html';

        fetch(footerPath)
            .then(response => {
                if (!response.ok) throw new Error('Footer missing');
                return response.text();
            })
            .then(data => {
                footerPlaceholder.innerHTML = data;
                initFooterChorus(); // Start rotation once loaded
            })
            .catch(err => console.warn("Footer load failed:", err));
    }

    function initFooterChorus() {
        const box = document.querySelector('.rotating-chorus');
        if (!box) return;
        
        const chips = Array.from(box.querySelectorAll('.chip'));
        if (chips.length === 0) return;

        let currentIndex = 0;
        // Hide all but first
        chips.forEach((chip, idx) => chip.style.display = idx === 0 ? 'inline' : 'none');

        setInterval(() => {
            chips[currentIndex].style.display = 'none';
            currentIndex = (currentIndex + 1) % chips.length;
            chips[currentIndex].style.display = 'inline';
        }, 5000);
    }
});