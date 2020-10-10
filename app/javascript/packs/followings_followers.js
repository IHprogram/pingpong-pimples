document.addEventListener('DOMContentLoaded', function() {
  const followingsNumber = document.getElementById('followings-number');
  const followersNumber = document.getElementById('followers-number');
  
  followingsNumber.addEventListener('mouseover', () => {
    followingsNumber.setAttribute('style', 'background-color: #696969;')
  });
  
  followingsNumber.addEventListener('mouseout', () => {
    followingsNumber.removeAttribute('style', 'background-color: #696969;')
  });
  
  
  followersNumber.addEventListener('mouseover', () => {
    followersNumber.setAttribute('style', 'background-color: #696969;')
  });
  
  followersNumber.addEventListener('mouseout', () => {
    followersNumber.removeAttribute('style', 'background-color: #696969;')
  });

  const followings =document.getElementById('followings-wrapper');

  followingsNumber.addEventListener('click', () => {
    followings.classList.toggle('open-followings')
  });

});