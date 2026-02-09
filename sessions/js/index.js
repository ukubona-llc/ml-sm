    (function(){
      const doc=document, win=window, html=doc.documentElement;
      const $=(s,r=doc)=>r.querySelector(s);
      /* Scroll progress */
      const bar=$('.scroll-progress');
      function onScroll(){
        const d=doc.documentElement, max=d.scrollHeight-d.clientHeight;
        const pct=max>0?(d.scrollTop/max)*100:0;
        if(bar) bar.style.width=pct+'%';
      }
      win.addEventListener('scroll', onScroll, {passive:true}); onScroll();
      /* App grid toggle */
      const menu=$('#gridMenu'), btn=$('#menuIcon');
      function open(){ menu.classList.add('active'); menu.setAttribute('aria-hidden','false'); btn.setAttribute('aria-expanded','true'); }
      function close(){ menu.classList.remove('active'); menu.setAttribute('aria-hidden','true'); btn.setAttribute('aria-expanded','false'); }
      if(btn && menu){
        btn.addEventListener('click', e=>{ e.stopPropagation(); menu.classList.contains('active')?close():open(); });
        doc.addEventListener('click', e=>{ if(!menu.contains(e.target) && !btn.contains(e.target)) close(); });
        doc.addEventListener('keydown', e=>{ if(e.key==='Escape') close(); });
        menu.addEventListener('click', e=>{ const a=e.target.closest('a[href]'); if(a) close(); });
      }
      /* Theme toggle + logo swap */
      const LIGHT_LOGO='https://abikesa.github.io/logos/assets/ukubona-light.png';
      const DARK_LOGO ='https://abikesa.github.io/logos/assets/ukubona-dark.png';
      const logo=$('#logo');
      const toggleBtn=$('#toggle-theme');
      function setTheme(theme){
        html.setAttribute('data-theme', theme);
        try{ localStorage.setItem('theme', theme); }catch(_){}
        if(logo) logo.src=(theme==='dark')?DARK_LOGO:LIGHT_LOGO;
        if(toggleBtn) toggleBtn.textContent=(theme==='dark')?'🌙':'🌞';
      }
     
      // Initialize theme with better error handling
      function initTheme() {
        try {
          const saved = localStorage.getItem('theme');
          const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
          return saved || (prefersDark ? 'dark' : 'light');
        } catch {
          return 'dark';
        }
      }
     
      setTheme(initTheme());
     
      if(toggleBtn){
        toggleBtn.addEventListener('click', ()=> {
          const currentTheme = html.getAttribute('data-theme');
          setTheme(currentTheme === 'dark' ? 'light' : 'dark');
        });
      }
     
      // Force visibility of critical elements (GH Pages fix)
      setTimeout(() => {
        const cards = document.querySelectorAll('.card');
        const tables = document.querySelectorAll('table');
        cards.forEach(card => card.style.opacity = '1');
        tables.forEach(table => table.style.visibility = 'visible');
      }, 100);
    })();