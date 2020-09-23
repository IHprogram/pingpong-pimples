window.addEventListener('load', function() {
  const likeBtn = document.getElementById("like-btn");
  const likeIcon = document.getElementById("like-icon")
  likeBtn.addEventListener('click', function(){
    if (likeIcon.getAttribute("style") == "color: #F00;"){
      likeIcon.removeAttribute("style", "color: #F00;");
    } else {
      likeIcon.setAttribute("style", "color: #F00;");
    }
  });
})