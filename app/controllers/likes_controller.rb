class LikesController < ApplicationController
  def create
    @like = current_user.likes.build(review_id: params[:review_id])
    @like.save
    @review = Review.find(params[:review_id])
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, review_id: params[:review_id])
    @like.destroy
    @review = Review.find(params[:review_id])
  end
end
