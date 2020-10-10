document.addEventListener('DOMContentLoaded', function() {
  //フォロー数、フォロワー数にマウスを乗せた場合、背景色が変わる
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
  // フォロー数、フォロワー数にマウスを乗せた場合、背景色が変わる

  // フォロー数、フォロワー数をクリックすると、フォロー一覧、フォロワー一覧が表示される
    const followings = document.getElementById('followings-wrapper');
    const followers = document.getElementById('followers-wrapper');
    const followingsCloseBtn = document.getElementById('followings-close-btn');
    const followersCloseBtn = document.getElementById('followers-close-btn');

    followingsNumber.addEventListener('click', () => {
      followings.classList.toggle('open-follow')
    });

    followersNumber.addEventListener('click', () => {
      followers.classList.toggle('open-follow')
    });

    followingsCloseBtn.addEventListener('click', () => {
      followings.classList.toggle('open-follow')
    });

    followersCloseBtn.addEventListener('click', () => {
      followers.classList.toggle('open-follow')
    });
  // フォロー数、フォロワー数をクリックすると、フォロー一覧、フォロワー一覧が表示される
});
