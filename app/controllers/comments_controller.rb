class CommentsController < ApplicationController
  before_action :set_comment, only: :destroy

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
  end

  def destroy
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, review_id: params[:review_id])
  end

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end

end
