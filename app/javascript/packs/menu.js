window.addEventListener('load', function(){
  const btn = document.getElementById('menu-btn');
  const nav = document.getElementById('nav-id');

  btn.addEventListener('click', () => {
    nav.classList.toggle('open-menu')
  });
});