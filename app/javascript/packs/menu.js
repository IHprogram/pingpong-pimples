document.addEventListener('DOMContentLoaded', function() {
  const menuBtn = document.getElementById('menu-btn');
  const nav = document.getElementById('nav-id');

  menuBtn.addEventListener('click', () => {
    nav.classList.toggle('open-menu');
    menuBtn.classList.toggle('active');
  });
});