class ReviewsController < ApplicationController
  def index
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:name, :manufacture_id, :type_id, :hardness, :spin_id, :speed_id, :price, :level_id, :evaluation_id, :content, :image).merge(user_id: current_user.id)
  end

end
