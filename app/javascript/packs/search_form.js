document.addEventListener('DOMContentLoaded', function() {
  const searchLabel = document.querySelectorAll('.search-label');
  const searchSelectWrapper = document.querySelectorAll('.search-select-wrapper');

  for (let i = 0; i <= 2; i++) { 
  //各項目名（ラバーの種類、メーカー、価格）にマウスカーソルを乗せた場合、背景色が変わる
    searchLabel[i].addEventListener('mouseover', () => {
      searchLabel[i].setAttribute('style', 'background-color: #ffffff;')
    });
  //各項目名（ラバーの種類、メーカー、価格）にマウスカーソルを乗せた場合、背景色が変わる

  //各項目名（ラバーの種類、メーカー、価格）からマウスカーソルを離した場合、背景色が元に戻る
    searchLabel[i].addEventListener('mouseout', () => {
      searchLabel[i].removeAttribute('style', 'background-color: #ffffff;')
    });
  //各項目名（ラバーの種類、メーカー、価格）からマウスカーソルを離した場合、背景色が元に戻る
  
  //各項目名（ラバーの種類、メーカー、価格）をクリックすると、各項目の選択肢（ラジオボタン）を開閉できる
    searchLabel[i].addEventListener('click', () => {
      searchSelectWrapper[i].classList.toggle('open-button');
    });
  //各項目名（ラバーの種類、メーカー、価格）をクリックすると、各項目の選択肢（ラジオボタン）を開閉できる
  };
});