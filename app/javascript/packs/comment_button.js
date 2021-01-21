if (document.URL.match( /reviews/ )) {
  document.addEventListener('DOMContentLoaded', function(){
    const commentForm = document.getElementById('comment_content');
    const commentBtn = document.getElementById('comment-button');
  
    commentForm.addEventListener('change', function() {
      let commentContent = commentForm.value;
      if (commentContent == "" ) {
        commentBtn.classList.remove('open-btn');
        commentBtn.classList.add('close-btn');
      }else{
        commentBtn.classList.remove('close-btn');
        commentBtn.classList.add('open-btn');
      };
    });
    

    commentBtn.addEventListener('click', function() {
      let commentContent = commentForm.value;
      if (commentContent == "" ) {
        commentBtn.classList.remove('open-btn');
        commentBtn.classList.add('close-btn');
      };
    });
  });
}
