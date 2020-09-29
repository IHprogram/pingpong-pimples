class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
    @review = Review.find(params[:review_id])
    @comments_count = @review.comments_count
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    @comments_count = Comment.where("review_id = #{@comment.review_id}").length
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, review_id: params[:review_id])
  end
end
